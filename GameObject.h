//
//  GameObject.h
//  aPlank
//
//  Created by Nelson on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Actor.h"

@interface GameObject : Actor {

}

+(id)spawnAtPosition:(CGPoint)spawnPos;
-(id)initWithPosition:(CGPoint)pos withSpriteFileName:(NSString*)spriteFileName;

//create a physics body at given position dynamic default
-(void)createBodyAtPosition:(CGPoint)bodyPos;

//object tick
-(void)tick:(ccTime)dt;

@end
