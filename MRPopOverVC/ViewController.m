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
    
    MRPopOverViewController *viewControllerNew = [[MRPopOverViewController alloc] initFromView:sender withViewController:viewController];
        
    [self presentViewController:viewControllerNew animated:YES completion:nil];
    
    
    
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
