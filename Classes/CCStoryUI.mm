//
//  CCStoryUI.m
//  aPlank
//
//  Created by Nelson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCStoryUI.h"
#import "Helper.h"
#import "CCButton.h"


@implementation CCStoryUI

@synthesize uiElements;

-(id)init
{
	if((self=[super init]))
	{
		self.isTouchEnabled=YES;
		
		//create ui element container
		self.uiElements=[[[NSMutableArray alloc] init] autorelease];
		
		//layoutUI
		[self layoutUI];
	}
	
	return self;
}

-(void)layoutUI
{
	
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
	CGPoint glPoint;
	BOOL isTouchHandled=NO;
	
	//get back GL touch point
	glPoint=[Helper toGLViewPoint:touch];
	
	//check touch location in any of UI elements and perform specific even
	if(uiElements!=nil && [uiElements count]!=0)
	{
		for(unsigned int i=0; i<[uiElements count]; i++)
		{
			//all ui are subclass CCButton
			CCButton *uiElement=[uiElements objectAtIndex:i];
			
			//get back UI element boundingbox
			CGRect uiElementBB=uiElement.boundingBox;
			
			if([Helper isPointInRect:uiElementBB GLPoint:glPoint])
			{
				//touch should be handled
				isTouchHandled=YES;
				
				if(currentContactUI)
					[currentContactUI performReleasedEvent];
				
				currentContactUI=uiElement;
				
				//perform ui pressed event
				[uiElement performPressedEvent];
				
				break;
			}
		}
	}
	
	return isTouchHandled;
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
	if(currentContactUI)
	{
		[currentContactUI performReleasedEvent];
		
		currentContactUI=nil;
	}
}

-(void)dealloc
{
	self.uiElements=nil;
	
	[super dealloc];
}

@end
