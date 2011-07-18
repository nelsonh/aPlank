//
//  Character.h
//  aPlank
//
//  Created by Nelson on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Actor.h"
#import "CharacterShadow.h"
#import "BodyPart.h"


@interface Character : Actor {
	
	//character shadow
	CharacterShadow *characterShadow;
	
	//contain body part Actor
	NSMutableArray *bodyParts;
	
	//body shape
	NSMutableArray *bodyCollisionShape;
	
	//body weight
	NSMutableArray *bodyPartWieght;
	
	BOOL hasRagdoll;
}

@property (nonatomic, retain) CharacterShadow *characterShadow;
@property (nonatomic, retain) NSMutableArray *bodyParts;
@property (nonatomic, retain) NSMutableArray *bodyCollisionShape;
@property (nonatomic, retain) NSMutableArray *bodyPartWieght;
@property (nonatomic, readwrite, assign) BOOL hasRagdoll;

+(id)spawnAtPoint:(CGPoint)spawnPos;
-(id)initWithPosition:(CGPoint)pos;
-(void)createBodySprite;
-(void)createPhysicsBody;
-(void)createRagdoll;
-(void)createWeight;
-(void)enableRagdollAtPosition:(CGPoint)pixelPoint;
-(void)destroyRagdoll;

@end
