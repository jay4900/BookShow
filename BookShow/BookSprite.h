//
//  BookSprite.h
//  BookShow
//
//  Created by Lion on 14-3-13.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"

@interface BookSprite : CCSprite <CCTouchOneByOneDelegate>
@property CGPoint targetPosition;
@property CGFloat targetRotation;

+ (BookSprite *)createWithImage:(NSString *)image andZorder:(NSInteger) z;
- (void)setZOrder:(NSInteger)zOrder;
- (void)runMoveActionWithPosition:(CGPoint) pos andRotation:(CGFloat) angle;
@end
