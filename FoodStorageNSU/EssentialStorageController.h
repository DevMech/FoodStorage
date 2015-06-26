//
//  EssentialStorageController.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/23/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EssentialFoodEntry.h"

typedef NS_ENUM(NSInteger, EssentialIndex) {
    EssentialIndexGrains,
    EssentialIndexDryBeans,
    EssentialIndexFatsAndOils,
    EssentialIndexPowderedMilk,
    EssentialIndexSalt,
    EssentialIndexWater
};

@interface EssentialStorageController : NSObject

@property (strong, nonatomic, readonly) NSArray *essentialEntries; 

+ (EssentialStorageController *)sharedInstance;

- (NSArray *)essentialNames;

- (void)addEssentialEntry:(EssentialFoodEntry *)essentialEntry;
- (void)removeEssentialEntry:(EssentialFoodEntry *)essentialEntry;

- (void)save;

@end
