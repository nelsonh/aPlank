//
//  Bone.m
//  aPlank
//
//  Created by Nelson on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Bone.h"


@implementation Bone

@synthesize startPoint;
@synthesize endPoint;
@synthesize boneLength;
@synthesize cAngle;
@synthesize realAngle;
@synthesize parentBone;
@synthesize childBoneList;
@synthesize boneColor;
@synthesize boneRenderWidth;

-(id)init     
{
	if((self=[super init]))
	{
		self.startPoint=CGPointMake(0, 0);
		self.endPoint=CGPointMake(0, 0);
		self.boneLength=1.0f;
		self.cAngle=0.0f;
		self.realAngle=0.0f;
		self.parentBone=nil;
		self.childBoneList=[[[NSMutableSet alloc] init] autorelease];
		
		boneColor.a=1.0f;
		boneColor.r=0.8f;
		boneColor.g=1.0f;
		boneColor.b=0.76f;
		
		self.boneRenderWidth=1.0f;
		
		//schedul update for this bone
		[[CCScheduler sharedScheduler] scheduleUpdateForTarget:self priority:0 paused:NO];
		
	}
	
	return self;
}

-(CGPoint)findEndPointByAngle:(float)angle BoneStartPoint:(CGPoint)sPoint BoneLength:(float)bLength
{
	CGPoint resultPoint;
	float radinAngle=CC_DEGREES_TO_RADIANS(angle);
	
	resultPoint.x=sPoint.x+bLength*cosf(radinAngle);
	resultPoint.y=sPoint.y+bLength*sinf(radinAngle);
	
	return resultPoint;
}

-(void)setBoneRenderingColor:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha
{
	ccColor4F newBoneColor;
	newBoneColor.a=alpha;
	newBoneColor.r=red;
	newBoneColor.g=green;
	newBoneColor.b=blue;
	
	self.boneColor=newBoneColor;
}

-(void)addChildBone:(Bone*)childBone
{
	[childBone setParentBone:self];
	[childBoneList addObject:childBone];
	
	//clear to 0 when add parent bone 
	childBone.cAngle=0.0f;
}

-(void)setAngle:(float)angle;
{
	if(parentBone!=nil)
	{
		self.cAngle+=angle;
	}
	else 
	{
		self.cAngle=angle;
	}

}

-(void)updateStartPoint
{
	if(parentBone!=nil)
	{
		self.startPoint=self.parentBone.endPoint;
	}
}

-(void)updateAngle
{
	
	//update angle
	if(parentBone!=nil)
	{
		self.realAngle=self.parentBone.realAngle+self.cAngle;
	}
	else 
	{
		//absolute angle
		self.realAngle=self.cAngle;
	}
}

-(void)updateEndPoint
{
	//update endpoint
	self.endPoint=[self findEndPointByAngle:self.realAngle BoneStartPoint:self.startPoint BoneLength:self.boneLength];
}

-(void)processBone
{
	[self updateStartPoint];
	[self updateAngle];
	[self updateEndPoint];
}

-(void)logicalUpdate:(ccTime)dt
{

}

-(void)update:(ccTime)dt
{
	[self processBone];
	
	[self logicalUpdate:dt];
	
}

//protocol
-(void)drawBone
{

	//draw child
	NSArray *childBones=[childBoneList allObjects];
	
	for(Bone *cBone in childBones)
	{
		[cBone drawBone];
	}

	glColor4f(self.boneColor.r, self.boneColor.g, self.boneColor.b, self.boneColor.a);
    glLineWidth(boneRenderWidth);
	ccDrawLine(startPoint, endPoint);
}

-(void)dealloc
{
	[[CCScheduler sharedScheduler] unscheduleUpdateForTarget:self];
	
	parentBone=nil;
	childBoneList=nil;
	
	[super dealloc];
}

@end
