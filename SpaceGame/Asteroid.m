//
//  Asteroid.m
//  SpaceGame
//
//  Created by Tim Donlan on 7/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Asteroid.h"
#import "Collision.h"


@implementation Asteroid


+ (id)initWithTexture:(CCTexture2D *)texture:(CGPoint)atPosition:(float)withRadius
{
    
    Asteroid *e = [[Asteroid alloc]initWithTexture:texture];
    e.position=atPosition;
    e->radius=10;
    
    e->Origin = ccp(19,19);
    
    return e;
    
}

-(void)Hit:(Bullet *)b
{
    if([Collision intersectCircleCircle:self.position withRadius:self->radius withCircle:b.position withRadius:b->radius])
    {
        self->canRemove = YES;
        b->canRemove = YES;
    }
}

-(void)Update:(ccTime)dt:(GameLayer *)game
{
    //just spin around for now
    self.rotation += 10 * dt;
}


@end
