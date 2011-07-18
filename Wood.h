//
//  Wood.h
//  aPlank
//
//  Created by Nelson on 7/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Actor.h"

@interface Wood : Actor {
	

}

+(id)spawnAtPoint:(CGPoint)spawnPos;
-(id)initWithPosition:(CGPoint)pos;
-(void)createPhysicsBody;

@end
