//
//  PolygonView.m
//  HelloPoly
//
//  Created by Kamil Smuga on 09/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import "PolygonView.h"
#import <Foundation/Foundation.h>

@interface PolygonView ()
@property (strong, nonatomic) NSArray *points;

@end

@implementation PolygonView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)redraw
{
    [self setNeedsDisplay];
}


- (NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides
{
    CGPoint center = CGPointMake(rect.size.width/ 2.0, rect.size.height / 2.0);
    float radius = 0.9 * center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / numberOfSides;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5 * exteriorAngle);
    for (int currentAngle = 0; currentAngle < numberOfSides; currentAngle++) {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:CGPointMake(center.x+curX,center.y+curY)]];
    }
     return result;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    
    self.points = [self pointsForPolygonInRect:rect numberOfSides:self.numberOfSides];
    for(int i = 0; i < self.points.count; i++)
    {
        NSValue *val1 = self.points[i];
        CGPoint p1 = [val1 CGPointValue];
        NSValue *val2;
        CGPoint p2;
        if (i == self.points.count-1)
        {
            val2 = self.points[0];
        }
        else
        {
            val2 = self.points[i+1];
        }
        p2 = [val2 CGPointValue];
        
        [self drawFromPoint:p1 ToPoint:p2 UsingContext:context];
    }
}

- (void)drawFromPoint:(CGPoint)first ToPoint:(CGPoint)second UsingContext:(CGContextRef)context
{
    CGContextMoveToPoint(context, first.x, first.y); //start at this point
    CGContextAddLineToPoint(context, second.x, second.y); //draw to this point
    CGContextStrokePath(context);
}


@end
