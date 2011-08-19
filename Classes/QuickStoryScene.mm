//
//  QuickStoryScene.m
//  aPlank
//
//  Created by Nelson on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuickStoryScene.h"
#import "CCBReader.h"

@implementation QuickStoryScene

+(id)scene
{
	CCScene *scene=[CCScene node];
	QuickStoryScene *layer=[QuickStoryScene node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init]))
	{
		CGSize screenSize=[CCDirector sharedDirector].winSize;
		
		CCSprite *slide=[CCSprite spriteWithFile:@"S5.png"];
		slide.position=ccp(screenSize.width/2, screenSize.height/2);
		[self addChild:slide];
		
		[self performSelector:@selector(goToMainMenu) withObject:nil afterDelay:4];
	}
	
	return self;
}

-(void)goToMainMenu
{
	CCScene *mainMenu=(CCScene*)[CCBReader nodeGraphFromFile:@"MainMenu.ccb"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:transDuration scene:mainMenu]];
}

-(void)dealloc
{
	[super dealloc];
}

@end
