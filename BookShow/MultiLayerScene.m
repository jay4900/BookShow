//
//  MultiLayerScene.m
//  BookShow
//
//  Created by Lion on 14-3-12.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import "MultiLayerScene.h"
#import "BookShelf.h"
#import "UserControlLayer.h"
#import "CCBReader.h"

@implementation MultiLayerScene

+ (id)scene
{
    return [[self alloc] init];
}

- (id)init
{
    if (self = [super init]) {
        [self addChild:[BookShelf scene]];
        [self addChild:[UserControlLayer scene]];
        CCMenuItemFont *backItem = [CCMenuItemFont itemWithString:@"Back" block:^(id sender){
            [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"StartScene.ccbi"]];
            
        }];
        CCMenu *backMenu = [CCMenu menuWithItems:backItem, nil];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [backMenu setPosition:ccp(backItem.contentSize.width/2, winSize.height-backItem.contentSize.height/2)];
        [self addChild:backMenu];
    }
    return self;
}

- (void)onExit
{
    [self removeAllChildrenWithCleanup:YES];
}

@end
