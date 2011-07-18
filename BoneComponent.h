//
//  BoneComponent.h
//  aPlank
//
//  Created by Nelson on 7/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bone.h"

@interface BoneComponent : Bone {

}

-(id)initWithStartPoint:(CGPoint)startPos BoneLength:(float)bLength BoneAngle:(float)bAngle;

@end
