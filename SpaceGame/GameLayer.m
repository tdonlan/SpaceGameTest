//
//  GameLayer.m
//  SpaceGame
//
//  Created by Tim Donlan on 6/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "Collision.h"


@implementation GameLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
    HUDLayer *hudLayer = [[[HUDLayer alloc]init]autorelease];
    BGLayer *bgLayer = [[[BGLayer alloc]init]autorelease];
    
	// 'layer' is an autorelease object.
	GameLayer *layer =  [[[GameLayer alloc]initWithHud:hudLayer]autorelease];
    layer->bgLayer = bgLayer;
    hudLayer->game = layer;
	
	// add layer as a child to scene
    [scene addChild:bgLayer];
	[scene addChild: layer];
    [scene addChild: hudLayer];
    
	// return the scene
	return scene;
}

-(id) initWithHud:(HUDLayer*)hud
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init]))
    {
        self->hudLayer = hud;
        self->hudLayer->game = self;
        
        
        //Background
        winSize = [[CCDirector sharedDirector] winSize];
        
        // background
        bgTexture = [[CCTextureCache sharedTextureCache]  addImage:@"StarBG.png"];
        background = [Background initWithTexture:bgTexture  ];
        //[self addChild:background];
        

        
        //-------------

        
        //bullets
        bulletTexture = [[CCTextureCache sharedTextureCache]  addImage:@"Bullet1.png"];
        bulletArray = [[NSMutableArray alloc]init];
        
        //enemies
        enemyTexture = [[CCTextureCache sharedTextureCache] addImage:@"Enemy1.png"];
         enemyArray = [[NSMutableArray alloc]init];
        enemyBulletArray = [[NSMutableArray alloc]init];
        [self SpawnRandomEnemies];
        
        //Asteroids
        asteroidTexture = [[CCTextureCache sharedTextureCache]  addImage:@"asteroid.png"];
        asteroidArray = [[NSMutableArray alloc]init];
        [self SpawnRandomAsteroids];
        
        //Planets
        planetTexture = [[CCTextureCache sharedTextureCache]  addImage:@"planet.png"];
        planetArray = [[NSMutableArray alloc]init];
        [self SpawnRandomPlanets];
        
        
        playerTexture = [[CCTextureCache sharedTextureCache]  addImage:@"Ship.png"];
        
        player = [PlayerShip initWithTexture:playerTexture :ccp(0, 0) :10];
        
        [self addChild:player];
        
        //Pickups
        pickupTexture = [[CCTextureCache sharedTextureCache]  addImage:@"Pickup.png"];
        planetArray = [[NSMutableArray alloc]init];
        
        
        
        [self schedule:@selector(Update:)];
        

        [self runAction:[CCFollowDynamic actionWithTarget:player smoothingFactor:0.5    ]];
        
        //[self runAction:[CCFollow actionWithTarget:player]];
		
	}
	return self;
}

- (void)Update:(ccTime)delta
{
   
    //[hudLayer getThumbPress:leftThumbPress];
    
    [hudLayer Update:self];
    [player Update:delta :self];
  
    [bgLayer Update:delta :self];
    
    screenRect = [self getScreenRect];
    
    [self UpdateBullets:delta];
    [self UpdateEnemies:delta];
    [self UpdateAsteroids:delta];
    [self UpdatePickups:delta];
    [self UpdatePlanets:delta];
    
   
    
}

-(void)UpdateEnemies:(ccTime)dt
{
    
    if(arc4random() % 1000 < 10)
       {
           if(enemyArray.count < 50)
           {
               [self SpawnRandomEnemies];
           }
       }
    
    
    NSMutableArray *removeEnemies = [[NSMutableArray alloc]init];
    
    for(Enemy *e in enemyArray)
    {
        [e Update:dt :self];
        if(e->canRemove)
        {
            [removeEnemies addObject:e];
        }
        
    }
    
    for(Enemy *e in removeEnemies)
    {
        [self DespawnEnemy:e];
    }
}

-(void)UpdateBullets:(ccTime)dt
{
    NSMutableArray *removeBullets = [[NSMutableArray alloc]init];
    
    for(Bullet *b in bulletArray)
    {
        [b Update:dt :self];
        
        for(Enemy *e in enemyArray)
        {
            if(distance(e.position, b.position) < 100)
            {
                [e Hit:b];
            }
        }
        
        
        if(b->canRemove)
        {
            
            [removeBullets addObject:b];
        }
      
    }
    
    for(Bullet *b in removeBullets    )
    {
        [self DespawnBullet:b];
    }
}

-(void)UpdateAsteroids:(ccTime)dt
{
    
    if(arc4random() % 1000 < 10)
    {
        if(asteroidArray.count < 50)
        {
            [self SpawnRandomEnemies];
        }
    }
    
    
    NSMutableArray *removeAsteroids = [[NSMutableArray alloc]init];
    
    for(Asteroid *a in asteroidArray)
    {
        [a Update:dt :self];
        if(a->canRemove)
        {
            [removeAsteroids addObject:a];
        }
        
    }
    
    for(Asteroid *e in removeAsteroids)
    {
        [self DespawnAsteroid:e];
    }
}

-(void)UpdatePickups:(ccTime)dt
{
    
    
    
    /*
    if(arc4random() % 1000 < 10)
    {
        if(enemyArray.count < 50)
        {
            [self SpawnRandomEnemies];
        }
    }
     */
    
    
    NSMutableArray *removePickups = [[NSMutableArray alloc]init];
    
    for(Pickup *e in pickupArray)
    {
        [e Update:dt :self];
        if(e->canRemove)
        {
            [removePickups addObject:e];
        }
        
    }
    
    for(Pickup *e in removePickups)
    {
        [self DespawnPickup:e];
    }
}

-(void)UpdatePlanets:(ccTime)dt
{
 

    for(Planet *e in planetArray)
    {
        [e Update:dt :self];
       
    }
    
 
}

-(CGRect)getScreenRect
{
    CGPoint pos = player.position;
   
    return CGRectMake(pos.x -  winSize.width / 2, pos.y -  winSize.height / 2, pos.x +  winSize.width / 2,  pos.y+ winSize.height / 2);
}

/*
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   leftThumbPress = [self convertTouchToNodeSpace:touch];

   
    return YES;
    
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    leftThumbPress = [self convertTouchToNodeSpace:touch];
    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{   leftThumbPress = [self convertTouchToNodeSpace:touch];
       
}
 */


-(void) SpawnBullet:(Bullet*)withBullet
{
    
    [bulletArray addObject:withBullet];
    [self addChild:withBullet];
}

-(void) DespawnBullet:(Bullet*)withBullet
{
    [self removeChild:withBullet cleanup:NO];
    [bulletArray removeObject:withBullet];
}

-(void) SpawnRandomEnemies
{
    int num = arc4random() % 20;
    for(int i=0;i<num;i++)
    {
        CGPoint randomPt = [self GetRandomPoint];
        [self SpawnEnemy:[Enemy initWithTexture:enemyTexture :randomPt :25   ]];
    }
 
}

-(void) SpawnRandomPlanets
{
    for(int i=0;i<5;i++)
    {
        CGPoint randomPt = [self GetRandomPoint];
        [self SpawnPlanet:[Planet initWithTexture:planetTexture :randomPt :150   ]];
    }
}

-(void) SpawnRandomAsteroids
{
    int num = arc4random() % 20;
    for(int i=0;i<num;i++)
    {
        CGPoint randomPt = [self GetRandomPoint];
        [self SpawnAsteroid:[Asteroid initWithTexture:asteroidTexture :randomPt :25   ]];
    }
}
                                  
-(CGPoint) GetRandomPoint
{
    float mult1 = 1;
    float mult2 = 1;
    if(arc4random() % 2 % 2 == 0)
    {
        mult1 = -1;
    }
    
    if(arc4random() % 2 % 2 == 0)
    {
        mult2 = -1;
    }
    
    return ccp(arc4random() % 1000 * mult1, arc4random() % 1000 * mult2);
    
}


-(void) SpawnEnemy:(Enemy*)withEnemy
{
    [enemyArray addObject:withEnemy];
    [self addChild:withEnemy];

}
-(void) DespawnEnemy:(Enemy*)withEnemy
{
    [self removeChild:withEnemy cleanup:NO];
    [enemyArray removeObject:withEnemy];
}


-(void) SpawnAsteroid:(Asteroid*)a
{
    [asteroidArray addObject:a];
    [self addChild:a];
}

-(void) DespawnAsteroid:(Asteroid*)a
{
    [self removeChild:a cleanup:NO];
    [asteroidArray removeObject:a];
}

-(void) SpawnPickup:(Pickup*)p
{
    [pickupArray addObject:p];
    [self addChild:p];
}
-(void) DespawnPickup:(Pickup*)p
{
    [self removeChild:p cleanup:NO];
    [pickupArray removeObject:p];
}

-(void) SpawnPlanet:(Planet*)p
{
    [planetArray addObject:p];
    [self addChild:p];
}
-(void) DespawnPlanet:(Planet*)p
{
    [self removeChild:p cleanup:NO];
    [planetArray removeObject:p];
}

-(CGRect)getScreen
{
    

    CGPoint o = player.position;
    CGRect retval = CGRectMake(o.x-winSize.width/2, o.y-winSize.height/2, o.x+winSize.width/2, o.y+winSize.height/2);
    
    return retval;
}

-(void)draw{
     [super draw];
    
    [self drawRectangle:[self getScreen]];
   // [self drawPosition:player.position];
    /*
    
    glEnable(GL_LINE_SMOOTH);
    glColor4ub(200, 200, 200, 255);
    glLineWidth(2);
    
    CGRect newScreenRect = [self getScreen];
    
    float x = newScreenRect.origin.x;
    float y = newScreenRect.origin.y;
    float x2 = newScreenRect.size.width;
    float y2 = newScreenRect.size.height;

    
    CGPoint vertices2[] = { ccp(x,y), ccp(x,y+y2), ccp(x+x2,y+y2), ccp(x+x2,y) };
    ccDrawPoly(vertices2, 4, YES);
     */
    
   
}


-(void)drawRectangle:(CGRect)Rect
{
    CGPoint TopLeft = Rect.origin;
    CGPoint TopRight = ccp(Rect.origin.x + Rect.size.width, Rect.origin.y);
    CGPoint BottomLeft = ccp(Rect.origin.x , Rect.origin.y + Rect.size.height);
    CGPoint BottomRight = ccp(Rect.origin.x + Rect.size.width, Rect.origin.y + Rect.size.height);
    
    glEnable(GL_LINE_SMOOTH);
    glColor4ub(200, 200, 200, 255);
    glLineWidth(2);
    
    CGPoint vertices2[] = { TopLeft, TopRight, BottomRight, BottomLeft };
    
    ccDrawPoly(vertices2, 4, YES);
}
 

-(void)drawPosition:(CGPoint)pos
{
    glEnable(GL_LINE_SMOOTH);
    glColor4ub(200, 200, 200, 255);
    glLineWidth(2);
    
    CGPoint vertices2[] = { ccp(pos.x-50,pos.y), ccp(pos.x+50,pos.y) };
    
    ccDrawPoly(vertices2, 2, YES);
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{

	[super dealloc];
}



@end
