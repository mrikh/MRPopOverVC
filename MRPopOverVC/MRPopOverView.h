//
//  MRPopOverView.h
//  MRPopOverVC
//
//  Created by Mayank Rikh on 30/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MRPopOverViewDelegate <NSObject>

@optional

-(void)userDidDismissView;

@end

@interface MRPopOverView : UIView

@property (assign, nonatomic) CGFloat labelBorderWidth;

@property (assign, nonatomic) CGFloat triangleWidth;

@property (strong, nonatomic) UIColor *labelBackgroundColor;

@property (strong, nonatomic) UIColor *labelTextColor;

@property (strong, nonatomic) UIColor *textBorderColor;

@property (weak, nonatomic) id<MRPopOverViewDelegate> delegate;

-(void)createInfoBelowView:(UIView *)view withString:(NSString *)text andFont:(UIFont *)font;

-(void)createInfoWithPointsAndTextDictionaryArray:(NSArray *)array andFont:(UIFont *)font;

@end
