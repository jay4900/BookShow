//
//  BookShelf.h
//  BookShow
//
//  Created by Wuffy on 3/12/14.
//  Copyright (c) 2014 wufei. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "BookSprite.h"
#import "DataManager.h"

@interface BookShelf : CCLayer{
    CGSize winSize;
    BookSprite *book1;
    BookSprite *book2;
    BookSprite *book3;
    BookSprite *book4;
    BookSprite *book5;
    BookSprite *book6;
    BookSprite *book7;
    BookSprite *book8;
    BookSprite *firstBook;
    NSMutableArray *booksArr;
}
@property (strong, nonatomic)NSMutableArray *booksArr;
@property (strong, nonatomic)NSArray *boooksRowPosition;
@property (strong, nonatomic)NSArray *booksPropertyArr;
@property BOOL isFlowMode;
+ (id)scene;
+ (BookShelf *)shared;
- (void)changeViewMode;
- (void)pushToTopWithBook:(NSInteger)num;
- (void)pushToTopWithDirection:(kDirectionType) direction;
@end
