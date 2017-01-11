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
    
    UIView *triangleView, *mainView, *senderView, *viewControllerToShowView;
}

@end

@implementation MRPopOverViewController

-(instancetype)initFromView:(UIView *)fromView withViewController:(UIViewController *)viewToShow{
    
    if(self = [super init]){
        
        self.trianglePopUpColor = [UIColor blackColor];
        
        self.colorOfBorder = [UIColor blackColor];
        
        self.showShadow = YES;
        
        self.borderWidth = 5.0f;
        
        self.cornerRadiusForPopOver = 5.0f;
        
        senderView = fromView;
        
        self.edgeInsets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
        
        viewControllerToShowView = viewToShow.view;
        
        [self addChildViewController:viewToShow];
        
        [viewControllerToShowView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [viewToShow didMoveToParentViewController:self];
        
        [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    tapGesture.delegate = self;
    
    [self.view addGestureRecognizer:tapGesture];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if([self isMovingToParentViewController] || [self isBeingPresented]){
        
        [self createViewControllerFromView:senderView];
    }
}


-(void)createViewControllerFromView:(UIView *)fromView{
    
    CGRect senderViewInOwnView = [fromView.superview convertRect:fromView.frame toView:self.view];
    
    BOOL showOnTopPartOfScreen = senderViewInOwnView.origin.y < self.view.frame.size.height/2;
    
    CGPoint point;
    
    if(showOnTopPartOfScreen){
        
        point = CGPointMake(senderViewInOwnView.origin.x + senderViewInOwnView.size.width/2, senderViewInOwnView.origin.y + fromView.bounds.size.height);
        
    }else{
        
        point = CGPointMake(senderViewInOwnView.origin.x + senderViewInOwnView.size.width/2, senderViewInOwnView.origin.y);
    }
    
    //initially create and setup views
    triangleView = [[MRTriangleView alloc] initTriangleViewNearPoint:point andShowOnTop:showOnTopPartOfScreen withColor:self.trianglePopUpColor];
    
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
    
    //show triangle in top half of the screen
    if(showOnTop){
        
        if(self.totalHeight){
            
            float height = [self.totalHeight floatValue];
            
             mainView = [[UIView alloc] initWithFrame:CGRectMake(self.edgeInsets.left, triangleView.frame.origin.y + triangleView.frame.size.height, [UIScreen mainScreen].bounds.size.width - self.edgeInsets.right - self.edgeInsets.left, MIN([UIScreen mainScreen].bounds.size.height - self.edgeInsets.bottom - (triangleView.frame.origin.y + triangleView.frame.size.height),height))];
            
        }else{
        
            mainView = [[UIView alloc] initWithFrame:CGRectMake(self.edgeInsets.left, triangleView.frame.origin.y + triangleView.frame.size.height, [UIScreen mainScreen].bounds.size.width - self.edgeInsets.right - self.edgeInsets.left, [UIScreen mainScreen].bounds.size.height - self.edgeInsets.bottom - (triangleView.frame.origin.y + triangleView.frame.size.height))];
        }
        
    }else{
        
        if(self.totalHeight){
         
            float height = [self.totalHeight floatValue];
            
            mainView = [[UIView alloc] initWithFrame:CGRectMake(self.edgeInsets.left, MAX(self.edgeInsets.top, triangleView.frame.origin.y - height), [UIScreen mainScreen].bounds.size.width - self.edgeInsets.right - self.edgeInsets.left, MIN(triangleView.frame.origin.y - self.edgeInsets.top, height))];
            
        }else{
        
            mainView = [[UIView alloc] initWithFrame:CGRectMake(self.edgeInsets.left, self.edgeInsets.top, [UIScreen mainScreen].bounds.size.width - self.edgeInsets.right - self.edgeInsets.left, triangleView.frame.origin.y - self.edgeInsets.top)];
        }
    }
    
    [mainView.layer setBorderWidth:self.borderWidth];
    
    [mainView.layer setBorderColor:self.colorOfBorder.CGColor];
    
    [mainView.layer setCornerRadius:self.cornerRadiusForPopOver];
    
    [mainView setClipsToBounds:YES];
    
    [mainView addSubview:viewControllerToShowView];
    
    [mainView addConstraints:[self createConstraints]];
    
}

#pragma mark Other functions

-(void)createShadow{
    
    UIBezierPath *shadowPath;
    
    if(shadowPath || !mainView){
        
        return;
    }
    
    shadowPath = [UIBezierPath bezierPathWithRect:mainView.bounds];
    
    mainView.layer.masksToBounds = NO;
    
    mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    mainView.layer.shadowOffset = CGSizeMake(-3.0f, 3.0f);
    
    mainView.layer.shadowOpacity = 0.5f;
    
    mainView.layer.shadowPath = shadowPath.CGPath;
    
}

-(NSArray *)createConstraints{
    
    NSDictionary *viewsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:viewControllerToShowView,@"view", nil];
    
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
