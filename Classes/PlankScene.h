//
//  PlankScene.h
//  aPlank
//
//  Created by Nelson on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Common.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "BoneDrawable.h"
#import "Character.h"

@interface PlankScene : CCLayer {
	
	b2World *physicsWorld;
	GLESDebugDraw *debugDraw;
	Character *mainCharacter;
	NSMutableSet *skeletonList;
	NSMutableSet *sceneObjectList;
	
	//bodies will be destroyed every frame;
	NSMutableSet *destroyedBodies;
}

@property (nonatomic, readonly) b2World *physicsWorld;
@property (nonatomic, retain) NSMutableSet *skeletonList;
@property (nonatomic, retain) NSMutableSet *sceneObjectList;
@property (nonatomic, retain) NSMutableSet *destroyedBodies;

+(id)scene;
+(PlankScene*)sharedGameScene;
-(void)createWall;
-(void)createSceneObject;
-(void)destroyBody:(b2Body*)destroyedBody;
-(BOOL)isBodyInDestroy:(b2Body*)inBody;
-(void)enableDebugDraw;
-(void)drawline;
-(void)updatePhysicsWorld:(ccTime)dt;

@end
