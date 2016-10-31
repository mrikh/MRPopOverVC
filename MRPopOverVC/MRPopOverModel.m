//
//  MRPopOverModel.m
//  MRPopOverVC
//
//  Created by Mayank Rikh on 31/10/16.
//  Copyright © 2016 Mayank Rikh. All rights reserved.
//

#import "MRPopOverModel.h"

@implementation MRPopOverModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    
    self = [super init];
    
    if(self){
        
        self.xCoordinate = dict[@"xCoordinate"];
        self.yCoordinate = dict[@"yCoordinate"];
        self.text = dict[@"text"];
        self.viewToMakeIn = dict[@"viewToBeMadeIn"];
    }
    
    return self;
}

@end
