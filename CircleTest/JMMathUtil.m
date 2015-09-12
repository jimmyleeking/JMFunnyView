//
//  JMMathUtil.m
//  MyDrawLineDemo
//
//  Created by 李剑明 on 8/26/15.
//  Copyright (c) 2015 handos. All rights reserved.
//

#import "JMMathUtil.h"

#define pi 3.14159265358979323846
#define degreesToRadian(x) (pi * x / 180.0)
#define radiansToDegrees(x) (180.0 * x / pi)

@implementation JMMathUtil


CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
}
CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(height/width);
    return radiansToDegrees(rads);
    //degs = degrees(atan((top - bottom)/(right - left)))
}

CGFloat angleBetweenLines(CGPoint line1Start, CGPoint line1End, CGPoint line2Start, CGPoint line2End) {
    
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    return radiansToDegrees(rads);
    
}
CGFloat angleBetweenThreePoints(CGPoint pointA, CGPoint pointB, CGPoint pointC)
{
    
    
    double ma_x = pointA.x - pointB.x;
    double ma_y = pointA.y - pointB.y;
    double mb_x = pointC.x- pointB.x;
    double mb_y = pointC.y - pointB.y;
    double v1 = (ma_x * mb_x) + (ma_y * mb_y);
    double ma_val = sqrt(ma_x * ma_x + ma_y * ma_y);
    double mb_val = sqrt(mb_x * mb_x + mb_y * mb_y);
    double cosM = v1 / (ma_val * mb_val);
    double angleAMB = acos(cosM) * 180 / M_PI;
    return angleAMB;
    //return angleBetweenLines(pointA, pointB, pointB, pointC);
}
@end
