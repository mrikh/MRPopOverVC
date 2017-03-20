//
//  TriangleView.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 30/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRTriangleView.h"

@implementation MRTriangleView

-(instancetype)initTriangleViewNearPoint:(CGPoint)point andShowOnTop:(BOOL)showOnTop withColor:(UIColor *)color withWidth:(CGFloat)width{
    
    self = [super init];
    
    if(self){
        
        [self createTriangleViewNearPoint:point andShowOnTop:showOnTop withColor:color withWidth:width];
    }
    
    return self;
}


-(void)createTriangleViewNearPoint:(CGPoint)point andShowOnTop:(BOOL)showOnTop withColor:(UIColor *)color withWidth:(CGFloat)width{

    CGPoint firstPoint, secondPoint, thirdPoint;
    
    if(showOnTop){
        
        firstPoint = CGPointMake(width/2, 0);
        secondPoint = CGPointMake(0, width);
        thirdPoint = CGPointMake(width, width);
        
    }else{
        
        firstPoint = CGPointMake(width/2, width);
        secondPoint = CGPointMake(0, 0);
        thirdPoint = CGPointMake(width, 0);
    }
    
    [self setFrame: CGRectMake(point.x - width/2, point.y, width, width)];
    
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
