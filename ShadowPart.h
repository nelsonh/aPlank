//
//  ShadowPart.h
//  aPlank
//
//  Created by Nelson on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Actor.h"

@interface ShadowPart : Actor {

}

+(id)spawnAtPosition:(CGPoint)spawnPos FileName:(NSString*)fileName;
-(id)initWithPosition:(CGPoint)pos withSpriteFileName:(NSString*)spriteFileName;

@end
