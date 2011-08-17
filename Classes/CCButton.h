//
//  CCButton.h
//  aPlank
//
//  Created by Nelson on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/**
 CCButton is designed for CCStoryUI.
 
 A subclass of CCSprite, subclass must set pressedTarget, pressedEvent, releasedTarget and releasedEvent
 if subclass need to perform a specific action on pressed or released touch event.
 
 All UI components on the layer is CCButton type.
 
 performPressedEvent and performReleasedEvent will be invoked by CCStoryUI
 **/

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface CCButton : CCSprite {
	
	//press
	id pressedTarget;
	SEL pressedEvent;
	
	//release
	id releasedTarget;
	SEL releasedEvent;

}

@property (nonatomic, assign) id pressedTarget;
@property (nonatomic, assign) SEL pressedEvent;
@property (nonatomic, assign) id releasedTarget;
@property (nonatomic, assign) SEL releasedEvent; 

+(id)buttonWithFile:(NSString*)fileName;
-(void)performPressedEvent;
-(void)performReleasedEvent;

@end
