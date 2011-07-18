//
//  HumanSkeleton.mm
//  aPlank
//
//  Created by Nelson on 7/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HumanSkeleton.h"


@implementation HumanSkeleton

-(id)initWithStartPoint:(CGPoint)startPos BoneLength:(float)bLength BoneAngle:(float)bAngle
{
	if((self=[super initWithStartPoint:startPos BoneLength:bLength BoneAngle:bAngle]))
	{
		[self createChildBodyBone];
		[self createChildLegsBone];
	}
	return self;
}

-(void)createChildBodyBone
{
	BodyBone *topBodyBone=[[[BodyBone alloc] initWithStartPoint:self.endPoint BoneLength:self.boneLength BoneAngle:0] autorelease];
	[topBodyBone setBoneRenderWidth:self.boneRenderWidth];
	[self addChildBone:topBodyBone];
	[topBodyBone setAngle:0.0f];
}

-(void)createChildLegsBone
{
	//left leg bone
	LeftLegBone *leftLeg=[[[LeftLegBone alloc] initWithStartPoint:self.endPoint BoneLength:self.boneLength BoneAngle:0] autorelease];
	[leftLeg setBoneRenderWidth:self.boneRenderWidth];
	[leftLeg setBoneRenderingColor:0.0f Green:1.0f Blue:0.0f Alpha:1.0f];
	[self addChildBone:leftLeg];
	[leftLeg setAngle:155.0f];
	
	//right leg bone
	RightLegBone *rightLeg=[[[RightLegBone alloc] initWithStartPoint:self.endPoint BoneLength:self.boneLength BoneAngle:0] autorelease];
	[rightLeg setBoneRenderWidth:self.boneRenderWidth];
	[rightLeg setBoneRenderingColor:0.0f Green:1.0f Blue:0.0f Alpha:1.0f];
	[self addChildBone:rightLeg];
	[rightLeg setAngle:-155.0f];
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
