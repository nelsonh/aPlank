//
//  BoneMathHelper.h
//  aPlank
//
//  Created by Nelson on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bone.h"

@interface Bone (Math)

+(float)mathLerp:(float)startAngle EndAngle:(float)destAngle Alpha_0_1:(float)alpha;

@end
