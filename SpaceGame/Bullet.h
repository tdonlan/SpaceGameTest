//
//  Bullet.h
//  SpaceGame
//
//  Created by Tim Donlan on 6/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer;

@interface Bullet : CCSprite {
@public CGPoint Velocity;
@public CGPoint Origin;
    float radius;
    
    BOOL canRemove;
}

+ (id)initWithTexture:(CCTexture2D *)texture:(CGPoint)atPosition:(CGPoint)withVelocity:(float)withRadius;


-(void)Update:(ccTime)dt:(GameLayer *)game;


@end
