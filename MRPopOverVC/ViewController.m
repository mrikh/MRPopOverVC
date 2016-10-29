//
//  ViewController.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 26/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "ViewController.h"
#import "MRPopOver.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    UITableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"table"];
    
    MRPopOver *view = [[MRPopOver alloc] init];
    
    view.trianglePopUpColor = [UIColor blackColor];
    
    view.colorOfBorder = [UIColor blackColor];
    
    view.borderWidth = 5.0f;
    
    view.showShadow = YES;
    
    view.cornerRadiusForPopOver = 5.0f;
    
    view.leftSideInset = 5.0f;
    
    view.bottomSideInset = 5.0f;
    
    view.topSideInset = 5.0f;
    
    view.rightSideInset = 5.0f;
    
    [view createViewController:viewController fromView:sender];
    
    [self addChildViewController:viewController];
    
    [viewController didMoveToParentViewController:self];
    
    [self.view addSubview:view];
}

@end
