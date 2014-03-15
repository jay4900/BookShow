//
//  UserControlLayer.m
//  BookShow
//
//  Created by Lion on 14-3-12.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import "UserControlLayer.h"
#import "BookShelf.h"
#import "DataManager.h"


@implementation UserControlLayer
{
    CGPoint firstPos;
    CGPoint currentPos;
    NSInteger swipeMode;
}

+ (id)scene
{
    return [[self alloc] init];
}

- (id)init
{
    if (self = [super init]) {
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
    }
    return self;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
//    CCLOG(@"controlLayer Touched");
    firstPos = [[CCDirector sharedDirector] convertTouchToGL:touch];
    swipeMode = 0;
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    currentPos = [[CCDirector sharedDirector] convertTouchToGL:touch];
    if (fabsf(currentPos.x - firstPos.x) < maxX && (currentPos.y - firstPos.y) > minY) {
        swipeMode = kSwipeUp;
    }
    if (fabsf(currentPos.x - firstPos.x) < maxX && (firstPos.y - currentPos.y) > minY) {
        swipeMode = kSwipeDown;
    }
    if (fabsf(currentPos.y - firstPos.y) < maxY && (currentPos.x - firstPos.x) > minX) {
        swipeMode = kSwipeRight;
    }
    if (fabsf(currentPos.y - firstPos.y) < maxY && (firstPos.x - currentPos.x) > minX) {
        swipeMode = kSwipeLeft;
    }
    
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (swipeMode == kSwipeDown || swipeMode == kSwipeUp) {
        [[BookShelf shared] changeViewMode];
    }
    
    if ([[BookShelf shared] isFlowMode]) {
        if (swipeMode == kSwipeLeft) {
            [[BookShelf shared] pushToTopWithDirection:kDirectionLeft];
        }else if (swipeMode == kSwipeRight) {
            [[BookShelf shared] pushToTopWithDirection:kDirectionRight];
        }
    }
}

- (void)cleanup
{
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
    [super cleanup];
}


@end
