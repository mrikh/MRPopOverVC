//
//  MRPopOver.h
//  MRPopOverVC
//
//  Created by Mayank Rikh on 26/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRPopOver : UIView

@property (strong, nonatomic) UIColor *borderColor;

@property (strong, nonatomic) UIColor *backgroundColor;

@property (assign, nonatomic) CGFloat borderWidth;

-(instancetype)initWithViewController:(UIViewController *)viewController fromView:(UIView *)view;

@end
