//
//  ReviewUI.m
//  aPlank
//
//  Created by Nelson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ReviewUI.h"
#import "BackButton.h"
#import "NextButton.h"
#import "PreviousButton.h"


@implementation ReviewUI

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
	BackButton *backBtn=[BackButton buttonWithFile:@"BackBtn.png"];
	backBtn.position=ccp(screenSize.width/2, ButtonHeight);
	[self addChild:backBtn];
	
	//add to ui container
	[uiElements addObject:backBtn];
}

-(void)dealloc
{
	[super dealloc];
}


@end
