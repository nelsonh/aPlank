//
//  Helper.m
//  aPlank
//
//  Created by Nelson on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Helper.h"


@implementation Helper

+(b2Vec2)toMeter:(CGPoint)pixelPoint
{
	return b2Vec2(pixelPoint.x/PTM_RATIO, pixelPoint.y/PTM_RATIO);
}

+(CGPoint)toPixel:(b2Vec2)meter
{
	return CGPointMake(meter.x*PTM_RATIO, meter.y*PTM_RATIO);
}

+(BOOL)isOutOfScreen:(CGRect)rectBoundingBox
{
	if(rectBoundingBox.origin.x<=0 || rectBoundingBox.origin.x>=480)
		return YES;
	
	if(rectBoundingBox.origin.y<=0 || rectBoundingBox.origin.y>=320)
		return YES;
	
	if(rectBoundingBox.origin.x+rectBoundingBox.size.width<=0 || rectBoundingBox.origin.x+rectBoundingBox.size.width>=480)
		return YES;
	
	if(rectBoundingBox.origin.y+rectBoundingBox.size.height<=0 || rectBoundingBox.origin.y+rectBoundingBox.size.height>=320)
		return YES;
	
	return NO;
}

+(CGPoint)toGLViewPoint:(UITouch*)touch
{
	CGPoint touchLoc=[touch locationInView:[touch view]];
	CGPoint glViewLoc=[[CCDirector sharedDirector] convertToGL:touchLoc];
	
	return glViewLoc;
}

+(BOOL)isPointInRect:(CGRect)rect GLPoint:(CGPoint)glPoint
{
	return CGRectContainsPoint(rect, glPoint);
}

@end
