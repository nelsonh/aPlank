//
//  IntroUI.h
//  aPlank
//
//  Created by Nelson on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define ButtonHeight 20

@interface IntroUI : CCLayer {
	
	NSMutableArray *uiElements;
	id currentContactUI;
}

@property (nonatomic, retain) NSMutableArray *uiElements;

-(void)layoutUI;

@end
