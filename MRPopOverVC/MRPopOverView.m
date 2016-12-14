//
//  MRPopOverView.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 30/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRTriangleView.h"
#import "MRPopOverModel.h"
#import "MRPopOverView.h"

@implementation MRPopOverView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    }
    
    return self;
}

-(void)createInfoBelowView:(UIView *)view withString:(NSString *)text andFont:(UIFont *)font{
    
    [self setFrame:[UIScreen mainScreen].bounds];
    
    BOOL showOnTopPartOfScreen;
    
    CGRect senderViewInOwnView = [view.superview convertRect:view.frame toView:self];
    
    if(senderViewInOwnView.origin.y < self.frame.size.height/2){
        
        showOnTopPartOfScreen = YES;
        
    }else{
        
        showOnTopPartOfScreen = NO;
    }
    
    UIView *triangleView = [[MRTriangleView alloc] initTriangleViewNearFrame:senderViewInOwnView andShowOnTop:showOnTopPartOfScreen withColor:self.textBorderColor];
    
    UILabel *textLabel = [self createLabelWithString:text nearView:triangleView andShowOnTop:showOnTopPartOfScreen andFont:font];
    
    [self modifyLabelFrameAsRequiredOfLabel:textLabel];
    
    [self addSubview:triangleView];
    [self addSubview:textLabel];
}


-(void)createInfoWithPointsAndTextDictionaryArray:(NSArray *)array andFont:(UIFont *)font{
    
    [self setFrame:[UIScreen mainScreen].bounds];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MRPopOverModel *model;
        
        if([obj isKindOfClass:[NSDictionary class]]){
         
            model = [[MRPopOverModel alloc] initWithDictionary:obj];
        
        }else{
        
            [[[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Please use array of dictionaries developer sir" delegate:nil cancelButtonTitle:@"Okay D:" otherButtonTitles:nil] show];
            
            return ;
        }
        
        BOOL showOnTopPartOfScreen;
        
        CGPoint coordinatesInOwnView = [model.viewToMakeIn convertPoint:CGPointMake([model.xCoordinate floatValue], [model.yCoordinate floatValue]) toView:self];
        
        if(coordinatesInOwnView.y < self.frame.size.height/2){
            
            showOnTopPartOfScreen = YES;
            
        }else{
            
            showOnTopPartOfScreen = NO;
        }
        
        
        UIView *triangleView = [[MRTriangleView alloc] initTriangleViewNearPoint:CGPointMake(coordinatesInOwnView.x, coordinatesInOwnView.y) andShowOnTop:showOnTopPartOfScreen withColor:self.textBorderColor];
        
        UILabel *textLabel = [self createLabelWithString:model.text nearView:triangleView andShowOnTop:showOnTopPartOfScreen andFont:font];
        
        [self modifyLabelFrameAsRequiredOfLabel:textLabel];
        
        [self addSubview:triangleView];
        [self addSubview:textLabel];
        
    }];
    
}


#pragma mark - Private Functions

#define buffer 8.0f

-(UILabel *)createLabelWithString:(NSString *)text nearView:(UIView *)triangleView andShowOnTop:(BOOL)showOnTop andFont:(UIFont *)font{
    
    UIFont *fontToUse;
    
    if(!font){
        
        fontToUse = [UIFont fontWithName:@"Arial" size:14.0f];
        
    }else{
        
        fontToUse = font;
    }
    
    CGSize stringSize = [text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width, FLT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:fontToUse} context:nil].size;
    
    CGFloat yCoordinate;
    
    if(showOnTop){
        
        yCoordinate = triangleView.frame.origin.y + triangleView.frame.size.height;
    }else{
        
        yCoordinate = triangleView.frame.origin.y - stringSize.height;
        
    }
        
    UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(triangleView.frame.origin.x - triangleView.frame.size.width/2 - buffer, yCoordinate, stringSize.width, stringSize.height)];
    
    [mainLabel setBackgroundColor:self.labelBackgroundColor];
    [mainLabel setTextAlignment:NSTextAlignmentCenter];
    [mainLabel setFont:fontToUse];
    [mainLabel setTextColor:self.labelTextColor];
    [mainLabel.layer setBorderColor: self.textBorderColor.CGColor];
    [mainLabel.layer setBorderWidth:self.labelBorderWidth];
    [mainLabel.layer setCornerRadius:5.0f];
    [mainLabel setNumberOfLines:0];
    [mainLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [mainLabel setClipsToBounds:YES];
    [mainLabel setText:text];
    
    return mainLabel;
    
}


-(void)modifyLabelFrameAsRequiredOfLabel:(UILabel *)label{
    
    CGRect labelFrame = label.frame;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    if(CGRectGetMaxX(labelFrame) > screenBounds.size.width){
        
        CGFloat minXForLabel = MAX(0,label.frame.origin.x - (CGRectGetMaxX(labelFrame)-screenBounds.size.width));
        
        [label setFrame:CGRectMake(minXForLabel, labelFrame.origin.y, labelFrame.size.width, labelFrame.size.height)];
    }
}

-(void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self removeFromSuperview];
}

@end
