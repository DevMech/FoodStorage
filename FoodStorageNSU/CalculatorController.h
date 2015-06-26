//
//  CalculatorController.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EssentialStorageController.h"

@interface CalculatorController : NSObject

@property (nonatomic, assign) EssentialIndex singleEssentialIndex;

+(instancetype)sharedInstance;

- (void)amountByFamily:(NSString *)adults andKids:(NSString *)kids andNumberOfWeeks:(NSString *)weeks;

@end
