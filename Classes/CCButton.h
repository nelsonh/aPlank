//
//  CCButton.h
//  aPlank
//
//  Created by Nelson on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
