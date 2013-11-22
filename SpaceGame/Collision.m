//
//  Collision.m
//  Heartline
//
//  Created by Tim Donlan on 3/27/13.
//
//

#import "Collision.h"
#import "cocos2d.h"

@implementation Collision

+(BOOL)intersectPointCircle:(CGPoint) pos withCircleOrigin:(CGPoint)origin withRadius:(float)radius
{
    if(distance(pos, origin) <= radius)
    {
        
         return YES;
    }
    else{
        return NO;
    }
}

+(BOOL)intersectLineLine:(CGPoint)A :(CGPoint)B withLine :(CGPoint)C :(CGPoint)D
{
    float x1 = A.x, x2 = B.x, x3 = C.x, x4 = D.x;
    float y1 = A.y,y2 = B.y,y3 = C.y,y4 = D.y;
    
    float d = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3-x4);
    if(d==0)
    {
        return NO;
    }
    float pre = (x1 * y2 - y1*x2),post =(x3*y4-y3*x4);
    float x = (pre*(x3-x4) - (x1-x2) * post) / d;
    float y = (pre *(y3-y4)-(y1-y2) *post)/d;
    
    //check if x and y are within both lines
    if(x < MIN(x1, x2) || x > MAX(x1,x2) || x < MIN(x3,x4) || x > MAX(x3,x4))
    {
        return NO;
    }
    
    if(y < MIN(y1,y2) || y > MAX(y1,y2) || y < MIN(y3,y4) || y > MAX(y3,y4))
    {
        return NO;
    }
    
    
    return YES;
}

+(BOOL)intersectCircleCircle:(CGPoint)CenterA withRadius:(float)radA withCircle:(CGPoint)CenterB withRadius:(float)radB
{
    if(ccpDistance(CenterA, CenterB) <= radA + radB)
    {
        return YES;
    }
    else{
        return NO;
    }
}



+(BOOL)intersectCircleLine:(CGPoint)pos withRadius:(float)radius withLine:(CGPoint)A toPoint:(CGPoint)B
{
    CGPoint dir = ccpSub(A, B);
    CGPoint diff = ccpSub(pos, A);
    
    float t =ccpDot(diff, dir) / ccpDot(dir, dir);
    if(t < 0.0f)
    {
        t = 0.0f;
    }
    if(t > 1.0f)
    {
        t = 1.0f;
    }
    
    CGPoint dir2 = ccpMult(dir, t);
    
    CGPoint closest =  ccpAdd(A, dir2);
    CGPoint d = ccpSub(pos, closest);
    
    float distsqr = ccpDot(d, d);
    return distsqr <= radius * radius;
}

//http://stackoverflow.com/questions/6068660/checking-a-line-segment-is-within-a-distance-from-a-point
+ (BOOL)intersectCircleLine2:(CGPoint)A :(CGPoint)B  withinRadius:(CGFloat)radius fromPoint:(CGPoint)point {
    
   
    CGPoint v = CGPointMake(B.x - A.x, B.y - A.y);
    CGPoint w = CGPointMake(point.x - A.x, point.y - A.y);
    CGFloat c1 = dotProduct(w, v);
    CGFloat c2 = dotProduct(v, v);
    CGFloat d;
    if (c1 <= 0) {
        d = distance(point, A);
    }
    else if (c2 <= c1) {
        d = distance(point, B);
    }
    else {
        CGFloat b = c1 / c2;
        CGPoint Pb = CGPointMake(A.x + b * v.x, A.y + b * v.y);
        d = distance(point, Pb);
    }
    return d <= radius;
}

CGFloat distance(const CGPoint p1, const CGPoint p2) {
    return sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2));
}

CGFloat dotProduct(const CGPoint p1, const CGPoint p2) {
    return p1.x * p2.x + p1.y * p2.y;
}

CGFloat lerpf(float fStart, float fEnd, float fPercent)
{
    return fStart + ((fEnd - fStart) * fPercent);
}


+(BOOL)intersectRectCircle:(CGRect)rect withPoint:(CGPoint)pos withRadius:(float)radius
{
   
        CGPoint circleDistance;
        circleDistance.x = ABS(pos.x - rect.origin.x);
        circleDistance.y = ABS(pos.y - rect.origin.y);
        
        if(circleDistance.x > (rect.size.width/2 + radius)) { return NO;}
        if(circleDistance.y > (rect.size.height/2 + radius)) { return NO;}
        
        if(circleDistance.x <= (rect.size.width/2)) { return YES;}
        if(circleDistance.y <= (rect.size.height/2)) { return YES;}
        
        float cornerDist = powf((circleDistance.x - rect.size.width/2), 2) + powf((circleDistance.y - rect.size.height/2), 2);
        
        return (cornerDist <= (radius * radius));
        
}



@end
