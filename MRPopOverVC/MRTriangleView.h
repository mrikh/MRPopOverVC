//
//  TriangleView.h
//  MRPopOverVC
//
//  Created by Mayank Rikh on 30/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRTriangleView : UIView

-(instancetype)initTriangleViewNearPoint:(CGPoint)point andShowOnTop:(BOOL)showOnTop withColor:(UIColor *)color withWidth:(CGFloat) width;

@end
