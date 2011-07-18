//
//  Bone.h
//  aPlank
//
//  Created by Nelson on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BoneDrawable.h"


@interface Bone : NSObject <BoneDrawable>{
	
	CGPoint startPoint;
	CGPoint endPoint;
	float boneLength;
	float cAngle;
	float realAngle;
	Bone *parentBone;
	NSMutableSet *childBoneList;
	ccColor4F boneColor;
	float boneRenderWidth;
	
}

@property (nonatomic, readwrite, assign) CGPoint startPoint;
@property (nonatomic, readwrite, assign) CGPoint endPoint;
@property (nonatomic, readwrite, assign) float boneLength;
@property (nonatomic, readwrite, assign) float cAngle;
@property (nonatomic, readwrite, assign) float realAngle;
@property (nonatomic, readwrite, assign) Bone *parentBone;
@property (nonatomic, retain) NSMutableSet *childBoneList;
@property (nonatomic, readwrite, assign) ccColor4F boneColor;
@property (nonatomic, readwrite, assign) float boneRenderWidth;

-(CGPoint)findEndPointByAngle:(float)angle BoneStartPoint:(CGPoint)sPoint BoneLength:(float)bLength;
-(void)setBoneRenderingColor:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha;
-(void)addChildBone:(Bone*)childBone;
-(void)setAngle:(float)angle;
-(void)processBone;
-(void)updateStartPoint;
-(void)updateAngle;
-(void)updateEndPoint;
-(void)logicalUpdate:(ccTime)dt;

@end
