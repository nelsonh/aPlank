//
//  CharacterShadow.h
//  aPlank
//
//  Created by Nelson on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Actor.h"

@interface CharacterShadow : Actor {
	
	//contain shadows parts CCSprite
	NSMutableSet *shadowParts;
	
	//true:visible, follow player touch, collision
	BOOL shadowEnabled;
	
	/*a real position mainpulate by player, if any shadows collide with other object then 
	real position will restore to last position CCNode should update base on this position*/
	CGPoint realPosition;
	
	//last position
	CGPoint lastPosition;
	
	//angle for shadow in degree
	float shadowAngle;
	
	//indicate any part of shadow has collide with other object;
	BOOL shadowCollided;
}

@property (nonatomic, retain) NSMutableSet *shadowParts;
@property (nonatomic, readwrite, assign) BOOL shadowEnabled;
@property (nonatomic, readwrite, assign) CGPoint realPosition;
@property (nonatomic, readwrite, assign) CGPoint lastPosition;
@property (nonatomic, readwrite, assign) float shadowAngle;
@property (nonatomic, readwrite, assign) BOOL shadowCollided;

+(id)spawnAtPoint:(CGPoint)spawnPos;
-(id)initWithPosition:(CGPoint)pos;
-(void)createShadowParts;
-(void)update:(ccTime)dt;
-(void)enableShadow;
-(void)disableShadow;

@end
