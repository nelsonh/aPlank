//
//  ShadowPart.m
//  aPlank
//
//  Created by Nelson on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShadowPart.h"


@implementation ShadowPart

+(id)spawnAtPosition:(CGPoint)spawnPos FileName:(NSString*)fileName
{
	return [[[ShadowPart alloc] initWithPosition:spawnPos withSpriteFileName:fileName] autorelease];
}

-(id)initWithPosition:(CGPoint)pos withSpriteFileName:(NSString*)spriteFileName
{
	if((self=[super init]))
	{
		CCSprite *rSprite=[[[CCSprite alloc] initWithFile:spriteFileName] autorelease];
		self.sprite=rSprite;
		[self addChild:self.sprite];
		
		self.position=pos;
	}
	return self;

}

@end
