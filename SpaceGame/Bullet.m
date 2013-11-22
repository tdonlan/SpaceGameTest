//
//  Bullet.m
//  SpaceGame
//
//  Created by Tim Donlan on 6/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"

#import "Collision.h"
#import "GameLayer.h"

@implementation Bullet

+ (id)initWithTexture:(CCTexture2D *)texture:(CGPoint)atPosition:(CGPoint)withVelocity:(float)withRadius
{
    Bullet *b = [[Bullet alloc]initWithTexture:texture];
    b->radius= withRadius;
    b.position = atPosition;
    b->Velocity = withVelocity;
    b->canRemove = NO;
    
    return b;
}


-(void)Update:(ccTime)dt:(GameLayer *)game
{
    self.position  = ccpAdd(self.position, ccpMult(self->Velocity, dt));
    
    if(distance(self.position, game->player.position) > 500)
    {
        self->canRemove;
    }
    /*
     
   if(!CGRectContainsPoint(game->screenRect, self.position))
   {
       self->canRemove = YES;
   }
     */
    
       
}


@end
