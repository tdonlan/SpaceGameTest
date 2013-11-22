//
//  GameLayer.h
//  SpaceGame
//
//  Created by Tim Donlan on 6/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HUDLayer.h"
#import "BGLayer.h"
#import "PlayerShip.h"
#import "Background.h"
#import "Bullet.h"
#import "CCFollowDynamic.h"
#import "Enemy.h"
#import "Asteroid.h"
#import "Pickup.h"
#import "Planet.h"

@interface GameLayer : CCLayer {
    @public
    
    CGSize winSize;
    
    HUDLayer *hudLayer;
    BGLayer *bgLayer;
    
    @public PlayerShip *player;
    
    //Move all these to a texture object
    CCTexture2D * playerTexture;
    CCTexture2D * bgTexture;
    CCTexture2D * bulletTexture;
    CCTexture2D * enemyTexture;
    CCTexture2D * asteroidTexture;
    CCTexture2D * pickupTexture;
    CCTexture2D * planetTexture;
    
    CGPoint leftThumbPress;
    
    Background *background;
    
    CGRect screenRect;
    
    
    NSMutableArray * bulletArray;
    NSMutableArray * enemyBulletArray;
    NSMutableArray * enemyArray;
    
    NSMutableArray * planetArray;
    NSMutableArray * pickupArray;
    NSMutableArray * asteroidArray;
    
}

+(CCScene *) scene;

-(void) SpawnBullet:(Bullet*)withBullet;
-(void) DespawnBullet:(Bullet*)withBullet;

-(void) SpawnEnemy:(Enemy*)withEnemy;
-(void) DespawnEnemy:(Enemy*)withEnemy;

-(void) SpawnAsteroid:(Asteroid*)a;
-(void) DespawnAsteroid:(Asteroid*)a;

-(void) SpawnPickup:(Pickup*)p;
-(void) DespawnPickup:(Pickup*)p;

-(void) SpawnPlanet:(Planet*)p;
-(void) DespawnPlanet:(Planet*)p;

@end
