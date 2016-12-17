//
//  TriangleView.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 30/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRTriangleView.h"

#define triangleViewSize 10

@implementation MRTriangleView


-(instancetype)initTriangleViewNearPoint:(CGPoint)point andShowOnTop:(BOOL)showOnTop withColor:(UIColor *)color{
    
    self = [super init];
    
    if(self){
        
        [self createTriangleViewNearPoint:point andShowOnTop:showOnTop withColor:color];
    }
    
    return self;
}


-(void)createTriangleViewNearPoint:(CGPoint)point andShowOnTop:(BOOL)showOnTop withColor:(UIColor *)color{

    CGPoint firstPoint, secondPoint, thirdPoint;
    
    if(showOnTop){
        
        firstPoint = CGPointMake(triangleViewSize/2, 0);
        secondPoint = CGPointMake(0, triangleViewSize);
        thirdPoint = CGPointMake(triangleViewSize, triangleViewSize);
        
    }else{
        
        firstPoint = CGPointMake(triangleViewSize/2, triangleViewSize);
        secondPoint = CGPointMake(0, 0);
        thirdPoint = CGPointMake(triangleViewSize, 0);
    }
    
    [self setFrame: CGRectMake(point.x - triangleViewSize/2, point.y, triangleViewSize, triangleViewSize)];
    
    [self setBackgroundColor:color];
    
    UIBezierPath *trianglePath = [UIBezierPath new];
    [trianglePath moveToPoint:firstPoint];
    [trianglePath addLineToPoint:secondPoint];
    [trianglePath addLineToPoint:thirdPoint];
    [trianglePath addLineToPoint:firstPoint];
    
    [trianglePath closePath];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    [shapeLayer setPath:trianglePath.CGPath];
    
    self.layer.mask = shapeLayer;
}

@end
