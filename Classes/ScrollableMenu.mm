//
//  ScrollableMenu.m
//  aPlank
//
//  Created by Nelson on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScrollableMenu.h"


@implementation ScrollableMenu

+(id)scene
{
	CCScene *scene=[CCScene node];
	ScrollableMenu *layer=[ScrollableMenu node];
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init]))
	{
		CGSize screenSize=[CCDirector sharedDirector].winSize;
		
		//page 1
		CCLayer *pageOne=[CCLayer node];
		
		CCLabelTTF *pageOneLable=[CCLabelTTF labelWithString:@"WTF!" fontName:@"Arial Rounded MT Bold" fontSize:44];
		[pageOneLable setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		
		[pageOne addChild:pageOneLable];
		
		
		//page 2
		CCLayer *pageTwo=[CCLayer node];
		
		CCLabelTTF *pageTwoLable=[CCLabelTTF labelWithString:@"D'oh Rick da!" fontName:@"Arial Rounded MT Bold" fontSize:44];
		[pageTwoLable setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		
		[pageTwo addChild:pageTwoLable];
		
		//page 2
		CCLayer *pageThree=[CCLayer node];
		
		CCLabelTTF *pageThreeLable=[CCLabelTTF labelWithString:@"Oh ya2!" fontName:@"Arial Rounded MT Bold" fontSize:44];
		[pageThreeLable setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		
		[pageThree addChild:pageThreeLable];
		
		
		CCScrollLayer *scroller=[CCScrollLayer nodeWithLayers:[NSArray arrayWithObjects:pageOne, pageTwo, pageThree,nil] widthOffset:0];
		
		[self addChild:scroller];
		
	}
	
	return self;
}

-(void)dealloc
{
	[super dealloc];
}

@end
