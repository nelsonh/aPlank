//
//  BoneComponent.m
//  aPlank
//
//  Created by Nelson on 7/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BoneComponent.h"


@implementation BoneComponent

-(id)initWithStartPoint:(CGPoint)startPos BoneLength:(float)bLength BoneAngle:(float)bAngle
{
	if((self=[super init]))
	{
		self.startPoint=startPos;
		self.boneLength=bLength;
		self.cAngle=bAngle;
		self.realAngle=bAngle;
		self.endPoint=[self findEndPointByAngle:self.realAngle BoneStartPoint:self.startPoint BoneLength:self.boneLength];
	}
	
	return self;
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
