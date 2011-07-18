//
//  BodyShapeInfo.h
//  aPlank
//
//  Created by Nelson on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"

@interface BodyShapeInfo : NSObject {
	
	NSValue *shapeVerticesPointer;
	int vertexCount;

}

@property (nonatomic, retain) NSValue *shapeVerticesPointer;
@property (nonatomic, readwrite, assign) int vertexCount;

+(id)shapeInfoWithVertexPointer:(NSValue*)vertexPtr VertexCount:(int)vertexCount;
-(id)initwithVertexPointer:(NSValue*)vPtr VertexCount:(int)vCount;

@end
