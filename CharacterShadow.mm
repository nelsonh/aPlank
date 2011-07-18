//
//  CharacterShadow.m
//  aPlank
//
//  Created by Nelson on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CharacterShadow.h"
#import "PlankScene.h"


@implementation CharacterShadow

@synthesize shadowParts;
@synthesize shadowEnabled;
@synthesize realPosition;
@synthesize lastPosition;
@synthesize shadowAngle;
@synthesize shadowCollided;

+(id)spawnAtPoint:(CGPoint)spawnPos
{
	return [[[CharacterShadow alloc] initWithPosition:spawnPos] autorelease];
}

-(id)initWithPosition:(CGPoint)pos
{
	if((self=[super init]))
	{
		self.position=pos;
		self.shadowParts=[[[NSMutableSet alloc] init] autorelease];
		self.shadowEnabled=NO;
		self.realPosition=pos;
		self.lastPosition=pos;
		self.shadowAngle=0;
		//create shadow parts
		[self createShadowParts];
		
	}
	return self;
}

-(void)createShadowParts
{
	//create head
	CCSprite *headSprite=[[[CCSprite alloc] initWithFile:@"pu-head.png"] autorelease];
	[headSprite setColor:ccGRAY];
	[self addChild:headSprite];
	[self.shadowParts addObject:headSprite];
	
	//create body
	CCSprite *bodySprite=[[[CCSprite alloc] initWithFile:@"pu-body1.png"] autorelease];
	[bodySprite setColor:ccGRAY];
	bodySprite.position=CGPointMake(-([headSprite boundingBox].size.width/2+[bodySprite boundingBox].size.width/2)+1, 0);
	[self addChild:bodySprite];
	[self.shadowParts addObject:bodySprite];
	
	
	//create body2
	CCSprite *body2Sprite=[[[CCSprite alloc] initWithFile:@"pu-body2.png"] autorelease];
	[body2Sprite setColor:ccGRAY];
	body2Sprite.position=CGPointMake(bodySprite.position.x-([bodySprite boundingBox].size.width/2+[body2Sprite boundingBox].size.width/2)+1, 0);
	[self addChild:body2Sprite];
	[self.shadowParts addObject:body2Sprite];
	
	//create leg
	CCSprite *legSprite=[[[CCSprite alloc] initWithFile:@"pu-leg.png"] autorelease];
	[legSprite setColor:ccGRAY];
	legSprite.position=CGPointMake(body2Sprite.position.x-([body2Sprite boundingBox].size.width/2+[legSprite boundingBox].size.width/2)+1, 0);
	[self addChild:legSprite];
	[self.shadowParts addObject:legSprite];
	
}
-(void)enableShadow
{
	//set all shadow visible
	if(self.shadowParts && [self.shadowParts count]!=0)
	{
		for(CCSprite *shadowSprite in self.shadowParts)
		{
			[shadowSprite setVisible:YES];
		}
	}
}

-(void)disableShadow
{
	//set all shadow visible
	if(self.shadowParts && [self.shadowParts count]!=0)
	{
		for(CCSprite *shadowSprite in self.shadowParts)
		{
			[shadowSprite setVisible:NO];
		}
	}
}

-(void)update:(ccTime)dt
{
	if(self.shadowEnabled)
	{
		BOOL collide=NO;
		
		//enable all shadow
		[self enableShadow];
		
		PlankScene *gameScene=[PlankScene sharedGameScene];
		NSArray *sceneObjects=[gameScene.sceneObjectList allObjects];
		
		
		//check if collide with scene object
		for(Actor *sObject in sceneObjects)
		{
			//check each shadow parts
			for(CCSprite *shadowPart in [self.shadowParts allObjects])
			{
				
				//convert to world rect
				CGPoint worldPos=[shadowPart.parent convertToWorldSpace:[shadowPart boundingBox].origin];
				CGRect worldBB=CGRectMake(worldPos.x, worldPos.y, [shadowPart boundingBox].size.width, [shadowPart boundingBox].size.height);
				
				
				if([sObject collideWithRect:worldBB])
				{
					[shadowPart setColor:ccRED];
					collide=YES;
				}
				else 
				{
					[shadowPart setColor:ccGRAY];
				}
			}
		}
		
		//check if out of screen
		for(CCSprite *pShadow in [self.shadowParts allObjects])
		{
			//convert to world rect
			CGPoint worldPos=[pShadow.parent convertToWorldSpace:[pShadow boundingBox].origin];
			CGRect worldBB=CGRectMake(worldPos.x, worldPos.y, [pShadow boundingBox].size.width, [pShadow boundingBox].size.height);
			
			if([Helper isOutOfScreen:worldBB])
			{
				collide=YES;
			}

		}
		
		self.shadowCollided=collide;
		
		self.lastPosition=self.realPosition;
		
		//update shadow position and angle
		self.position=self.realPosition;
		self.rotation=self.shadowAngle;
	}
	else 
	{
		[self disableShadow];
	}

	
}

-(void)destroy
{
	if(self.shadowParts)
	{
		//remove each from scene graph
		for(CCSprite *shadowPart in [self.shadowParts allObjects])
		{
			CCNode *node=shadowPart.parent;
			[shadowPart removeAllChildrenWithCleanup:NO];
			[node removeChild:shadowPart cleanup:NO];
		}
		
		//remove all from set
		[self.shadowParts removeAllObjects];
	}
	
	[super destroy];
}

-(void)dealloc
{
	self.shadowParts=nil;
	
	[super dealloc];
}

@end
