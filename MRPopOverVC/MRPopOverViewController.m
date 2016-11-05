//
//  MRPopOverViewController.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 30/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRPopOverViewController.h"
#import "MRTriangleView.h"

@interface MRPopOverViewController ()<UIGestureRecognizerDelegate>

@end

@implementation MRPopOverViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    tapGesture.delegate = self;
    
    [self.view addGestureRecognizer:tapGesture];
    
    [self addChildViewController:self.viewControllerToShow];
    
    [self.viewControllerToShow didMoveToParentViewController:self];
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
    
    BOOL showOnTopPartOfScreen;
    
    if(senderViewInOwnView.origin.y < self.view.frame.size.height/2){
        
        showOnTopPartOfScreen = YES;
        
    }else{
        
        showOnTopPartOfScreen = NO;
    }
    
    //initially create and setup views
    
    UIView *triangleView = [[MRTriangleView alloc] initTriangleViewNearFrame:senderViewInOwnView andShowOnTop:showOnTopPartOfScreen withColor:self.trianglePopUpColor];
    
    UIView *mainViewControllerView = [self createMainViewControllerViewCorrespondingToTriangleView:triangleView andShowOnTop:showOnTopPartOfScreen];
    
    [mainViewControllerView.layer setBorderWidth:self.borderWidth];
    [mainViewControllerView.layer setBorderColor:self.colorOfBorder.CGColor];
    [mainViewControllerView.layer setCornerRadius:self.cornerRadiusForPopOver];
    [self.viewControllerToShow.view.layer setCornerRadius:self.cornerRadiusForPopOver];
    [mainViewControllerView setClipsToBounds:YES];
    
    [mainViewControllerView addSubview:self.viewControllerToShow.view];
    
    NSDictionary *viewsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:self.viewControllerToShow.view,@"view", nil];
    
    [mainViewControllerView addConstraints:[self createConstraintsWithDictionary:viewsDictionary]];
    
    if(self.showShadow){
        [self createShadowOnView:mainViewControllerView];
    }
    
    [self.view addSubview:triangleView];
    [self.view addSubview:mainViewControllerView];
}


#pragma mark - Private functions

#pragma mark Create Views

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

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if(touch.view == self.view){
        
        return YES;
    }
    
    return NO;
}

-(void)handleTap:(UITapGestureRecognizer *)tapGesture{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
