//
//  StartMenu.m
//  BookShow
//
//  Created by Lion on 14-3-15.
//  Copyright (c) 2014年 wufei. All rights reserved.
//

#import "StartMenu.h"
#import "MultiLayerScene.h"


class myContactListener: public b2ContactListener
{
    virtual void EndContact(b2Contact* contact);
};

void myContactListener::EndContact(b2Contact *contact)
{
    b2Body* bodyA = contact->GetFixtureA()->GetBody();
	b2Body* bodyB = contact->GetFixtureB()->GetBody();
	CCSprite* spriteA = (__bridge CCSprite*)bodyA->GetUserData();
	CCSprite* spriteB = (__bridge CCSprite*)bodyB->GetUserData();
    
	if (spriteA != NULL && spriteB != NULL)
	{
        if (spriteA.tag == 100) {
            StartMenu *parentNode = (id)[spriteA parent];
            [parentNode.animationManager runAnimationsForSequenceNamed:@"Logo_Shake"];
        }
	}
}

@implementation StartMenu
{
    CGRect treeRect;
    CCSprite *selectApple;
}
+ (id)scene
{
    return [[self alloc] init];
}

- (id)init
{
    if (self= [super init]) {
        [self initPhysics];
        [self setTouchEnabled:YES];
        
        [self scheduleUpdate];
    }
    return self;
}

- (void) didLoadFromCCB
{
    // Start rotating the burst sprite
    // Define another box shape for our dynamic body.
    [self addPhysicsBodyToSprite:apple1];
    [self addPhysicsBodyToSprite:apple2];
    [self addPhysicsBodyToSprite:apple3];
    [self addEdgeToBasket:basket];
    [self addEdgeToLogo];
    [basket setZOrder:2];
    applesArr = [[CCArray alloc] init];
    [applesArr addObject:apple1];
    [applesArr addObject:apple2];
    [applesArr addObject:apple3];
    
    _animationManager = self.userObject;
    
    treeRect = CGRectMake(0, 600, 524, 168);
	
}

- (void)initPhysics
{
    CGSize s = [[CCDirector sharedDirector] winSize];
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	world = new b2World(gravity);
	
	
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(true);
	world->SetContinuousPhysics(true);
    
    myContactListener *contactListener = new myContactListener();
    world->SetContactListener(contactListener);

	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;
	
	// bottom
	
	groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
}

-(void) update: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 2;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
    for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL)
		{
			CCSprite *myActor = (CCSprite*)b->GetUserData();
            if (myActor.tag == 100) continue;
			myActor.position = CGPointMake(
                                           b->GetPosition().x * PTM_RATIO,
                                           b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            
            if (CGRectContainsRect(basket.boundingBox, myActor.boundingBox) && [applesArr containsObject:myActor]) {
                world->DestroyBody(b);
                [applesArr removeObject:myActor];
                [self removeChild:myActor cleanup:YES];
                CCLOG(@"delete Apple");
                CCParticleSystemQuad* effect_star = (CCParticleSystemQuad*) [CCBReader nodeGraphFromFile:@"effect_star.ccbi"];
                effect_star.autoRemoveOnFinish = YES;
                effect_star.position = basket.position;
                [self addChild:effect_star];
            }
		}	
	}
}

- (void)addPhysicsBodyToSprite:(CCSprite *)sprite
{
    b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
    bodyDef.awake = NO;
    bodyDef.userData = sprite;
	bodyDef.position.Set(sprite.position.x/PTM_RATIO, sprite.position.y/PTM_RATIO);
//    bodyDef.linearVelocity = b2Vec2(15,1);
	b2Body *body = world->CreateBody(&bodyDef);
    
    b2CircleShape circleShape;
    circleShape.m_radius = sprite.contentSize.width*sprite.scale/(2*PTM_RATIO);
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
    fixtureDef.shape = &circleShape;
	fixtureDef.density = 2.0;
	fixtureDef.friction = 1.0f;
    fixtureDef.restitution = 0.5f;
	body->CreateFixture(&fixtureDef);
}

- (void)addEdgeToBasket:(CCSprite *)sprite
{
    b2BodyDef basketBodyDef;
    basketBodyDef.type = b2_staticBody;
    basketBodyDef.userData = sprite;
    basketBodyDef.position.Set(sprite.position.x/PTM_RATIO, sprite.position.y/PTM_RATIO);
    
    b2Body *basketBody = world->CreateBody(&basketBodyDef);
    CGPoint point1 = ccp(- sprite.contentSize.width/2, sprite.contentSize.height/2);
    CGPoint point2 = ccp(- sprite.contentSize.width/2, - sprite.contentSize.height/2);
    CGPoint point3 = ccp(sprite.contentSize.width/2, - sprite.contentSize.height/2);
    CGPoint point4 = ccp(sprite.contentSize.width/2, sprite.contentSize.height/2);
    
    b2EdgeShape edgeShape;
    edgeShape.Set(b2Vec2(point1.x/PTM_RATIO, point1.y/PTM_RATIO), b2Vec2(point2.x/PTM_RATIO, point2.y/PTM_RATIO));
    basketBody->CreateFixture(&edgeShape, 0);
    
    edgeShape.Set(b2Vec2(point2.x/PTM_RATIO, point2.y/PTM_RATIO), b2Vec2(point3.x/PTM_RATIO, point3.y/PTM_RATIO));
    basketBody->CreateFixture(&edgeShape, 0);
    
    edgeShape.Set(b2Vec2(point3.x/PTM_RATIO, point3.y/PTM_RATIO), b2Vec2(point4.x/PTM_RATIO, point4.y/PTM_RATIO));
    basketBody->CreateFixture(&edgeShape, 0);
    
}

- (void)addEdgeToLogo
{
    b2BodyDef logoBodyDef;
    logoBodyDef.type = b2_staticBody;
    logoBodyDef.userData = logo;
    logoBodyDef.position.Set(logo.position.x/PTM_RATIO, logo.position.y/PTM_RATIO);
    
    b2Body *logoBody = world->CreateBody(&logoBodyDef);
    
    b2PolygonShape staticBox;
    staticBox.SetAsBox(logo.contentSize.width/(2*PTM_RATIO), logo.contentSize.height/(2*PTM_RATIO));
    logoBody->CreateFixture(&staticBox, 0);
}


- (void)goToRead:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[MultiLayerScene scene]];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [[CCDirector sharedDirector] convertTouchToGL:[touches anyObject]];
    
    
    if (CGRectContainsPoint(treeRect, pos)) {
        CCSprite *appleSprite = [CCSprite spriteWithFile:@"bs_apple.png"];
        [appleSprite setPosition:pos];
        [appleSprite setScale:CCRANDOM_0_1()*0.5+1.0];
        [self addChild:appleSprite];
        [self addPhysicsBodyToSprite:appleSprite];
        [applesArr addObject:appleSprite];
    }
    
}

- (void)onExit
{
    [self removeAllChildrenWithCleanup:YES];
}

-(void) dealloc
{
	delete world;
	world = NULL;
	
	[super dealloc];
}

@end
