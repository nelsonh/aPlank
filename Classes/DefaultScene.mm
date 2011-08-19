//
//  DefaultScene.m
//  aPlank
//
//  Created by Nelson on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DefaultScene.h"
#import "CCBReader.h"

@implementation DefaultScene

+(id)scene
{
	CCScene *scene=[CCScene node];
	DefaultScene *layer=[DefaultScene node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init]))
	{
		[self performSelector:@selector(goToMainMenu) withObject:nil afterDelay:0.1];
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
