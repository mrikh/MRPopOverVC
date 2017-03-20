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
        
        self.labelBorderWidth = 1.0f;
        
        self.labelBackgroundColor = [UIColor blueColor];
        
        self.labelTextColor = [UIColor whiteColor];
        
        self.textBorderColor = [UIColor blackColor];
        
        [self setFrame:[UIScreen mainScreen].bounds];
        
        self.triangleWidth = 10.0f;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    }
    
    return self;
}


-(void)createInfoBelowView:(UIView *)view withString:(NSString *)text andFont:(UIFont *)font{
 
    CGPoint point = CGPointMake(view.center.x, view.center.y);
    
    CGPoint coordinatesInOwnView = [view.superview convertPoint:point toView:self];
    
    BOOL up = [self topHalfOfScreenHasPoint:coordinatesInOwnView];
    
    if(up){
        
        coordinatesInOwnView  = CGPointMake(coordinatesInOwnView.x, coordinatesInOwnView.y + view.frame.size.height/2);
        
    }else{
        
        coordinatesInOwnView  = CGPointMake(coordinatesInOwnView.x, coordinatesInOwnView.y - view.frame.size.height/2);
    }
    
    [self createInfoNearPoint:coordinatesInOwnView insideView:view.superview withString:text andFont:font andShowOnTopPart:up];
}


-(void)createInfoWithPointsAndTextDictionaryArray:(NSArray *)array andFont:(UIFont *)font{

    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MRPopOverModel *model;
        
        if([obj isKindOfClass:[NSDictionary class]]){
         
            model = [[MRPopOverModel alloc] initWithDictionary:obj];
        
        }else{
        
            [[[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Please use array of dictionaries developer sir" delegate:nil cancelButtonTitle:@"Okay D:" otherButtonTitles:nil] show];
            
            *stop = YES;
        }

        CGPoint point = CGPointMake([model.xCoordinate doubleValue], [model.yCoordinate doubleValue]);
        
        CGPoint coordinatesInOwnView = [model.viewToMakeIn convertPoint:point toView:self];
       
        [self createInfoNearPoint:coordinatesInOwnView insideView:model.viewToMakeIn withString:model.text andFont:font andShowOnTopPart:[self topHalfOfScreenHasPoint:coordinatesInOwnView]];
    }];
}

-(void)createInfoNearPoint:(CGPoint)point insideView:(UIView *)view withString:(NSString *)text andFont:(UIFont *)font andShowOnTopPart:(BOOL)showOnTopPartOfScreen{
    
    UIView *triangleView = [[MRTriangleView alloc] initTriangleViewNearPoint:point andShowOnTop:showOnTopPartOfScreen withColor:self.textBorderColor withWidth:self.triangleWidth];
    
    UILabel *textLabel = [self createLabelWithString:text nearView:triangleView andShowOnTop:showOnTopPartOfScreen andFont:font];
    
    [self modifyLabelFrameAsRequiredOfLabel:textLabel];
    
    [self addSubview:triangleView];
    
    [self addSubview:textLabel];
}

#pragma mark - Private Functions

#define buffer 8.0f


-(BOOL)topHalfOfScreenHasPoint:(CGPoint)point{
    
    if(point.y < self.frame.size.height/2){
        
        return YES;
        
    }else{
        
        return NO;
        
    }
}

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
    
    if(CGRectGetMinX(labelFrame) < 0){

        [label setFrame:CGRectMake(0, labelFrame.origin.y, labelFrame.size.width, labelFrame.size.height)];
    }
}

-(void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self removeFromSuperview];
}

@end
