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

@property (strong, nonatomic) UIViewController *viewControllerToShow;

@property (strong, nonatomic) UIView *senderView;

@property (strong, nonatomic) UIColor *trianglePopUpColor;

@property (strong, nonatomic) UIColor *colorOfBorder;

@property (assign, nonatomic) BOOL showShadow;

@property (assign, nonatomic) CGFloat borderWidth;

@property (assign, nonatomic) CGFloat cornerRadiusForPopOver;

@property (assign, nonatomic) CGFloat leftSideInset;

@property (assign, nonatomic) CGFloat rightSideInset;

@property (assign, nonatomic) CGFloat topSideInset;

@property (assign, nonatomic) CGFloat bottomSideInset;

@property (weak, nonatomic) id<MRPopOverViewControllerDelegate> delegate;

@end
