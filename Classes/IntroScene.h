//
//  IntroScene.h
//  aPlank
//
//  Created by Nelson on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//define the number of image
#define TotalImages 6

#define transistionDuration 0.3


@interface IntroScene : CCLayer {
	
	NSMutableArray *actionList;
	int currentSlide;
	NSString *imagePrefix;
	NSString *imageFormat;
	CCNode *currentUI;
	

}

@property (nonatomic, retain)NSMutableArray *actionList;
@property (nonatomic, assign)CCNode *currentUI;
@property (nonatomic, assign)int currentSlide;

+(id)scene;
+(id)sharedIntroScene;
-(void)layoutImage;
-(void)layoutUIWithUI:(CCNode*)uiNode;
-(void)moveLeftASlide;
-(void)moveRightASlide;
-(int)totalSlides;


@end
