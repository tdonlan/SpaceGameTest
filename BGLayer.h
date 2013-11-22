//
//  BGLayer.h
//  SpaceGame
//
//  Created by Tim Donlan on 6/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer;

@interface BGLayer : CCLayer {
    @public GameLayer * game;
    
    CCSprite *bgSprite1;
    CCSprite *bgSprite2;
    CCSprite *bgSprite3;
    CCSprite *bgSprite4;
    
    CGPoint bgVector;
    
    CGSize  winSize;

    
    
}

-(void)Update:(ccTime)dt:(GameLayer *)game;

@end
