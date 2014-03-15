//
//  BooksProperty.h
//  BookShow
//
//  Created by Lion on 14-3-13.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BooksProperty : NSObject
@property CGPoint position;
@property CGFloat rotation;
+ (BooksProperty *)createWithPoint:(CGPoint) pos Angle:(CGFloat) angle;
@end
