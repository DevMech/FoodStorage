//
//  StorageController.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodEntry.h"

@interface StorageController : NSObject

@property (strong, nonatomic, readonly) NSArray *foodEntries;

+ (StorageController *)sharedInstance;

- (FoodEntry *)createFoodEntryWithTitle:(NSString *)title amount:(NSNumber *)amount type:(NSString *)type weight:(NSNumber *)weight expiration:(NSString *)expiration barcode:(NSString *)barcode;

- (void)addFoodEntry:(FoodEntry *)foodEntry;
- (void)removeFoodEntry:(FoodEntry *)foodEntry;

- (void)save;

@end
