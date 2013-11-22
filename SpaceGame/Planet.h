//
//  Planet.h
//  SpaceGame
//
//  Created by Tim Donlan on 7/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer;

@interface Planet : CCSprite {
@public CGPoint Origin;
    
    float radius;
    
    BOOL canRemove;

    
}

+ (id)initWithTexture:(CCTexture2D *)texture:(CGPoint)atPosition:(float)withRadius;


-(void)Update:(ccTime)dt:(GameLayer *)game;

@end
