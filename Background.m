//
//  Background.m
//  SpaceGame
//
//  Created by Tim Donlan on 6/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Background.h"
#import "GameLayer.h"
#import "PlayerShip.h"


@implementation Background

+ (id)initWithTexture:(CCTexture2D *)texture
{
    
    Background *bg = [[Background alloc]init];
    
    bg->BGTexture = texture;
  
    
    bg->sprite0 = [CCSprite spriteWithTexture:texture];
    bg->sprite0.position = ccp(0,320);
    //bg->sprite0.color = ccRED;
    [bg addChild:bg->sprite0];
    
     bg->sprite1 = [CCSprite spriteWithTexture:texture];
    //bg->sprite1.position = ccp(480,320);
    //bg->sprite1.color = ccBLUE;
     [bg addChild:bg->sprite1];
    
     bg->sprite2 = [CCSprite spriteWithTexture:texture];
    //bg->sprite2.position = ccp(0,0);
    //bg->sprite2.color = ccGREEN;
     [bg addChild:bg->sprite2];
    
     bg->sprite3 = [CCSprite spriteWithTexture:texture];
    //bg->sprite3.position = ccp(480,0);
    //bg->sprite3.color = ccYELLOW;
     [bg addChild:bg->sprite3];
    
    [bg updateBGPositions:bg->sprite0.position];
    
    return bg;

  
}

//set all the bg positions based on coordinate of top left
-(void)updateBGPositions:(CGPoint)pos
{
    
    sprite0.position = pos;
    sprite1.position = ccpAdd(pos, ccp(480, 0));
    sprite2.position = ccpAdd(pos, ccp(0, -320));
    sprite3.position = ccpAdd(pos, ccp(480, -320));
}


-(void)Update:(ccTime)dt:(GameLayer *)game
{
    CGPoint pos = game->player.position;
    float xPos = pos.x -  ((int)pos.x % 480);
    float yPos = pos.y+320 - ((int)pos.y % 320);
    
    [self updateBGPositions:ccp(xPos,yPos)];
    
}

@end
