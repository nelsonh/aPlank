//
//  BodyShapeInfo.m
//  aPlank
//
//  Created by Nelson on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BodyShapeInfo.h"


@implementation BodyShapeInfo

@synthesize shapeVerticesPointer;
@synthesize vertexCount;

+(id)shapeInfoWithVertexPointer:(NSValue*)vertexPtr VertexCount:(int)vertexCount
{
	return [[[BodyShapeInfo alloc] initwithVertexPointer:vertexPtr VertexCount:vertexCount] autorelease];
}

-(id)initwithVertexPointer:(NSValue*)vPtr VertexCount:(int)vCount
{
	if((self=[super init]))
	{
		self.shapeVerticesPointer=vPtr;
		self.vertexCount=vCount;
	}
	return self;
}



-(void)dealloc
{
	self.shapeVerticesPointer=nil;
	
	[super dealloc];
}

@end
