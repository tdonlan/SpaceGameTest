//
//  HUDLayer.m
//  SpaceGame
//
//  Created by Tim Donlan on 6/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "GameLayer.h"
#import "Collision.h"

@implementation HUDLayer

-(id) init
{
    if(self=[super init])
    {
        thumbpadTexture0 = [[CCTextureCache sharedTextureCache]  addImage:@"Thumbstick0.png"];
         thumbpadTexture1 = [[CCTextureCache sharedTextureCache]  addImage:@"Thumbstick1.png"];
        thumbpadSprite = [CCSprite spriteWithTexture:thumbpadTexture0];
        thumbpadSprite.position = ccp(50, 50);
        
        [self addChild:thumbpadSprite];
        
        infoString = [NSString stringWithFormat:@"Test"];
        infoLabel = [CCLabelTTF labelWithString:infoString fontName:@"Courier" fontSize:15];
        infoLabel.position = ccp(200, 300);
        infoLabel.color = ccRED;
        [self addChild:infoLabel];
        
        CCMenuItemImage *fireButton = [CCMenuItemImage itemFromNormalImage:@"Thumbstick0.png" selectedImage:@"Thumbstick0.png" target:self selector:@selector(FireButton:)];
        
        CCMenu *actionMenu = [CCMenu menuWithItems:fireButton, nil];
        actionMenu.position = ccp(400,50);
        
        [self addChild:actionMenu];
        
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        self.isTouchEnabled = YES;

        
    }
      return self;

}


-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    leftThumbPress = [self convertTouchToNodeSpace:touch];
    if(CGRectContainsPoint(thumbpadSprite.boundingBox, leftThumbPress))
    {
        isThumbPress = YES;
        
    }

    return YES;
    
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    leftThumbPress = [self convertTouchToNodeSpace:touch];
    if(CGRectContainsPoint(thumbpadSprite.boundingBox, leftThumbPress))
    {
        isThumbPress = YES;
        
    }
    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    isThumbPress = NO;
    
}

-(void)FireButton:(id)sender
{
    //use current player rotation
    float rot = game->player->rotationRadians;
    
    CGPoint playerRotation = ccp(cosf(rot),sinf(rot) * -1);
    playerRotation = ccpNormalize(playerRotation);
    
    CGPoint velocity = ccpMult(playerRotation, 500);
    Bullet *b = [Bullet initWithTexture:game->bulletTexture :game->player.position :velocity :5 ];
    [game SpawnBullet:b];
}


-(void)Update:(GameLayer *)game
{
   [self getThumbPress:leftThumbPress];

    //self->game = game;
    NSString * posStr = NSStringFromCGPoint(game->player.position);
    //infoString = [NSString stringWithFormat:@"%@ %d",posStr,isThumbPress    ];
    //infoLabel.string = infoString;
    
    if(isThumbPress)
    {
        game->player->Acceleration = thumbpressPos;
    }
    else
    {
        
        game->player->Acceleration = ccp(0, 0);
    }
    
}

//determine if we're touchign the thumbpad
//if so, determine the distance from center, and the direction vector
-(void)getThumbPress:(CGPoint)pos
{
    if(isThumbPress)
    {
        CGPoint dir = ccpSub(pos, thumbpadSprite.position);
        dir = ccpNormalize(dir);
        float dist = distance(pos,thumbpadSprite.position);
        
        float thumbpadRadius = thumbpadSprite.boundingBox.size.width / 2;
        
        float pressAmt = clampf(dist / thumbpadRadius, 0, 1 );
        
        //use lerp based on distance from center
    
        thumbpressPos = ccp(lerpf(0,dir.x,pressAmt),lerpf(0,dir.y,pressAmt) );
        
        float radians = atan2f(thumbpressPos.y *-1, thumbpressPos.x) + 3.1415;
        thumbpadSprite.texture = thumbpadTexture1;
        thumbpadSprite.rotation = CC_RADIANS_TO_DEGREES(radians);
             
    }
    else{
        
        thumbpadSprite.texture = thumbpadTexture0;
    }
   
}



@end
