//
//  BookSprite.m
//  BookShow
//
//  Created by Lion on 14-3-13.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import "BookSprite.h"
#import "BookShelf.h"
#import "DataManager.h"

@implementation BookSprite
{
    NSString *imageName;
    CGPoint firstPos;
    CGPoint currentPos;
    NSInteger swipeMode;
    BOOL canOpen;
}

+ (BookSprite *)createWithImage:(NSString *)image andZorder:(NSInteger) z
{
    return [[self alloc] initBookSpriteWithImage:image andZorder:(NSInteger) z];
}

- (id)initBookSpriteWithImage:(NSString *)image andZorder:(NSInteger) z
{
    if (self = [super initWithFile:image]) {
        imageName = image;
        [self setZOrder:z];
    }
    return self;
}

- (void)setZOrder:(NSInteger)zOrder
{
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:-zOrder swallowsTouches:YES];
    [super setZOrder:zOrder];
}

- (BOOL)isContainPoint:(CGPoint) pos
{
    BOOL bRect = NO;
    
    float angle = CC_DEGREES_TO_RADIANS(self.rotation);
    CGPoint center = self.position;
    float width = self.contentSize.width;
    float height = self.contentSize.height;
    CGRect rect = CGRectMake(center.x - width/2, center.y - height/2, width, height);
    CGPoint newPos = ccpRotateByAngle(pos, center, angle);
    if (CGRectContainsPoint(rect, newPos)) {
        bRect = YES;
    }
    return bRect;
}

- (void)runMoveActionWithPosition:(CGPoint) pos andRotation:(CGFloat) angle
{
    [self stopAllActions];
//    CGFloat duration = ccpDistance(self.position, pos)/1000;
    CGFloat duration = 0.3;
    CCMoveTo *moveTo = [CCMoveTo actionWithDuration:duration position:pos];
    [self runAction:moveTo];
    CCRotateTo *rotateTo = [CCRotateTo actionWithDuration:duration angle:angle];
    [self runAction:rotateTo];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    canOpen = YES;
    swipeMode = 0;
    firstPos = [[CCDirector sharedDirector] convertTouchToGL:touch];
    if ([self isContainPoint:firstPos]) {
        NSInteger num = [[BookShelf shared].booksArr indexOfObject:self];
        if (num != 0 && [[BookShelf shared] isFlowMode]) canOpen = NO;
        
        return YES;
    }else{
        return NO;
    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    canOpen = NO;
    
    CCLOG(@"bookSprite Moved");
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

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
//    CGPoint pos = [[CCDirector sharedDirector] convertTouchToGL:touch];
    CCLOG(@"bookSprite Ended");
    if (canOpen) {
        [self showAlert];
//        return;
    }
    
    if (swipeMode == kSwipeDown || swipeMode == kSwipeUp) {
        [[BookShelf shared] changeViewMode];
        return;
    }
    
    if ([[BookShelf shared] isFlowMode]) {
        NSInteger num = [[BookShelf shared].booksArr indexOfObject:self];
        if (num > 0) {
            [[BookShelf shared] pushToTopWithBook:num];
            return;
        }
        
        if (swipeMode == kSwipeLeft) {
            [[BookShelf shared] pushToTopWithDirection:kDirectionLeft];
//            return;
        }else if (swipeMode == kSwipeRight){
            [[BookShelf shared] pushToTopWithDirection:kDirectionRight];
//            return;
        }
        
    }
    
    
}

- (void)showAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Open Book"
                                                        message:[NSString stringWithFormat:@"Open %@",imageName]
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)cleanup
{
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
    [super cleanup];
}


@end
