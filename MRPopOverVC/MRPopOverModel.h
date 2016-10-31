//
//  MRPopOverModel.h
//  MRPopOverVC
//
//  Created by Mayank Rikh on 31/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MRPopOverModel : NSObject

@property (strong, nonatomic) NSNumber *xCoordinate;

@property (strong, nonatomic) NSNumber *yCoordinate;

@property (strong, nonatomic) NSString *text;

@property (strong, nonatomic) UIView *viewToMakeIn;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
