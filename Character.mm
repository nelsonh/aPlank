//
//  Character.m
//  aPlank
//
//  Created by Nelson on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "PlankScene.h"


@implementation Character

@synthesize characterShadow;
@synthesize bodyParts;
@synthesize bodyCollisionShape;
@synthesize hasRagdoll;
@synthesize bodyPartWieght;

+(id)spawnAtPoint:(CGPoint)spawnPos
{
	return [[[Character alloc] initWithPosition:spawnPos] autorelease];
}

-(id)initWithPosition:(CGPoint)pos
{
	if((self=[super init]))
	{
		PlankScene *scene=[PlankScene sharedGameScene];
		
		self.characterShadow=[CharacterShadow spawnAtPoint:pos];
		//add to scene not self
		[scene addChild:self.characterShadow];
		
		self.bodyParts=[[[NSMutableArray alloc] init] autorelease];
		self.bodyCollisionShape=[[[NSMutableArray alloc] init] autorelease];
		self.bodyPartWieght=[[[NSMutableArray alloc] init] autorelease];

		[self createWeight];
		
		self.hasRagdoll=NO;
		
		[self scheduleUpdate];
	}
	return self;
}

-(void)createWeight
{
	NSNumber *headWeight=[NSNumber numberWithInt:15];
	[self.bodyPartWieght addObject:headWeight];
	
	NSNumber *body1Weight=[NSNumber numberWithInt:25];
	[self.bodyPartWieght addObject:body1Weight];
	
	NSNumber *body2Weight=[NSNumber numberWithInt:25];
	[self.bodyPartWieght addObject:body2Weight];
	
	NSNumber *legWeight=[NSNumber numberWithInt:5];
	[self.bodyPartWieght addObject:legWeight];
}

-(void)createBodySprite
{
	PlankScene *gameScene=[PlankScene sharedGameScene];
	
	//head part
	BodyPart *headPart=[BodyPart spawnWithFileName:@"pu-head.png"];
	headPart.position=self.characterShadow.position;
	[gameScene addChild:headPart];
	[self.bodyParts addObject:headPart];
	
	//body1 part
	BodyPart *body1Part=[BodyPart spawnWithFileName:@"pu-body1.png"];
	CGPoint sPos=CGPointMake(headPart.position.x-[headPart.sprite boundingBox].size.width/2-[body1Part.sprite boundingBox].size.width/2, headPart.position.y);
	body1Part.position=sPos;
	[gameScene addChild:body1Part];
	[self.bodyParts addObject:body1Part];
	
	//body2 part
	BodyPart *body2Part=[BodyPart spawnWithFileName:@"pu-body2.png"];
	sPos=CGPointMake(body1Part.position.x-[body1Part.sprite boundingBox].size.width/2-[body2Part.sprite boundingBox].size.width/2, body1Part.position.y);
	body2Part.position=sPos;
	[gameScene addChild:body2Part];
	[self.bodyParts addObject:body2Part];
	
	//leg part
	BodyPart *legPart=[BodyPart spawnWithFileName:@"pu-leg.png"];
	sPos=CGPointMake(body2Part.position.x-[body2Part.sprite boundingBox].size.width/2-[legPart.sprite boundingBox].size.width/2, body2Part.position.y);
	legPart.position=sPos;
	[gameScene addChild:legPart];
	[self.bodyParts addObject:legPart];
}

-(void)createPhysicsBody
{
	b2World *physicsWorld=[PlankScene sharedGameScene].physicsWorld;
	
	for(unsigned int j=0; j<[self.bodyParts count]; j++)
	{
		/**
		 create related physics body
		 **/
		BodyPart *cBodyPart=[self.bodyParts objectAtIndex:j];
		
		//create body for sprite
		b2BodyDef bodyPartDef;
		bodyPartDef.type=b2_dynamicBody;
		bodyPartDef.position=[Helper toMeter:cBodyPart.position];
		
		b2Body *pBody=physicsWorld->CreateBody(&bodyPartDef);
		pBody->SetUserData(cBodyPart);
		
		[cBodyPart setBodyComponent:pBody];
		
		//create shape
		b2PolygonShape bodyPartShape;
		bodyPartShape.SetAsBox([cBodyPart.sprite boundingBox].size.width/PTM_RATIO*0.5f, [cBodyPart.sprite boundingBox].size.height/PTM_RATIO*0.5f);

		NSNumber *nWeight=[self.bodyPartWieght objectAtIndex:j];
		int weight=[nWeight intValue];
		
		//create fixture
		b2FixtureDef bodyPartFixtureDef;
		bodyPartFixtureDef.shape=&bodyPartShape;
		bodyPartFixtureDef.density=weight;
		bodyPartFixtureDef.friction=1.5f;
		bodyPartFixtureDef.restitution=0.1f;
		
		pBody->CreateFixture(&bodyPartFixtureDef);
		
		
		/**
		 check if need to joint body to last one
		 **/
		//check by index
		if(j>0)
		{
			/**
			 joint body to last one
			 **/
			
			//-1 to get previous body
			BodyPart *aBodyPart=[self.bodyParts objectAtIndex:j-1];
			b2Body *previousBody=aBodyPart.bodyComponent;
			
			b2RevoluteJointDef jointDef;
			jointDef.lowerAngle=0;
			jointDef.upperAngle=0;
			jointDef.enableLimit=true;
			
			//jointDef.Initialize(previousBody, pBody, b2Vec2(previousBody->GetWorldCenter().x-[cBodyPart.sprite boundingBox].size.width/PTM_RATIO, previousBody->GetWorldCenter().y));
			jointDef.Initialize(previousBody, pBody, b2Vec2(previousBody->GetWorldCenter().x-[aBodyPart.sprite boundingBox].size.width/2/PTM_RATIO, previousBody->GetWorldCenter().y));
			physicsWorld->CreateJoint(&jointDef);
			
		}
		
	}
}

-(void)createRagdoll
{
	[self createBodySprite];
	[self createPhysicsBody];
	
	self.hasRagdoll=YES;
}

-(void)enableRagdollAtPosition:(CGPoint)pixelPoint
{
	/*
	//see if ragdoll is existed
	if(!self.hasRagdoll)
	{
		
		[self createRagdoll];
		

	}
	
	
	//get ragdoll head
	BodyPart *head=[self.bodyParts objectAtIndex:0];
	b2Body *rHead=head.bodyComponent;
	
	//reset head
	rHead->SetTransform([Helper toMeter:pixelPoint],0);
	 */
	
	[self destroyRagdoll];
	[self createRagdoll];
	 
}

-(void)update:(ccTime)dt
{
	//update shadow;
	[self.characterShadow update:dt];
}

-(void)destroyRagdoll
{
	//remove body sprite
	if(self.bodyParts && [self.bodyParts count]!=0)
	{
		for(BodyPart *pBody in self.bodyParts)
		{
			//destroy body part
			[pBody destroy];
		}
		
		[self.bodyParts removeAllObjects];
	}
}

-(void)destroy
{
	//remove body sprite
	if(self.bodyParts && [self.bodyParts count]!=0)
	{
		for(BodyPart *pBody in self.bodyParts)
		{
			//destroy body part
			[pBody destroy];
		}
		
		[self.bodyParts removeAllObjects];
	}
	
	
	[super destroy];
}

-(void)dealloc
{
	self.bodyParts=nil;
	self.bodyCollisionShape=nil;
	self.bodyPartWieght=nil;
	self.characterShadow=nil;
	
	[super dealloc];
}

@end
