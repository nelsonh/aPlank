//
//  IntroScene.m
//  aPlank
//
//  Created by Nelson on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IntroScene.h"
#import "IntroUI.h"


@implementation IntroScene

@synthesize actionList;

static IntroScene *introSceneInstance;

+(id)scene
{
	CCScene *scene=[CCScene node];
	IntroScene *layer=[IntroScene node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init]))
	{
		introSceneInstance=self;
		
		self.actionList=[[[NSMutableArray alloc] init] autorelease];
		
		//prefix
		imagePrefix=@"S";
		//format
		imageFormat=@".png";
		
		
		//layout image
		[self layoutImage];
		
		//create ui layer
		IntroUI *uilayer=[IntroUI node];
		[self addChild:uilayer];
		
		currentSlide=1;
		
		[self scheduleUpdate];
	}
	
	return self;
}

-(void)update:(ccTime)dt
{
	//run through all actions and see if it is done
	if(actionList!=nil && [actionList count]!=0)
	{
		for(unsigned int i=0; i<[actionList count]; i++)
		{
			CCAction *action=(CCAction*)[actionList objectAtIndex:i];
			
			if(![action isDone])
			{
				//action is not done
				return;
			}
		}
		
		//all action has finished remove all action 
		[actionList removeAllObjects];
	}
}

+(id)sharedIntroScene
{
	NSString *msg=[NSString stringWithFormat:@"Instance is not existed --Class:%@", [self class]];
	NSAssert(introSceneInstance!=nil, msg);
	return introSceneInstance;
}

-(void)layoutImage
{
	CGSize screenSize=[CCDirector sharedDirector].winSize;
	CGPoint startPos=CGPointMake(screenSize.width/2, screenSize.height/2);
	
	for(int i=0; i<TotalImages; i++)
	{
		//create sprtie and setup position
		CCSprite *storyImage=[CCSprite spriteWithFile:[NSString stringWithFormat:@"%@%i%@", imagePrefix, i, imageFormat]];
		storyImage.position=ccp(startPos.x, startPos.y);
		//tag image so easy to retrieve
		[storyImage setTag:i];
		
		//add to layer
		[self addChild:storyImage];
		
		//calculate next pic position
		startPos=CGPointMake(startPos.x+storyImage.contentSize.width, startPos.y);
	}
}

-(void)moveLeftASlide
{
	CGSize screenSize=[CCDirector sharedDirector].winSize;
	
	//if current slide index greater than total images then do not perform move left action on slide
	if(currentSlide>=TotalImages)
		return;
	
	//if there is an action in action collection we do not perfrom move left action on slide(will get mess up)
	if([actionList count]!=0)
		return;
	
	for(int i=0; i<TotalImages; i++)
	{
		CCSprite *slide=(CCSprite*)[self getChildByTag:i];
		
		//move each slide to left
		id moveLeft=[CCMoveTo actionWithDuration:transistionDuration position:ccp(slide.position.x-screenSize.width, slide.position.y)];
		
		//add action to action list
		[actionList addObject:moveLeft];
		
		[slide runAction:moveLeft];
		
	}
	
	//increment of current slide index
	currentSlide+=1;
}

-(void)moveRightASlide
{
	CGSize screenSize=[CCDirector sharedDirector].winSize;
	
	//if current slide index smaller than 0 then do not perform move right action on slide
	if(currentSlide<=1)
		return;
	
	//if there is an action in action collection we do not perfrom move right action on slide(will get mess up)
	if([actionList count]!=0)
		return;
	
	for(int i=0; i<TotalImages; i++)
	{
		CCSprite *slide=(CCSprite*)[self getChildByTag:i];
		
		//move each slide to left
		id moveRight=[CCMoveTo actionWithDuration:transistionDuration position:ccp(slide.position.x+screenSize.width, slide.position.y)];
		
		//add action to action list
		[actionList addObject:moveRight];
		
		[slide runAction:moveRight];
		
	}
	
	//increment of current slide index
	currentSlide-=1;
}



-(void)dealloc
{
	self.actionList=nil;
	
	[super dealloc];
}


@end
