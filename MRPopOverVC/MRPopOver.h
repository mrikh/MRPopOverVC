//
//  MRPopOver.h
//  MRPopOverVC
//
//  Created by Mayank Rikh on 26/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRPopOver : UIView

@property (strong, nonatomic) UIColor *trianglePopUpColor;

@property (strong, nonatomic) UIColor *colorOfBorder;

@property (assign, nonatomic) BOOL showShadow;

@property (assign, nonatomic) CGFloat borderWidth;

@property (assign, nonatomic) CGFloat cornerRadiusForPopOver;

@property (assign, nonatomic) CGFloat leftSideInset;

@property (assign, nonatomic) CGFloat rightSideInset;

@property (assign, nonatomic) CGFloat topSideInset;

@property (assign, nonatomic) CGFloat bottomSideInset;

-(void)createViewController:(UIViewController *)viewController fromView:(UIView *)fromView;

@end
