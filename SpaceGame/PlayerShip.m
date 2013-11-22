//
//  PlayerShip.m
//  SpaceGame
//
//  Created by Tim Donlan on 6/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PlayerShip.h"
#import "Collision.h"
#import "GameLayer.h"


@implementation PlayerShip

+ (id)initWithTexture:(CCTexture2D *)texture:(CGPoint)atPosition:(float)withRadius
{

    PlayerShip *p = [[PlayerShip alloc]initWithTexture:texture];
    p.position=atPosition;
    p->radius=10;
    
    p->Origin = ccp(19,19);
   
    p->Velocity = ccp(0,0);
    
    p->speed = 50;
    p->rotationRadians = 0;
        
    return p;
    
}


-(void)Update:(ccTime)dt:(GameLayer *)game
{
    Velocity = ccpAdd(Velocity, ccpMult(Acceleration, dt));
    Velocity = ccpClamp(Velocity, ccp(-5,-5), ccp(5,5));
    

   self.position = ccpAdd(self.position,  ccpMult(Velocity, dt * speed));

    //wrap around
    [self CheckPositionInWorld];
    
    
    game->hudLayer->infoLabel.string = [NSString stringWithFormat:@"%@  %@",NSStringFromCGPoint(self.position), NSStringFromCGPoint(Velocity)];
    
    if(Acceleration.x != 0 && Acceleration.y != 0)
    {
        
        float newRotation = atan2f(Acceleration.y * -1, Acceleration.x) ;
        
    
            
        //rotationRadians = lerpf(rotationRadians,newRotation,.1);
        
        rotationRadians =  newRotation;
    }
    else
    {
        
        float newRotation = atan2f(Velocity.y * -1, Velocity.x);
        if(newRotation < 0)
        {
            newRotation += 3.1415 * 2;
        }
        
        //rotationRadians = lerpf(rotationRadians,newRotation,.1);
        
        //rotationRadians = newRotation;
        
          Velocity = ccpMult(Velocity, .99);
        
    }
    
 
  
    self.rotation =   CC_RADIANS_TO_DEGREES(rotationRadians);
    
}

//have the player loop around in position once we get to edge of world space
//currently hardcoded at -5000,5000 x 5000, -5000
-(void)CheckPositionInWorld
{
    if(self.position.x < -5000)
    {
        [self setPosition:ccp(5000, self.position.y)];
    }
    if(self.position.x > 5000)
    {
         [self setPosition:ccp(-5000, self.position.y)];
    }
    if(self.position.y < -5000)
    {
         [self setPosition:ccp(self.position.x, 5000)];
    }
    if(self.position.y > 5000)
    {
         [self setPosition:ccp(self.position.x, -5000)];
    }
}

//UNUSED
-(float)getNewRotation:(float)rotationRadians:(float)newRotation
{
    if(rotationRadians > (3*PI)/2 && rotationRadians < (2*PI) && newRotation < (PI/2) && newRotation > 0)
    {
        return newRotation + (2*PI);
        
    }
    else
    {
        return newRotation;
    }
}


@end
