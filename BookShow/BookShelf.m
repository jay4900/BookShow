//
//  BookShelf.m
//  BookShow
//
//  Created by Wuffy on 3/12/14.
//  Copyright (c) 2014 wufei. All rights reserved.
//

#import "BookShelf.h"
#import "BooksProperty.h"


static BookShelf *obj = nil;
@implementation BookShelf
@synthesize booksArr;
@synthesize booksPropertyArr;
@synthesize boooksRowPosition;

+ (BookShelf *)shared
{
    return obj;
}

+ (id)scene
{
    if (obj == nil) {
        obj = [[self alloc] init];
        return obj;
    }else{
        return obj;
    }
}

- (id)init
{
    if (self = [super init]) {
//        [self setTouchEnabled:YES];
        winSize = [[CCDirector sharedDirector] winSize];
        
        book1 = [BookSprite createWithImage:@"book1.png" andZorder:8];
        book2 = [BookSprite createWithImage:@"book2.png" andZorder:7];
        book3 = [BookSprite createWithImage:@"book3.png" andZorder:6];
        book4 = [BookSprite createWithImage:@"book4.png" andZorder:5];
        book5 = [BookSprite createWithImage:@"book5.png" andZorder:4];
        book6 = [BookSprite createWithImage:@"book6.png" andZorder:3];
        book7 = [BookSprite createWithImage:@"book7.png" andZorder:2];
        book8 = [BookSprite createWithImage:@"book8.png" andZorder:1];
        
        [book1 setPosition:ccp(150, 550)];
        [book2 setPosition:ccp(400, 550)];
        [book3 setPosition:ccp(650, 550)];
        [book4 setPosition:ccp(900, 550)];
        [book5 setPosition:ccp(150, 200)];
        [book6 setPosition:ccp(400, 200)];
        [book7 setPosition:ccp(650, 200)];
        [book8 setPosition:ccp(900, 200)];
        
        /*
        [book1 setPosition:ccp(517,348)];
        [book2 setPosition:ccp(604,334)];
        [book3 setPosition:ccp(680,356)];
        [book4 setPosition:ccp(752,368)];
        [book5 setPosition:ccp(787,400)];
        [book6 setPosition:ccp(807,415)];
        [book7 setPosition:ccp(826,427)];
        [book8 setPosition:ccp(848,435)];
        
        [book1 setRotation:-10];
        [book2 setRotation:-5];
        [book3 setRotation:15];
        [book4 setRotation:0];
        [book5 setRotation:10];
        [book6 setRotation:10];
        [book7 setRotation:10];
        [book8 setRotation:10];
        */
        [self addChild:book1];
        [self addChild:book2];
        [self addChild:book3];
        [self addChild:book4];
        [self addChild:book5];
        [self addChild:book6];
        [self addChild:book7];
        [self addChild:book8];
        
        booksArr = [[NSMutableArray alloc] initWithObjects:book1, book2, book3, book4, book5, book6, book7, book8, nil];
        
        boooksRowPosition = [[NSArray alloc] initWithObjects:
                             [BooksProperty createWithPoint:ccp(150, 550) Angle:0],
                             [BooksProperty createWithPoint:ccp(400, 550) Angle:0],
                             [BooksProperty createWithPoint:ccp(650, 550) Angle:0],
                             [BooksProperty createWithPoint:ccp(900, 550) Angle:0],
                             [BooksProperty createWithPoint:ccp(150, 200) Angle:0],
                             [BooksProperty createWithPoint:ccp(400, 200) Angle:0],
                             [BooksProperty createWithPoint:ccp(650, 200) Angle:0],
                             [BooksProperty createWithPoint:ccp(900, 200) Angle:0],nil];
        
        booksPropertyArr = [[NSArray alloc] initWithObjects:
                            [BooksProperty createWithPoint:ccp(517,348) Angle:-10],
                            [BooksProperty createWithPoint:ccp(604,334) Angle:-5],
                            [BooksProperty createWithPoint:ccp(680,356) Angle:-15],
                            [BooksProperty createWithPoint:ccp(752,368) Angle:0],
                            [BooksProperty createWithPoint:ccp(787,400) Angle:10],
                            [BooksProperty createWithPoint:ccp(807,415) Angle:10],
                            [BooksProperty createWithPoint:ccp(826,427) Angle:10],
                            [BooksProperty createWithPoint:ccp(848,435) Angle:10],nil];
        _isFlowMode = NO;
    }
    return self;
}

- (void)changeViewMode
{
    switch (_isFlowMode) {
        case YES:
        {
            _isFlowMode = NO;
//            [book1 runMoveActionWithPosition:ccp(150, 550) andRotation:0];
//            [book2 runMoveActionWithPosition:ccp(400, 550) andRotation:0];
//            [book3 runMoveActionWithPosition:ccp(650, 550) andRotation:0];
//            [book4 runMoveActionWithPosition:ccp(900, 550) andRotation:0];
//            [book5 runMoveActionWithPosition:ccp(150, 200) andRotation:0];
//            [book6 runMoveActionWithPosition:ccp(400, 200) andRotation:0];
//            [book7 runMoveActionWithPosition:ccp(650, 200) andRotation:0];
//            [book8 runMoveActionWithPosition:ccp(900, 200) andRotation:0];
            for (int i=0; i<[booksArr count]; i++) {
                BookSprite *book = (BookSprite*)booksArr[i];
                [book setZOrder:8-i];
                CGPoint pos = ((BooksProperty *)boooksRowPosition[i]).position;
                [book runMoveActionWithPosition: pos andRotation:0];
            }
        }
            break;
        case NO:
        {
            _isFlowMode = YES;
//            [book1 runMoveActionWithPosition:ccp(517,348) andRotation:-10];
//            [book2 runMoveActionWithPosition:ccp(604,334) andRotation:-5];
//            [book3 runMoveActionWithPosition:ccp(680,356) andRotation:-15];
//            [book4 runMoveActionWithPosition:ccp(752,368) andRotation:0];
//            [book5 runMoveActionWithPosition:ccp(787,400) andRotation:10];
//            [book6 runMoveActionWithPosition:ccp(807,415) andRotation:10];
//            [book7 runMoveActionWithPosition:ccp(826,427) andRotation:10];
//            [book8 runMoveActionWithPosition:ccp(848,435) andRotation:10];
            for (int i=0; i<[booksArr count]; i++) {
                BookSprite *book = (BookSprite*)booksArr[i];
                [book setZOrder:8-i];
                CGPoint pos = ((BooksProperty *)booksPropertyArr[i]).position;
                CGFloat angle = ((BooksProperty *)booksPropertyArr[i]).rotation;
                [book runMoveActionWithPosition: pos andRotation:angle];
            }
        }
            break;
        default:
            break;
    }
}

- (void)pushToTopWithBook:(NSInteger)num
{
    if (num > 0) {
        
        id selectedObj = [booksArr objectAtIndex:num];
        [booksArr removeObject:selectedObj];
        [booksArr insertObject:selectedObj atIndex:0];
        
        for (int i=0; i<[booksArr count]; i++) {
            BookSprite *book = (BookSprite*)booksArr[i];
            [book setZOrder:8-i];
            CGPoint pos = ((BooksProperty *)booksPropertyArr[i]).position;
            CGFloat angle = ((BooksProperty *)booksPropertyArr[i]).rotation;
            [book runMoveActionWithPosition: pos andRotation:angle];
        }
    }
}

- (void)pushToTopWithDirection:(kDirectionType)direction
{
    if (direction == kDirectionLeft) {
        id firstObject = [booksArr firstObject];
        [booksArr removeObjectAtIndex:0];
        [booksArr addObject:firstObject];
    }else{
        id lastObject = [booksArr lastObject];
        [booksArr removeLastObject];
        [booksArr insertObject:lastObject atIndex:0];
    }
    
    for (int i=0; i<[booksArr count]; i++) {
        BookSprite *book = (BookSprite*)booksArr[i];
        [book setZOrder:8-i];
        CGPoint pos = ((BooksProperty *)booksPropertyArr[i]).position;
        CGFloat angle = ((BooksProperty *)booksPropertyArr[i]).rotation;
        [book runMoveActionWithPosition: pos andRotation:angle];
    }
}

@end
