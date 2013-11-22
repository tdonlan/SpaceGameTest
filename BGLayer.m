//
//  BGLayer.m
//  SpaceGame
//
//  Created by Tim Donlan on 6/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BGLayer.h"
#import "GameLayer.h"

@implementation BGLayer

-(id) init
{
    if(self=[super init])
    {
        winSize = [[CCDirector sharedDirector] winSize];
        
        bgSprite1 = [CCSprite spriteWithFile:@"StarBG.png"];
        bgSprite1.anchorPoint = ccp(0,0);
        
        bgSprite2 = [CCSprite spriteWithFile:@"StarBG.png"];
        bgSprite2.anchorPoint = ccp(0,0);
        bgSprite2.position = ccp(-winSize.width,0);
        
        bgSprite3 = [CCSprite spriteWithFile:@"StarBG.png"];
        bgSprite3.anchorPoint = ccp(0,0);
        bgSprite3.position = ccp(-winSize.width,-winSize.height);
        
        bgSprite4 = [CCSprite spriteWithFile:@"StarBG.png"];
        bgSprite4.anchorPoint = ccp(0,0);
        bgSprite4.position = ccp(0,-winSize.height);
        
        [self addChild:bgSprite1];
        [self addChild:bgSprite2];
        [self addChild:bgSprite3];
        [self addChild:bgSprite4];
        
    }
    return self;
    
}


-(void)Update:(ccTime)dt:(GameLayer *)game
{
    CGPoint tempVel = game->player->Velocity;
    
    bgVector = ccpMult(tempVel, -10);
    //vel = ccpNormalize(vel);
    

    [self UpdateSprite:bgSprite1 withDelta:dt];
    [self UpdateSprite:bgSprite2 withDelta:dt];
    [self UpdateSprite:bgSprite3 withDelta:dt];
    [self UpdateSprite:bgSprite4 withDelta:dt];
    

}

-(void)UpdateSprite:(CCSprite *)sprite withDelta:(ccTime)delta
{
    CGPoint newPos = ccpAdd(sprite.position, ccpMult(bgVector, delta));
    [sprite setPosition:newPos];
    
    
    if(sprite.position.x > winSize.width )
    {
        sprite.position = ccp(-winSize.width,sprite.position.y);
    }
    
    if(sprite.position.x < -winSize.width )
    {
        sprite.position = ccp(winSize.width,sprite.position.y);
    }
    
    
    if(sprite.position.y > winSize.height )
    {
        sprite.position = ccp(sprite.position.x,-winSize.height);
    }
    
    if(sprite.position.y < -winSize.height )
    {
        sprite.position = ccp(sprite.position.x,winSize.height);
    }
    
}



@end
