//
//  DataManager.h
//  BookShow
//
//  Created by Lion on 14-3-12.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import "CCNode.h"

#define maxX 50
#define maxY 50
#define minX 50
#define minY 50

enum
{
    kSwipeLeft = 10,
    kSwipeRight,
    kSwipeUp,
    kSwipeDown
};

typedef enum
{
    kDirectionLeft,
    kDirectionRight
}kDirectionType;

@interface DataManager : CCNode
+ (DataManager *)shared;

@end
