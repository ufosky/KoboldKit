//
//  KKTilemapNode.m
//  KoboldKit
//
//  Created by Steffen Itterheim on 18.06.13.
//  Copyright (c) 2013 Steffen Itterheim. All rights reserved.
//

#import "KKTilemapNode.h"
#import "KKTilemapTileLayerNode.h"
#import "KKTilemapObjectLayerNode.h"
#import "KKTilemap.h"
#import "KKTilemapLayer.h"
#import "SKNode+KoboldKit.h"
#import "KKSynchronizePositionBehavior.h"

@implementation KKTilemapNode

#pragma mark Init/Setup

+(id) tilemapWithContentsOfFile:(NSString*)tmxFile
{
	return [[self alloc] initWithContentsOfFile:tmxFile];
}

-(id) initWithContentsOfFile:(NSString*)tmxFile
{
	self = [super init];
	if (self)
	{
		self.name = tmxFile;
		_tilemap = [KKTilemap tilemapWithContentsOfFile:tmxFile];
		_tileLayers = [NSMutableArray arrayWithCapacity:2];
	}
	return self;
}

-(void) didMoveToParent
{
	if (self.children.count == 0)
	{
		[self observeSceneEvents];
		
		for (KKTilemapLayer* layer in _tilemap.layers)
		{
			if (layer.isTileLayer)
			{
				KKTilemapTileLayerNode* tileLayer = [KKTilemapTileLayerNode tileLayerWithLayer:layer];
				[self addChild:tileLayer];
				[_tileLayers addObject:tileLayer];
			}
			else
			{
				KKTilemapObjectLayerNode* objectLayer = [KKTilemapObjectLayerNode objectLayerWithLayer:layer tilemap:_tilemap];
				[self addChild:objectLayer];
			}
		}

		// parallaxing behavior
		KKSynchronizePositionBehavior* parallaxBehavior = [KKSynchronizePositionBehavior synchronizePositionWithNode:self.mainTileLayerNode];
		for (KKTilemapTileLayerNode* tileLayerNode in _tileLayers)
		{
			if (tileLayerNode != _mainTileLayerNode)
			{
				parallaxBehavior.positionMultiplier = tileLayerNode.layer.parallaxFactor;
				[tileLayerNode addBehavior:parallaxBehavior withKey:NSStringFromClass([KKSynchronizePositionBehavior class])];
			}
		}
	}
}

#pragma mark Update

-(void) didSimulatePhysics
{
	for (KKTilemapTileLayerNode* tileLayer in _tileLayers)
	{
		[tileLayer updateLayer];
	}
	
	_tilemap.modified = NO;
}

#pragma mark Main Layer

@dynamic mainTileLayerNode;
-(KKTilemapTileLayerNode*) mainTileLayerNode
{
	if (_mainTileLayerNode == nil)
	{
		const CGPoint notParallaxing = CGPointMake(1.0, 1.0);
		KKTilemapTileLayerNode* backgroundTileLayerNode;
		Class tileLayerNodeClass = [KKTilemapTileLayerNode class];
		
		for (KKTilemapTileLayerNode* tileLayer in self.children)
		{
			if ([tileLayer isKindOfClass:tileLayerNodeClass])
			{
				// the main layer is the first tile layer with parallax factor 1.0/1.0 (not parallaxing)
				if (CGPointEqualToPoint(tileLayer.layer.parallaxFactor, notParallaxing))
				{
					_mainTileLayerNode = tileLayer;
					break;
				}
				
				if (backgroundTileLayerNode == nil)
				{
					backgroundTileLayerNode = tileLayer;
				}
			}
		}
		
		if (_mainTileLayerNode == nil)
		{
			NSLog(@"WARNING: KTTilemapNode could not determine 'main' layer, using 'background' (first, bottom-most) layer");
			_mainTileLayerNode = backgroundTileLayerNode;
		}
		
		NSLog(@"Main Tile Layer: %@", _mainTileLayerNode.layer.name);
	}
	
	return _mainTileLayerNode;
}


/*
- (void)centerWorldOnPosition:(CGPoint)position {
    [self.world setPosition:CGPointMake(-(position.x) + CGRectGetMidX(self.frame),
                                        -(position.y) + CGRectGetMidY(self.frame))];
    
    self.worldMovedForUpdate = YES;
}

- (void)centerWorldOnCharacter:(APACharacter *)character {
    [self centerWorldOnPosition:character.position];
}
*/
@end