//
//  MRPopOver.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 26/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRPopOver.h"

@implementation MRPopOver

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setClipsToBounds:YES];
    
    [self.layer setCornerRadius:5.0f];
    
}

-(instancetype)initWithViewController:(UIViewController *)viewController fromView:(UIView *)view{
    
    self = [super init];
    
    if(self){
    
        [self createView:viewController.view fromView:view];
        
        [self setBackgroundColor:self.backgroundColor];
        
        [self.layer setBorderColor:self.borderColor.CGColor];
        
        [self.layer setBorderWidth:self.borderWidth];
    
    }
    
    return self;

}

-(void)createView:(UIView *)viewControllerView fromView:(UIView *)fromView{
    
    CGSize deviceSize = [UIScreen mainScreen].bounds.size;
    
    CGRect senderViewInOwnView = [self convertRect:fromView.frame toView:self];
    
    //check if top part or bottom part
    if(fromView.frame.origin.x < deviceSize.height/2){
        
        
    }else{
        
        
    }
    
}

@end
