//
//  Actor.h
//  aPlank
//
//  Created by Nelson on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "Common.h"
#import "Helper.h"

@interface Actor : CCNode {
	
	//child actors
	NSMutableSet *actors;
	
	//child components
	NSMutableSet *components;
	
	//sprite represent actor assign 
	CCSprite *sprite;
	
	//owner who own this actor
	Actor *owner;
	
	//main physical body component
	b2Body *bodyComponent;
	
	//allow body sleep true default
	bool bodySleepAllowed;
}

@property (nonatomic, retain) NSMutableSet *actors;
@property (nonatomic, retain) NSMutableSet *components;
@property (nonatomic, readwrite, assign) CCSprite *sprite;
@property (nonatomic, assign) Actor *owner;
@property (nonatomic, readwrite, assign) b2Body *bodyComponent;
@property (nonatomic, readwrite, assign) bool bodySleepAllowed;



-(void)attachChildActor:(Actor*)childActor toPosition:(CGPoint)pos;
-(void)detachChildActor:(Actor*)childActor clean:(BOOL)yesOrNo;
-(void)detachChildActor:(Actor*)childActor clean:(BOOL)yesOrNo toScenePosition:(CGPoint)pos;
-(void)removeChildActor:(Actor*)childActor;
-(BOOL)collideWithRect:(CGRect)rectBoundingBox;
-(void)destroy;

@end
