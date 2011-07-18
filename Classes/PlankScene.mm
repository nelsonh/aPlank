//
//  PlankScene.m
//  aPlank
//
//  Created by Nelson on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlankScene.h"
#import "Actor.h"
#import "HumanSkeleton.h"
#import "Wood.h"


@implementation PlankScene

@synthesize physicsWorld;
@synthesize skeletonList;
@synthesize sceneObjectList;
@synthesize destroyedBodies;

static PlankScene *plankSceneInstance=nil;

+(id)scene
{
	CCScene *scene=[CCScene node];
	PlankScene *layer=[PlankScene node];
	[layer setTag:KMainLayer];
	[scene addChild:layer];
	
	return scene;
}

+(PlankScene*)sharedGameScene
{
	NSAssert(plankSceneInstance!=nil, @"Instance is not existed");
	return plankSceneInstance;
}

-(id)init
{
	if((self=[super init]))
	{
		plankSceneInstance=self;
		
		self.isTouchEnabled=YES;
		self.isAccelerometerEnabled=YES;

		//setup world physics
		b2Vec2 gravity=b2Vec2(0.0f, -9.8f);
		bool allowSleep=false;
		
		//create physics world
		physicsWorld=new b2World(gravity, allowSleep);
		//physicsWorld->SetContinuousPhysics(true);
		
		//[self enableDebugDraw];
		
		//create static wall
		[self createWall];
	
		self.sceneObjectList=[[[NSMutableSet alloc] init] autorelease];
		self.skeletonList=[[[NSMutableSet alloc] init] autorelease];
		self.destroyedBodies=[[[NSMutableSet alloc] init] autorelease];
		
		//create scene object
		[self createSceneObject];
		
		//create character
		mainCharacter=[Character spawnAtPoint:CGPointMake(480/2-100, 320/2)];
		[self addChild:mainCharacter];
		
		/*
		HumanSkeleton *humanSk=[[[HumanSkeleton alloc] initWithStartPoint:CGPointMake(480/2, 320/2-100) BoneLength:40.0f BoneAngle:90] autorelease];
		[humanSk setBoneRenderWidth:2.0f];
		[humanSk setBoneRenderingColor:1.0f Green:1.0f Blue:0.0f Alpha:1.0f];
		[skeletonList addObject:humanSk];
		*/
		
		[self scheduleUpdate];
	}
	
	return self;
}

-(void)createWall
{
	
	CGSize screenSize=[CCDirector sharedDirector].winSize;
	
	//define body
	b2BodyDef wall;
	wall.type=b2_staticBody;
	
	b2Body *wallBody=physicsWorld->CreateBody(&wall);
	
	//define shape
	b2PolygonShape wallShape;
	
	
	//bottm wall
	wallShape.SetAsEdge(b2Vec2(0.0f, 0.0f), b2Vec2(screenSize.width/PTM_RATIO, 0.0f));
	wallBody->CreateFixture(&wallShape, 0);
	
	//left wall
	wallShape.SetAsEdge(b2Vec2(0.0f, 0.0f), b2Vec2(0.0f, screenSize.height/PTM_RATIO));
	wallBody->CreateFixture(&wallShape, 0);
	
	//right wall
	wallShape.SetAsEdge(b2Vec2(screenSize.width/PTM_RATIO, 0.0f), b2Vec2(screenSize.width/PTM_RATIO, screenSize.height/PTM_RATIO));
	wallBody->CreateFixture(&wallShape, 0);
	
	//top wall
	wallShape.SetAsEdge(b2Vec2(0.0f, screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO, screenSize.height/PTM_RATIO));
	wallBody->CreateFixture(&wallShape, 0);
}

-(void)createSceneObject
{
	Wood *woodObject=[Wood spawnAtPoint:CGPointMake(480/2, 320/2-100)];
	[self addChild:woodObject];
	[self.sceneObjectList addObject:woodObject];
}

-(void)destroyBody:(b2Body*)destroyedBody
{
	NSAssert(destroyedBody!=nil, @"body is nil");
	
	if(destroyedBody!=nil && ![self isBodyInDestroy:destroyedBody])
	{
		//add body to destroy set
		NSValue *bodyValue=[NSValue valueWithPointer:destroyedBody];
		[destroyedBodies addObject:bodyValue];
	}
	
}

-(BOOL)isBodyInDestroy:(b2Body*)inBody
{
	NSArray *removedBodies=[destroyedBodies allObjects];
	
	for(NSValue *bodyValue in removedBodies)
	{
		b2Body *removedBody=(b2Body*)[bodyValue pointerValue];
		
		if(removedBody==inBody)
		{
			return YES;
		}
	}
	
	return NO;
}

-(void)update:(ccTime)dt
{
	if([[self.destroyedBodies allObjects] count]>0)
	{
		for(NSValue *rBody in [self.destroyedBodies allObjects])
		{
			b2Body *removedBody=(b2Body*)[rBody pointerValue];
			physicsWorld->DestroyBody(removedBody);
		}
		
		[self.destroyedBodies removeAllObjects];
	}

		
	[self updatePhysicsWorld:dt];
	
}

-(void)updatePhysicsWorld:(ccTime)dt
{
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	physicsWorld->Step(dt, velocityIterations, positionIterations);
	
	for (b2Body* b = physicsWorld->GetBodyList(); b; b = b->GetNext())
	{
		if(b->GetUserData()!=NULL)
		{
			Actor *gActor=(Actor*)b->GetUserData();
			
			if(gActor.sprite)
			{
				gActor.position=[Helper toPixel:b->GetPosition()];
				gActor.rotation=-1*CC_RADIANS_TO_DEGREES(b->GetAngle());
			}
			
		}
	}
}

-(void)enableDebugDraw
{
	// Debug Draw functions
	debugDraw = new GLESDebugDraw( PTM_RATIO );
	physicsWorld->SetDebugDraw(debugDraw);
	
	uint32 flags = 0;
	flags += b2DebugDraw::e_shapeBit;
	flags += b2DebugDraw::e_jointBit;
	//		flags += b2DebugDraw::e_aabbBit;
	//		flags += b2DebugDraw::e_pairBit;
	//		flags += b2DebugDraw::e_centerOfMassBit;
	debugDraw->SetFlags(flags);	
}

-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	physicsWorld->DrawDebugData();
	
	for(Bone *humanSK in [skeletonList allObjects])
	{
		[humanSK drawBone];
	}
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
}

-(void)drawline
{
	glColor4f(0.8, 1.0, 0.76, 1.0);  
    glLineWidth(4.0f);
	static float angle;
	angle+=1.0f;
	
	float length=20;
	CGPoint firstPoint=CGPointMake(100, 40);
	CGPoint secPoint=CGPointMake(firstPoint.x+length*cosf(CC_DEGREES_TO_RADIANS(angle)), firstPoint.y+length*sinf(CC_DEGREES_TO_RADIANS(angle)));
    ccDrawLine(firstPoint, secPoint);
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	
	if([[UIDevice currentDevice] orientation]==4 || [[UIDevice currentDevice] orientation]==5)
	{
		b2Vec2 gravity=b2Vec2(0.0f, -5.8f);
		physicsWorld->SetGravity(gravity);
		
		return;
	}
	
	float accX=acceleration.x;
	float accY=acceleration.y;
	
	
	if(accX>=-0.6f)
		accX=-0.6f;
	
	if(accY>=0.7f)
		accY=0.7f;
	else if(accY<=-0.7f)
		accY=-0.7f;
		
	if(accX==0.0f && accY==0.0f)
		return;
	
	//NSLog(@"accx:%f", accX);
	//NSLog(@"accy:%f", accY);
	
	b2Vec2 gravity=b2Vec2(-accY*4.0f, accX*4.0f);
	physicsWorld->SetGravity(gravity);
	
	NSLog(@"gravityX:%f",gravity.x);
	NSLog(@"gravityY:%f", gravity.y);

}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[mainCharacter.characterShadow setShadowEnabled:YES];

	//move character to touch position
	UITouch *touch=[touches anyObject];
	CGPoint touchLocInView=[touch locationInView:[touch view]];
	CGPoint touchLocGL=[[CCDirector sharedDirector] convertToGL:touchLocInView];
	
	[mainCharacter.characterShadow setRealPosition:touchLocGL];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[mainCharacter.characterShadow setShadowEnabled:YES];
	
	UITouch *touch=[touches anyObject];
	CGPoint touchLocInView=[touch locationInView:[touch view]];
	CGPoint touchLocGL=[[CCDirector sharedDirector] convertToGL:touchLocInView];
	
	[mainCharacter.characterShadow setRealPosition:touchLocGL];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[mainCharacter.characterShadow setShadowEnabled:NO];
	
	UITouch *touch=[touches anyObject];
	CGPoint touchLocInView=[touch locationInView:[touch view]];
	CGPoint touchLocGL=[[CCDirector sharedDirector] convertToGL:touchLocInView];
	
	if(mainCharacter.characterShadow.shadowCollided!=YES)
	{
		[mainCharacter enableRagdollAtPosition:touchLocGL];
	}
	
}

-(void)dealloc
{
	delete physicsWorld;
	physicsWorld=NULL;
	
	self.sceneObjectList=nil;
	self.skeletonList=nil;
	self.destroyedBodies=nil;
	
	[super dealloc];
}

@end
