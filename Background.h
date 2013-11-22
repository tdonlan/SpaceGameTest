//
//  Background.h
//  SpaceGame
//
//  Created by Tim Donlan on 6/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer;

@interface Background : CCNode {
    @public
    CCTexture2D * BGTexture;

    
    CCSprite *sprite0; //top-left
    CCSprite *sprite1; //top-right
    CCSprite *sprite2; //bottom-left
    CCSprite *sprite3; //bottom-right
    
    NSMutableArray *BGSpriteArray; //4 total for 2D scrolling
    
}

+ (id)initWithTexture:(CCTexture2D *)texture;


-(void)Update:(ccTime)dt:(GameLayer *)game;


@end
