//
//  CalculatorController.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorController : NSObject

+(instancetype)sharedInstance;

- (void)amountByFamily:(NSString *)adults andKids:(NSString *)kids andNumberOfWeeks:(NSString *)weeks;

@end
