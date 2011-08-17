//
//  BackButton.m
//  aPlank
//
//  Created by Nelson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BackButton.h"
#import "CCBReader.h"

@implementation BackButton

+(id)buttonWithFile:(NSString*)fileName
{
	id button=[[[BackButton alloc] initWithFile:fileName] autorelease];
	
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
	//back to menu
	CCScene *menuScene=(CCScene*)[CCBReader nodeGraphFromFile:@"MainMenu.ccb"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:transDuration scene:menuScene]];
	
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
