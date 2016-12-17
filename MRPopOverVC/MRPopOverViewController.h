//
//  MRPopOverViewController.h
//  MRPopOverVC
//
//  Created by Mayank Rikh on 30/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MRPopOverViewControllerDelegate <NSObject>

@optional

-(void)userDidDismissViewController;

@end

@interface MRPopOverViewController : UIViewController

@property (strong, nonatomic) UIColor *trianglePopUpColor;

@property (strong, nonatomic) UIColor *colorOfBorder;

@property (assign, nonatomic) BOOL showShadow;

@property (assign, nonatomic) CGFloat borderWidth;

@property (assign, nonatomic) CGFloat cornerRadiusForPopOver;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;

@property (weak, nonatomic) id<MRPopOverViewControllerDelegate> delegate;

-(instancetype)initFromView:(UIView *)fromView withViewController:(UIViewController *)viewToShow;

@end
