//
//  StorageController.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodEntry.h"

typedef NS_ENUM(NSInteger, Essential) {
    EssentialGrains,
    EssentialDryBeans,
    EssentialFatsAndOils,
    EssentialPowderedMilk,
    EssentialSalt,
    EssentialWater,
    EssentialAll
};


@interface StorageController : NSObject

@property (strong, nonatomic, readonly) NSArray *foodEntries;

+ (StorageController *)sharedInstance;

- (void)createFoodEntryWithTitle:(NSString *)title amount:(NSNumber *)amount type:(NSString *)type expiration:(NSDate *)expiration barcode:(NSString *)barcode;

- (NSArray *)essentialNames;

- (NSArray *)entriesForEssential:(Essential)essential;
- (void)addFoodEntry:(FoodEntry *)entry forEssential:(Essential)essential;

- (void)addFoodEntry:(FoodEntry *)foodEntry;
- (void)removeFoodEntry:(FoodEntry *)foodEntry;

- (void)save;

@end
