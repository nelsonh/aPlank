//
//  CCStoryUI.h
//  aPlank
//
//  Created by Nelson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/**
 CCStoryUI is designed for story intro. No multi-touch.
 
 A subclass of CCLayer, any of user interface relate to story should subclass this class
 and override layoutUI method in order to create customzied UI.
 
 All UI components on the layer is CCButton type.
 
 CCStoryUI will detetect any touch event and determine wether touch is on any of ui or not by go through
 uiElements ui component container. If touch is on any of ui component then CCStoryUI will invoke that ui
 component's(CCButton) performPressedEvent or performReleasedEvent method.
 **/

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCStoryUI : CCLayer {
	
	NSMutableArray *uiElements;
	id currentContactUI;

}

@property (nonatomic, retain) NSMutableArray *uiElements;

//Method should be overrided
-(void)layoutUI;

@end
