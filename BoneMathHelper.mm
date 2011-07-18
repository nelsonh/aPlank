//
//  BoneMathHelper.m
//  aPlank
//
//  Created by Nelson on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BoneMathHelper.h"


@implementation Bone (Math)

+(float)mathLerp:(float)startAngle EndAngle:(float)destAngle Alpha_0_1:(float)alpha
{
	NSAssert((alpha>=0 && alpha<=1), @"Lerp alpha only between 0 and 1");
	
	
	float result=startAngle*(1-alpha)+destAngle*alpha;
	
	return result;
}

@end
