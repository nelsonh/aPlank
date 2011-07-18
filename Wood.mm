//
//  Wood.mm
//  aPlank
//
//  Created by Nelson on 7/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Wood.h"
#import "PlankScene.h"

@implementation Wood

+(id)spawnAtPoint:(CGPoint)spawnPos
{
	return [[[Wood alloc] initWithPosition:spawnPos] autorelease];
}

-(id)initWithPosition:(CGPoint)pos
{
	if((self=[super init]))
	{
		self.sprite=[[[CCSprite alloc] initWithFile:@"pivot.png"] autorelease];
		[self addChild:self.sprite];
		
		self.position=pos;
		
		[self createPhysicsBody];
	}
	return self;
}

-(void)createPhysicsBody
{
	b2World *physicsWorld=[PlankScene sharedGameScene].physicsWorld;
	
	//physics body def
	b2BodyDef woodBodyDef;
	woodBodyDef.type=b2_staticBody;
	woodBodyDef.position=[Helper toMeter:self.position];
	woodBodyDef.fixedRotation=true;
	
	b2Body *woodBody=physicsWorld->CreateBody(&woodBodyDef);
	woodBody->SetUserData(self);
	self.bodyComponent=woodBody;
	
	//shape
	b2Vec2 pivotVerts[] = {
		b2Vec2(13.2f / PTM_RATIO, -47.7f / PTM_RATIO),
		b2Vec2(-1.2f / PTM_RATIO, 47.5f / PTM_RATIO),
		b2Vec2(-12.5f / PTM_RATIO, -47.5f / PTM_RATIO)
	};
	
	b2PolygonShape woodShape;
	woodShape.Set(pivotVerts, 3);
	
	/*
	//fixture
	b2FixtureDef woodFixtureDef;
	woodFixtureDef.shape=&woodShape;
	woodFixtureDef.density=500.0f;
	woodFixtureDef.friction=1.0f;
	woodFixtureDef.restitution=0.1f;
	 */
	
	woodBody->CreateFixture(&woodShape, 0);
}

@end
