//
//  BodyPart.mm
//  aPlank
//
//  Created by Nelson on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BodyPart.h"


@implementation BodyPart

+(id)spawnWithFileName:(NSString*)fileName
{
	return [[[BodyPart alloc] initWithSpriteFileName:fileName] autorelease];
}

-(id)initWithSpriteFileName:(NSString*)spriteFileName
{
	if((self=[super init]))
	{
		CCSprite *rSprite=[[[CCSprite alloc] initWithFile:spriteFileName] autorelease];
		self.sprite=rSprite;
		[self addChild:self.sprite];

	}
	return self;
	
}

@end
