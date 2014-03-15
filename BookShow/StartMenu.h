//
//  StartMenu.h
//  BookShow
//
//  Created by Lion on 14-3-15.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "CCPhysicsSprite.h"
#import "Box2D.h"
#import "CCBReader.h"
#import "CCBAnimationManager.h"


#define PTM_RATIO 32

@interface StartMenu : CCLayer
{
    b2World* world;
    CCSprite *apple1;
    CCSprite *apple2;
    CCSprite *apple3;
    CCSprite *logo;
    CCSprite *basket;
    CCArray *applesArr;
}
+ (id)scene;
@property (strong, nonatomic) CCBAnimationManager* animationManager;

@end
