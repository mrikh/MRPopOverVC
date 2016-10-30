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

-(instancetype)initTriangleViewNearFrame:(CGRect)senderView andShowOnTop:(BOOL)showOnTop withColor:(UIColor *)color{
    
    self = [super init];
    
    if(self){
        
        CGFloat yCoordinate;
        
        CGPoint firstPoint, secondPoint, thirdPoint;
        
        if(showOnTop){
            
            yCoordinate = senderView.origin.y + senderView.size.height;
            
            firstPoint = CGPointMake(triangleViewSize/2, 0);
            secondPoint = CGPointMake(0, triangleViewSize);
            thirdPoint = CGPointMake(triangleViewSize, triangleViewSize);
            
        }else{
            
            yCoordinate = senderView.origin.y;
            
            firstPoint = CGPointMake(triangleViewSize/2, triangleViewSize);
            secondPoint = CGPointMake(0, 0);
            thirdPoint = CGPointMake(triangleViewSize, 0);
        }
        
        CGPoint senderViewPlaceToStartTriangleFrom = CGPointMake(senderView.origin.x + senderView.size.width / 2, yCoordinate);
        
        [self setFrame: CGRectMake(senderViewPlaceToStartTriangleFrom.x - triangleViewSize/2, senderViewPlaceToStartTriangleFrom.y, triangleViewSize, triangleViewSize)];
        
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
    
    return self;
}

@end
