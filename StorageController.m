//
//  StorageController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "StorageController.h"

static NSString * AllFoodEntriesKey = @"allFoodEntries";

@interface StorageController ()

@property (strong, nonatomic) NSArray *foodEntries;

@end

@implementation StorageController

+ (StorageController *)sharedInstance {
    
    static StorageController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[StorageController alloc] init];
    });
    return sharedInstance;
}

- (FoodEntry *)createFoodEntryWithTitle:(NSString *)title amount:(NSNumber *)amount type:(NSString *)type weight:(NSNumber *)weight expiration:(NSString *)expiration {
    
    FoodEntry *foodEntry = [FoodEntry new];
    foodEntry.title = title;
    foodEntry.amount = amount;
    foodEntry.weight = weight;
    foodEntry.expiration = expiration;
    foodEntry.timestamp = [NSDate date];
    
    [self addFoodEntry:foodEntry];
    
    return foodEntry;
    
}



- (void)addFoodEntry:(FoodEntry *)foodEntry {
    if (!foodEntry) {
        return;
    }
    NSMutableArray *mutableFoodEntries = self.foodEntries.mutableCopy;
    [mutableFoodEntries addObject:foodEntry];
    
    self.foodEntries = mutableFoodEntries;
    [self saveToPersistentStorage];
    
}

- (void)saveToPersistentStorage {
    NSMutableArray *foodEntryDictionaries = [NSMutableArray new];
    for (FoodEntry *foodEntry in self.foodEntries) {
        [foodEntryDictionaries addObject:[foodEntry dictionaryRepresentation]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:foodEntryDictionaries forKey:AllFoodEntriesKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (void)loadFromPersistentStorage {
    NSArray *foodEntryDictionaries = [[NSUserDefaults standardUserDefaults]objectForKey:AllFoodEntriesKey];
    
    NSMutableArray *foodEntries = [NSMutableArray new];
    for (NSDictionary *foodEntry in foodEntryDictionaries) {
        [foodEntries addObject:[[FoodEntry alloc] initWithDictionary:foodEntry]];
    }
    
    self.foodEntries = foodEntries;
}

- (void)save {
    [self saveToPersistentStorage];
    
}

- (void)removeFoodEntry:(FoodEntry *)foodEntry {
    if (!foodEntry) {
        return;
    }
    
    NSMutableArray *mutableFoodEntries = self.foodEntries.mutableCopy;
    [mutableFoodEntries removeObject:foodEntry];
    
    self.foodEntries = mutableFoodEntries;
    [self saveToPersistentStorage];
    
}



@end
