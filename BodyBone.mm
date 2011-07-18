//
//  BodyBone.m
//  aPlank
//
//  Created by Nelson on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BodyBone.h"


@implementation BodyBone

-(id)initWithStartPoint:(CGPoint)startPos BoneLength:(float)bLength BoneAngle:(float)bAngle
{
	if((self=[super initWithStartPoint:startPos BoneLength:bLength BoneAngle:bAngle]))
	{
		[self createChildBone];
	}
	return self;
}

-(void)createChildBone
{
	//create head bone and add to parent
	HeadBone *head=[[[HeadBone alloc] initWithStartPoint:self.endPoint BoneLength:self.boneLength/2.0f BoneAngle:0.0f] autorelease];
	[head setBoneRenderWidth:self.boneRenderWidth];
	[head setBoneRenderingColor:1.0f Green:0.0f Blue:0.0f Alpha:1.0f];
	[self addChildBone:head];
	[head setAngle:0.0f];
	

	//creat left arm bone and add to parent
	LeftArmBone *leftArm=[[[LeftArmBone alloc] initWithStartPoint:self.endPoint BoneLength:self.boneLength BoneAngle:0.0f] autorelease];
	[leftArm setBoneRenderWidth:self.boneRenderWidth];
	[leftArm setBoneRenderingColor:0.0f Green:1.0f Blue:0.0f Alpha:1.0f];
	[self addChildBone:leftArm];
	[leftArm setAngle:-105.0f];
	
	//create right arm bone and add to parent
	RightArmBone *rightArm=[[[RightArmBone alloc] initWithStartPoint:self.endPoint BoneLength:self.boneLength BoneAngle:0.0f] autorelease];
	[rightArm setBoneRenderWidth:self.boneRenderWidth];
	[rightArm setBoneRenderingColor:0.0f Green:1.0f Blue:0.0f Alpha:1.0f];
	[self addChildBone:rightArm];
	[rightArm setAngle:105.0f];
	
}

-(void)logicalUpdate:(ccTime)dt
{
	
	[super logicalUpdate:dt];
}

-(void)dealloc
{
	
	[super dealloc];
}

@end
