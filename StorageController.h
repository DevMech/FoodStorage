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

+ (StorageController *)sharedInstance;

- (NSArray *)essentialNames;

- (NSArray *)entriesForEssential:(Essential)essential;

- (void)createFoodEntryWithTitle:(NSString *)title amount:(NSNumber *)amount type:(NSString *)type expiration:(NSDate *)expiration barcode:(NSString *)barcode essential:(Essential)essential;

- (void)removeFoodEntry:(FoodEntry *)foodEntry forEssential:(Essential)essential;

- (double)weightOrVolumeForEssential:(Essential)essential;

@end
