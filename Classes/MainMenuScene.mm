//
//  MainMenuScene.m
//  aPlank
//
//  Created by Nelson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "IntroScene.h"
#import "IntroUI.h"
#import "ReviewUI.h"



@implementation MainMenuScene

- (void) didLoadFromCCB
{
	NSLog(@"MainMenuScene load from ccb");
}

-(void)startButton:(id)sender
{
	//start story test
	CCScene *storyScene=[IntroScene scene];
	//given coorespond UI
	[[IntroScene sharedIntroScene] layoutUIWithUI:[IntroUI node]];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:transDuration scene:storyScene]];
}

-(void)optionButton:(id)sender
{
	NSLog(@"option button pressed");
}

-(void)reviewButton:(id)sender
{
	CCScene *storyScene=[IntroScene scene];
	//given coorespond UI
	[[IntroScene sharedIntroScene] layoutUIWithUI:[ReviewUI node]];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:transDuration scene:storyScene]];
}

@end
