//
//  DataManager.m
//  BookShow
//
//  Created by Lion on 14-3-12.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import "DataManager.h"
static DataManager *obj = nil;
@implementation DataManager

+ (DataManager *)shared
{
    if (obj == nil) {
        obj = [[self alloc] init];
    }
    return obj;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

@end
