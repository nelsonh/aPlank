//
//  CCButton.m
//  aPlank
//
//  Created by Nelson on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCButton.h"


@implementation CCButton

@synthesize pressedTarget;
@synthesize pressedEvent;
@synthesize releasedTarget;
@synthesize releasedEvent;

+(id)buttonWithFile:(NSString*)fileName
{
	NSAssert(fileName!=nil, @"CCButton pass in a empty file name");
	return [[[CCButton alloc] initWithFile:fileName] autorelease];
}

-(void)performPressedEvent
{
	if(pressedTarget!=nil && pressedEvent!=nil)
	{
		[pressedTarget performSelector:pressedEvent];
	}
}

-(void)performReleasedEvent
{
	if(releasedTarget!=nil && releasedEvent!=nil)
	{
		[releasedTarget performSelector:releasedEvent];
	}
}

-(void)dealloc
{
	self.pressedTarget=nil;
	self.pressedEvent=nil;
	self.releasedTarget=nil;
	self.releasedEvent=nil;
	
	[super dealloc];
}

@end
