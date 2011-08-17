//
//  IntroUI.m
//  aPlank
//
//  Created by Nelson on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IntroUI.h"
#import "NextButton.h"
#import "PreviousButton.h"
#import "SkipButton.h"



@implementation IntroUI

//override 
-(void)layoutUI
{
	CGSize screenSize=[CCDirector sharedDirector].winSize;
	
	//crate next button
	NextButton *nextBtn=[NextButton buttonWithFile:@"NextBtn.png"];
	nextBtn.position=ccp(screenSize.width/2-nextBtn.boundingBox.size.width*2, ButtonHeight);
	[self addChild:nextBtn];
	
	//add to ui container
	[uiElements addObject:nextBtn];
	
	//crate previous button
	PreviousButton *previousBtn=[PreviousButton buttonWithFile:@"PreviousBtn.png"];
	previousBtn.position=ccp(screenSize.width/2+previousBtn.boundingBox.size.width*2, ButtonHeight);
	[self addChild:previousBtn];
	
	//add to ui container
	[uiElements addObject:previousBtn];

	
	//crate skip button
	SkipButton *skipBtn=[SkipButton buttonWithFile:@"SkipBtn.png"];
	skipBtn.position=ccp(screenSize.width/2, ButtonHeight);
	[self addChild:skipBtn];
	
	//add to ui container
	[uiElements addObject:skipBtn];
}

-(void)dealloc
{
	
	[super dealloc];
}

@end
