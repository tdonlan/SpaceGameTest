//
//  PlayerShip.h
//  SpaceGame
//
//  Created by Tim Donlan on 6/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define PI 3.1415

@class GameLayer;

@interface PlayerShip : CCSprite {
    @public
     @public CGPoint Acceleration;
     @public CGPoint Velocity;
     @public CGPoint Origin;
    
    float rotationRadians;
    float speed;
    float radius;
 
    
}

+ (id)initWithTexture:(CCTexture2D *)texture:(CGPoint)atPosition:(float)withRadius;


-(void)Update:(ccTime)dt:(GameLayer *)game;

@end
