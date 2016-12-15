//
//  MRPopOverViewController.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 30/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRPopOverViewController.h"
#import "MRTriangleView.h"

@interface MRPopOverViewController ()<UIGestureRecognizerDelegate>{
    
    UIView *triangleView, *mainView;
    
    UIBezierPath *shadowPath;
}

@end

@implementation MRPopOverViewController

-(instancetype)init{
    
    if(self = [super init]){
        
        self.trianglePopUpColor = [UIColor blackColor];
        
        self.colorOfBorder = [UIColor blackColor];
        
        self.showShadow = YES;
        
        self.borderWidth = 5.0f;
        
        self.cornerRadiusForPopOver = 5.0f;
        
        self.edgeInsets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
        
        [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    tapGesture.delegate = self;
    
    [self.view addGestureRecognizer:tapGesture];
    
    [self addChildViewController:self.viewControllerToShow];
    
    [self.viewControllerToShow didMoveToParentViewController:self];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if([self isMovingToParentViewController] || [self isBeingPresented]){
        
        [self createViewControllerFromView:self.senderView];
    }
}


-(void)createViewControllerFromView:(UIView *)fromView{
    
    [self.viewControllerToShow.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGRect senderViewInOwnView = [fromView.superview convertRect:fromView.frame toView:self.view];
    
    BOOL showOnTopPartOfScreen = senderViewInOwnView.origin.y < self.view.frame.size.height/2;
    
    //initially create and setup views
    
    triangleView = [[MRTriangleView alloc] initTriangleViewNearFrame:senderViewInOwnView andShowOnTop:showOnTopPartOfScreen withColor:self.trianglePopUpColor];
    
    [self createMainViewControllerViewOnSide:showOnTopPartOfScreen];
    
    if(self.showShadow){
        
        [self createShadow];
    }
    
    [self.view addSubview:triangleView];
    
    [self.view addSubview:mainView];
}


#pragma mark - Private functions

#pragma mark Create Views

-(void)createMainViewControllerViewOnSide:(BOOL)showOnTop{
    
    if(showOnTop){
        
        mainView = [[UIView alloc] initWithFrame:CGRectMake(self.edgeInsets.left, triangleView.frame.origin.y + triangleView.frame.size.height, [UIScreen mainScreen].bounds.size.width - self.edgeInsets.right - self.edgeInsets.left, [UIScreen mainScreen].bounds.size.height - self.edgeInsets.bottom - (triangleView.frame.origin.y + triangleView.frame.size.height))];
        
    }else{
        
        mainView = [[UIView alloc] initWithFrame:CGRectMake(self.edgeInsets.left, self.edgeInsets.top, [UIScreen mainScreen].bounds.size.width - self.edgeInsets.right - self.edgeInsets.left, triangleView.frame.origin.y - self.edgeInsets.top)];
    }
    
    [mainView.layer setBorderWidth:self.borderWidth];
    
    [mainView.layer setBorderColor:self.colorOfBorder.CGColor];
    
    [mainView.layer setCornerRadius:self.cornerRadiusForPopOver];
    
    [mainView setClipsToBounds:YES];
    
    [mainView addSubview:self.viewControllerToShow.view];
    
    [mainView addConstraints:[self createConstraints]];
    
}

#pragma mark Other functions

-(void)createShadow{
    
    if(!shadowPath){
        
        shadowPath = [UIBezierPath bezierPathWithRect:mainView.bounds];
    }
    
    mainView.layer.masksToBounds = NO;
    
    mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    mainView.layer.shadowOffset = CGSizeMake(-3.0f, 3.0f);
    
    mainView.layer.shadowOpacity = 0.5f;
    
    mainView.layer.shadowPath = shadowPath.CGPath;
    
}

-(NSArray *)createConstraints{
    
    NSDictionary *viewsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.viewControllerToShow.view,@"view", nil];
    
    NSMutableArray *customConstraints = [[NSMutableArray alloc] init];
    
    [customConstraints addObjectsFromArray:
    [NSLayoutConstraint constraintsWithVisualFormat:
    [NSString stringWithFormat:@"H:|-%f-[view]-%f-|",self.borderWidth, self.borderWidth] options:0 metrics:nil views:viewsDictionary]];
    
    [customConstraints addObjectsFromArray:
    [NSLayoutConstraint constraintsWithVisualFormat:
    [NSString stringWithFormat:@"V:|-%f-[view]-%f-|",self.borderWidth,self.borderWidth] options:0 metrics:nil views:viewsDictionary]];
    
    return customConstraints;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if(touch.view == self.view){
        
        return YES;
    }
    
    return NO;
}

-(void)handleTap:(UITapGestureRecognizer *)tapGesture{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if([self.delegate respondsToSelector:@selector(userDidDismissViewController)]){
            
            [self.delegate userDidDismissViewController];
        }
    }];
}


#pragma mark - Setters

-(void)setTrianglePopUpColor:(UIColor *)trianglePopUpColor{
    
    _trianglePopUpColor = trianglePopUpColor;
    
    [triangleView setBackgroundColor:_trianglePopUpColor];
}

-(void)setColorOfBorder:(UIColor *)colorOfBorder{
    
    _colorOfBorder = colorOfBorder;
    
    [mainView.layer setBorderColor:_colorOfBorder.CGColor];
}

-(void)setShowShadow:(BOOL)showShadow{
    
    _showShadow = showShadow;
    
    [self createShadow];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    
    _borderWidth = borderWidth;
    
    [mainView.layer setBorderWidth:_borderWidth];
}

@end
