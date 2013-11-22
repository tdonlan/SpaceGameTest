//
//  Planet.m
//  SpaceGame
//
//  Created by Tim Donlan on 7/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Planet.h"


@implementation Planet

+ (id)initWithTexture:(CCTexture2D *)texture:(CGPoint)atPosition:(float)withRadius
{
    
    Planet *e = [[Planet alloc]initWithTexture:texture];
    e.position=atPosition;
    e->radius=10;
    
    e->Origin = ccp(19,19);
    
    return e;
    
}



-(void)Update:(ccTime)dt:(GameLayer *)game
{
    //just spin around for now
    self.rotation += 10 * dt;
}


@end
