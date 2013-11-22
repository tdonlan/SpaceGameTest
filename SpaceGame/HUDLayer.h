//
//  HUDLayer.h
//  SpaceGame
//
//  Created by Tim Donlan on 6/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer;

@interface HUDLayer : CCLayer {
      @public GameLayer * game;
    CCTexture2D * thumbpadTexture0;
     CCTexture2D *thumbpadTexture1;
    CCSprite * thumbpadSprite;
    
    
   
    
    CCLabelTTF  *infoLabel;
    NSString * infoString;
    
    BOOL isThumbPress;
    CGPoint thumbpressPos;
  
    CGPoint leftThumbPress;
    
}

-(void)Update:(GameLayer *)game;
-(void)getThumbPress:(CGPoint)pos;


@end
