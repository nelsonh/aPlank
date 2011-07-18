//
//  Actor.m
//  aPlank
//
//  Created by Nelson on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Actor.h"
#import "PlankScene.h"


@implementation Actor

@synthesize actors;
@synthesize components;
@synthesize sprite;
@synthesize owner;
@synthesize bodyComponent;
@synthesize bodySleepAllowed;

-(id)init
{
	if((self=[super init]))
	{
		self.actors=[[[NSMutableSet alloc] init] autorelease];
		self.components=[[[NSMutableSet alloc] init] autorelease];
		self.sprite=nil;
		self.owner=nil;
		self.bodyComponent=nil;
		self.bodySleepAllowed=true;
	}

	return self;
}

//sprite only
-(void)attachChildActor:(Actor*)childActor toPosition:(CGPoint)pos
{
	NSAssert(actors!=nil, @"actors set is nil");
	
	[self addChild:childActor];
	childActor.position=pos;
	
	//set child owner
	[childActor setOwner:self];
	
	[actors addObject:childActor];
}

//do not call directly
-(void)detachChildActor:(Actor*)childActor clean:(BOOL)yesOrNo;
{
	//clean: remove all current action and scheduledSelectors
	
	NSAssert(actors!=nil, @"actors set is nil");
	
	
	[self removeChild:childActor cleanup:yesOrNo];
	childActor.owner=nil;
	
	
}

//sprite only
-(void)detachChildActor:(Actor*)childActor clean:(BOOL)yesOrNo toScenePosition:(CGPoint)pos
{
	//clean: remove all current action and scheduledSelectors
	
	NSAssert(actors!=nil, @"actors set is nil");
	
	CCScene *currentScene=[[CCDirector sharedDirector] runningScene];
	CCLayer *gameMainLayer=(CCLayer*)[currentScene getChildByTag:KMainLayer];
	
	NSAssert(gameMainLayer!=nil, @"game main layer not found");
	
	[self detachChildActor:childActor clean:yesOrNo];
	
	//add child to main layer in scene
	[gameMainLayer addChild:childActor];
	childActor.position=pos;
	
	[actors removeObject:childActor];
}

-(void)removeChildActor:(Actor*)childActor
{
	if([[actors allObjects] count])
	{
		[actors removeObject:childActor];
	}
}

-(BOOL)collideWithRect:(CGRect)rectBoundingBox
{
	if(self.sprite)
	{
	
		CGPoint worldPos=[self.sprite.parent convertToWorldSpace:[self.sprite boundingBox].origin];
		CGRect worldBB=CGRectMake(worldPos.x, worldPos.y, [self.sprite boundingBox].size.width, [self.sprite boundingBox].size.height);
		
		return CGRectIntersectsRect(worldBB, rectBoundingBox);
	}
	
	return NO;
	
}



-(void)destroy
{
	//remove all child actor from this actor
	[self removeAllChildrenWithCleanup:YES];
	
	//destroy child actor
	if([[actors allObjects] count])
	{
		NSArray *childActors=[actors allObjects];
		
		for(Actor *childActor in childActors)
		{
			[childActor destroy];
			owner=nil;
		}
		
		[actors removeAllObjects];
	}
	
	//remove child component
	if([[components allObjects] count])
	{
		//NSArray *childComponents=[components allObjects];
		
		//destroy components
		
		[components removeAllObjects];
	}
	
	//remove self from owner
	if(owner)
	{
		[owner removeChildActor:self];
	}
	
	//destroy body component
	if(self.bodyComponent!=nil)
	{
		PlankScene *gameScene=[PlankScene sharedGameScene];
		[gameScene destroyBody:self.bodyComponent];
		self.bodyComponent=nil;
	}

	
	//remove self node from parent node
	if(self.parent)
	{
		[[self parent] removeChild:self cleanup:YES];
	}
	
}

-(void)dealloc
{
	
	self.actors=nil;
	self.components=nil;
	self.sprite=nil;
	self.owner=nil;
	self.bodyComponent=nil;
	
	[super dealloc];
}

@end
