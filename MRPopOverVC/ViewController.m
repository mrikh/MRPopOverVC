//
//  ViewController.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 26/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRPopOverViewController.h"
#import "ViewController.h"
#import "MRPopOverView.h"

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
    
    MRPopOverViewController *viewControllerNew = [[MRPopOverViewController alloc] init];
    
    viewControllerNew.senderView = sender;
    
    viewControllerNew.viewControllerToShow = viewController;
    
    viewControllerNew.trianglePopUpColor = [UIColor greenColor];
    
    viewControllerNew.colorOfBorder = [UIColor greenColor];

    viewControllerNew.showShadow = YES;
    
    viewControllerNew.borderWidth = 5.0f;
    
    viewControllerNew.cornerRadiusForPopOver = 5.0f;
    
    viewControllerNew.leftSideInset = 5.0f;
    
    viewControllerNew.bottomSideInset = 5.0f;
    
    viewControllerNew.topSideInset = 5.0f;
    
    viewControllerNew.rightSideInset = 5.0f;
    
    [viewControllerNew setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [self presentViewController:viewControllerNew animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        viewControllerNew.trianglePopUpColor = [UIColor blueColor];
    });
    
     /*
    
    
    MRPopOverView *labelView = [[MRPopOverView alloc] init];
    
    labelView.labelBorderWidth = 1.0f;
    
    labelView.labelTextColor = [UIColor whiteColor];
    
    labelView.textBorderColor = [UIColor blackColor];
    
    labelView.labelBackgroundColor = [UIColor blueColor];
    
    [labelView createInfoBelowView:sender withString:@"Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?Heyyyyyy! How ya doin?" andFont:nil];
   
    
//    [labelView createInfoWithPointsAndTextDictionaryArray:@[[[NSDictionary alloc] initWithObjectsAndKeys:@"How ya doin?Heyyyyyy!",@"text",@(sender.center.x),@"xCoordinate", @(sender.center.y), @"yCoordinate",sender.superview,@"viewToBeMadeIn",nil]] andFont:nil];
    
    [self.view addSubview:labelView];
    */
}

@end
