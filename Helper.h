//
//  Helper.h
//  aPlank
//
//  Created by Nelson on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
#import "Common.h"
#import "cocos2d.h"

@interface Helper : NSObject {

}

+(b2Vec2)toMeter:(CGPoint)pixelPoint;
+(CGPoint)toPixel:(b2Vec2)meter;
+(BOOL)isOutOfScreen:(CGRect)rectBoundingBox;

@end
