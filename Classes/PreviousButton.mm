//
//  PreviousButton.m
//  aPlank
//
//  Created by Nelson on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PreviousButton.h"
#import "IntroScene.h"


@implementation PreviousButton

+(id)buttonWithFile:(NSString*)fileName
{
	id button=[[[PreviousButton alloc] initWithFile:fileName] autorelease];
	
	//setup pressed target and selector
	[button setPressedTarget:button];
	[button setPressedEvent:@selector(buttonDownEvent)];
	
	//setup release target and selector
	[button setReleasedTarget:button];
	[button setReleasedEvent:@selector(buttonUpEvent)];
	
	return button;
}

-(void)buttonDownEvent
{
	IntroScene *introScene=[IntroScene sharedIntroScene];
	
	[introScene moveRightASlide];
	
	[self setColor:ccRED];
}

-(void)buttonUpEvent
{
	[self setColor:ccWHITE];
}

-(void)dealloc
{
	[super dealloc];
}

@end
