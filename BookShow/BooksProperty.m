//
//  BooksProperty.m
//  BookShow
//
//  Created by Lion on 14-3-13.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import "BooksProperty.h"

@implementation BooksProperty

+ (BooksProperty *)createWithPoint:(CGPoint)pos Angle:(CGFloat)angle
{
    BooksProperty *obj = [[self alloc] init];
    obj.position = pos;
    obj.rotation = angle;
    return obj;
}

@end
