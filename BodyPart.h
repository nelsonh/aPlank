//
//  BodyPart.h
//  aPlank
//
//  Created by Nelson on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Actor.h"

@interface BodyPart : Actor {

}

+(id)spawnWithFileName:(NSString*)fileName;
-(id)initWithSpriteFileName:(NSString*)spriteFileName;

@end
