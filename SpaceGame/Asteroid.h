//
//  Asteroid.h
//  SpaceGame
//
//  Created by Tim Donlan on 7/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Bullet.h"

@class GameLayer;

@interface Asteroid : CCSprite {
    @public CGPoint Origin;
    
    float radius;
    
    BOOL canRemove;
    
}

+ (id)initWithTexture:(CCTexture2D *)texture:(CGPoint)atPosition:(float)withRadius;


-(void)Update:(ccTime)dt:(GameLayer *)game;

-(void)Hit:(Bullet *)b;

@end
