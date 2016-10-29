//
//  MRPopOver.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 26/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRPopOver.h"

#define triangleViewSize 10

@implementation MRPopOver

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setClipsToBounds:YES];
    
}

-(instancetype)init{
    
    self = [super init];
    
    if(self){
    
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        
        self.showShadow = YES;
    }
    
    return self;
}


-(void)handleTap:(UITapGestureRecognizer *)tapGesture{
    
    [self removeFromSuperview];
    
}


-(void)createViewController:(UIViewController *)viewController fromView:(UIView *)fromView{
    
    [viewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self setFrame:[UIScreen mainScreen].bounds];
    
    CGRect senderViewInOwnView = [self convertRect:fromView.frame toView:self];
    
    BOOL showOnTopPartOfScreen;
    
    if(senderViewInOwnView.origin.y < self.frame.size.height/2){
        
        showOnTopPartOfScreen = YES;
        
    }else{
        
        showOnTopPartOfScreen = NO;
    }
    
    UIView *triangleView = [self createTriangleViewNearSenderViewFrame:senderViewInOwnView andShowOnTop:showOnTopPartOfScreen];
    
    UIView *mainViewControllerView = [self createMainViewControllerViewCorrespondingToTriangleView:triangleView andShowOnTop:showOnTopPartOfScreen];
    
    [mainViewControllerView addSubview:viewController.view];
    
    [mainViewControllerView.layer setBorderWidth:self.borderWidth];
    [mainViewControllerView.layer setBorderColor:self.colorOfBorder.CGColor];
    [mainViewControllerView.layer setCornerRadius:self.cornerRadiusForPopOver];
    [viewController.view.layer setCornerRadius:self.cornerRadiusForPopOver];
    [mainViewControllerView setClipsToBounds:YES];
    
    NSDictionary *viewsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:viewController.view,@"view", nil];
    
    [mainViewControllerView addConstraints:[self createConstraintsWithDictionary:viewsDictionary]];

    if(self.showShadow){
        [self createShadowOnView:mainViewControllerView];
    }
    
    [self addSubview:triangleView];
    [self addSubview:mainViewControllerView];
    
}


#pragma mark - Private functions

#pragma mark Create Views

-(UIView *)createTriangleViewNearSenderViewFrame:(CGRect)senderViewInOwnView andShowOnTop:(BOOL)showOnTop{
    
    CGFloat yCoordinate;
    
    CGPoint firstPoint, secondPoint, thirdPoint;
    
    if(showOnTop){
        
        yCoordinate = senderViewInOwnView.origin.y + senderViewInOwnView.size.height;
        
        firstPoint = CGPointMake(triangleViewSize/2, 0);
        secondPoint = CGPointMake(0, triangleViewSize);
        thirdPoint = CGPointMake(triangleViewSize, triangleViewSize);
        
    }else{
        
        yCoordinate = senderViewInOwnView.origin.y;
        
        firstPoint = CGPointMake(triangleViewSize/2, triangleViewSize);
        secondPoint = CGPointMake(0, 0);
        thirdPoint = CGPointMake(triangleViewSize, 0);
    }
    
 
    CGPoint senderViewPlaceToStartTriangleFrom = CGPointMake(senderViewInOwnView.origin.x + senderViewInOwnView.size.width / 2, yCoordinate);
    
    UIView *triangleView = [[UIView alloc] initWithFrame:CGRectMake(senderViewPlaceToStartTriangleFrom.x - triangleViewSize/2, senderViewPlaceToStartTriangleFrom.y, triangleViewSize, triangleViewSize)];
    
    [triangleView setBackgroundColor:self.trianglePopUpColor];
    
    UIBezierPath *trianglePath = [UIBezierPath new];
    [trianglePath moveToPoint:firstPoint];
    [trianglePath addLineToPoint:secondPoint];
    [trianglePath addLineToPoint:thirdPoint];
    [trianglePath addLineToPoint:firstPoint];
    
    [trianglePath closePath];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    [shapeLayer setPath:trianglePath.CGPath];
    
    triangleView.layer.mask = shapeLayer;
    
    return triangleView;
}

-(UIView *)createMainViewControllerViewCorrespondingToTriangleView:(UIView *)triangleView andShowOnTop:(BOOL)showOnTop{
    
    UIView *actualPopOverView;
    
    if(showOnTop){
        
        actualPopOverView = [[UIView alloc] initWithFrame:CGRectMake(self.leftSideInset, triangleView.frame.origin.y + triangleView.frame.size.height, [UIScreen mainScreen].bounds.size.width - self.rightSideInset - self.leftSideInset, [UIScreen mainScreen].bounds.size.height - self.bottomSideInset - (triangleView.frame.origin.y + triangleView.frame.size.height))];
        
    }else{
        
        actualPopOverView = [[UIView alloc] initWithFrame:CGRectMake(self.leftSideInset, self.topSideInset, [UIScreen mainScreen].bounds.size.width - self.rightSideInset - self.leftSideInset, triangleView.frame.origin.y - self.topSideInset)];
    }
    
    return actualPopOverView;
}

#pragma mark Other functions

-(void)createShadowOnView:(UIView *)view{
    
    UIBezierPath *shadowPath;
    
    if(!shadowPath){
        
        shadowPath = [UIBezierPath bezierPathWithRect:view.bounds];
    }
    
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(-3.0f, 3.0f);
    view.layer.shadowOpacity = 0.5f;
    view.layer.shadowPath = shadowPath.CGPath;
    
}

-(NSArray *)createConstraintsWithDictionary:(NSDictionary *)viewsDictionary{
    
    NSMutableArray *customConstraints = [[NSMutableArray alloc] init];
    
    [customConstraints addObjectsFromArray:
    [NSLayoutConstraint constraintsWithVisualFormat:
    [NSString stringWithFormat:@"H:|-%f-[view]-%f-|",self.borderWidth, self.borderWidth] options:0 metrics:nil views:viewsDictionary]];
    
    [customConstraints addObjectsFromArray:
    [NSLayoutConstraint constraintsWithVisualFormat:
    [NSString stringWithFormat:@"V:|-%f-[view]-%f-|",self.borderWidth,self.borderWidth] options:0 metrics:nil views:viewsDictionary]];
    
    return customConstraints;
}

@end
