//
//  EssentialStorageController.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/23/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StorageController.h"


@interface CalculatorResultsStorageHelper : NSObject

+ (FoodEntry *)essentialEntry:(Essential)essential;
+ (void)updateFoodEntry:(FoodEntry *)entry forEssential:(Essential)essential;

+ (double)requiredAmountForEssential:(Essential)essential;

@end
