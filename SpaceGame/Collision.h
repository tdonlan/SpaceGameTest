//
//  Collision.h
//  Heartline
//
//  Created by Tim Donlan on 3/27/13.
//
//

#import <Foundation/Foundation.h>

@interface Collision : NSObject

+(BOOL)intersectPointCircle:(CGPoint) pos withCircleOrigin:(CGPoint)origin withRadius:(float)radius;
+(BOOL)intersectLineLine:(CGPoint)A :(CGPoint)B withLine :(CGPoint)C :(CGPoint)D;
+(BOOL)intersectCircleCircle:(CGPoint)CenterA withRadius:(float)radA withCircle:(CGPoint)CenterB withRadius:(float)radB;
+(BOOL)intersectCircleLine:(CGPoint)pos withRadius:(float)radius withLine:(CGPoint)A toPoint:(CGPoint)B;


+ (BOOL)intersectCircleLine2:(CGPoint)A :(CGPoint)B  withinRadius:(CGFloat)radius fromPoint:(CGPoint)point;

+(BOOL)intersectRectCircle:(CGRect)rect withPoint:(CGPoint)pos withRadius:(float)radius;

CGFloat distance(const CGPoint p1, const CGPoint p2);
CGFloat dotProduct(const CGPoint p1, const CGPoint p2);
CGFloat lerpf(float fStart, float fEnd, float fPercent);

@end
