//
//  HumanSkeleton.h
//  aPlank
//
//  Created by Nelson on 7/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoneComponent.h"
#import "BodyBone.h"
#import "LeftLegBone.h"
#import "RightLegBone.h"

@interface HumanSkeleton : BoneComponent {

}

-(id)initWithStartPoint:(CGPoint)startPos BoneLength:(float)bLength BoneAngle:(float)bAngle;
-(void)createChildBodyBone;
-(void)createChildLegsBone;

@end
