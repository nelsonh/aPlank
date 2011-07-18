//
//  GameObject.m
//  aPlank
//
//  Created by Nelson on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "PlankScene.h"

@implementation GameObject

+(id)spawnAtPosition:(CGPoint)spawnPos
{
	return [[GameObject alloc] initWithPosition:spawnPos withSpriteFileName:@"Icon-Small-50.png"];
}

-(id)initWithPosition:(CGPoint)pos withSpriteFileName:(NSString*)spriteFileName
{
	if((self=[super init]))
	{
		//get current game scene
		PlankScene *gameScene=[PlankScene sharedGameScene];
		
		self.sprite=[[[CCSprite alloc] initWithFile:spriteFileName] autorelease];
		self.position=pos;
		[self addChild:self.sprite];
		
		[gameScene addChild:self];
		
		[self createBodyAtPosition:pos];
		
		[self schedule:@selector(tick:)];
	}
	
	return self;
}

-(void)createBodyAtPosition:(CGPoint)bodyPos
{
	b2BodyDef actorBodyDef;
	actorBodyDef.type=b2_dynamicBody;
	actorBodyDef.position=b2Vec2(bodyPos.x/PTM_RATIO, bodyPos.y/PTM_RATIO);
	
	b2World *physicsWorld=[PlankScene sharedGameScene].physicsWorld;
	b2Body *actorBody=physicsWorld->CreateBody(&actorBodyDef);
	actorBody->SetUserData(self);
	actorBody->SetSleepingAllowed(self.bodySleepAllowed);
	self.bodyComponent=actorBody;
	
	CGSize spriteSize=[self.sprite boundingBox].size;
	
	b2PolygonShape actorBodyShape;
	actorBodyShape.SetAsBox((spriteSize.width/PTM_RATIO)*0.5f, (spriteSize.height/PTM_RATIO)*0.5f);
	
	b2FixtureDef actorBodyFixture;
	actorBodyFixture.shape=&actorBodyShape;
	actorBodyFixture.density=2.0f;
	actorBodyFixture.friction=0.1f;
	actorBodyFixture.restitution=0.1f;
	
	actorBody->CreateFixture(&actorBodyFixture);
	
	
}

-(void)tick:(ccTime)dt;
{

}

@end
