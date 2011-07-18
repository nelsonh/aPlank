//
//  BodyBone.h
//  aPlank
//
//  Created by Nelson on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoneComponent.h"
#import "HeadBone.h"
#import "LeftArmBone.h"
#import "RightArmBone.h"

@interface BodyBone : BoneComponent {

}

-(id)initWithStartPoint:(CGPoint)startPos BoneLength:(float)bLength BoneAngle:(float)bAngle;
-(void)createChildBone;

@end
