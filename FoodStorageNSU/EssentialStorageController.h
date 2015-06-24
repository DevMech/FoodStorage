//
//  EssentialStorageController.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/23/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EssentialFoodEntry.h"

@interface EssentialStorageController : NSObject

@property (strong, nonatomic, readonly) NSArray *essentialEntries;

+ (EssentialStorageController *)sharedInstance;

//- (EssentialFoodEntry *)createEssentialEntryWithTitle:(NSString *)title amount:(NSNumber *)amount type:(NSString *)type weight:(NSNumber *)weight expiration:(NSString *)expiration;

- (void)addEssentialEntry:(EssentialFoodEntry *)essentialEntry;
- (void)removeEssentialEntry:(EssentialFoodEntry *)essentialEntry;

- (void)save;

@end
