//
//  AppearanceController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 7/3/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "AppearanceController.h"
@import UIKit;

@implementation AppearanceController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[UINavigationBar appearance]setTintColor:[UIColor colorWithRed:0.12 green:0.64 blue:0.29 alpha:1]];
    }
    return self;
}

@end
