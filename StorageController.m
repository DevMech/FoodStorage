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
        [sharedInstance loadFromPersistentStorage];
    });
    
    return sharedInstance;
}

- (void)createFoodEntryWithTitle:(NSString *)title amount:(NSNumber *)amount type:(NSString *)type expiration:(NSDate *)expiration barcode:(NSString *)barcode {
    
    FoodEntry *foodEntry = [FoodEntry new];
    foodEntry.title = title;
    foodEntry.type = type;
    foodEntry.amount = amount;
    foodEntry.expiration = expiration;
    foodEntry.timestamp = [NSDate date];
    foodEntry.barcode = barcode;
    
    [self addFoodEntry:foodEntry];
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

- (NSArray *)entriesForEssential:(Essential)essential {

    NSString *essentialKey = [NSString stringWithFormat:@"essential-%ld", (long)essential];
    NSMutableArray *mutableFoodDictionaries = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:essentialKey]];

    NSMutableArray *entries = [NSMutableArray new];
    for (NSDictionary *foodEntry in mutableFoodDictionaries) {
        [entries addObject:[[FoodEntry alloc] initWithDictionary:foodEntry]];
    }

    return entries;
}

-(void)addFoodEntry:(FoodEntry *)entry forEssential:(Essential)essential {
    if (!entry) {
        return;
    }
    
    NSString *essentialKey = [NSString stringWithFormat:@"essential-%ld", (long)essential];
    NSMutableArray *mutableFoodEntries = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:essentialKey]];
    [mutableFoodEntries addObject:entry.dictionaryRepresentation];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableFoodEntries forKey:essentialKey];
}

- (void)removeFoodEntry:(FoodEntry *)foodEntry forEssential:(Essential)essential {
    // You need to write this method

    NSString *essentialKey = [NSString stringWithFormat:@"essential-%ld", (long)essential];
    NSMutableArray *mutableFoodEntries = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:essentialKey]];

    // Find the one passed in, and remove it
    
    // Then save the new array to defaults
    [[NSUserDefaults standardUserDefaults] setObject:mutableFoodEntries forKey:essentialKey];

}

- (BOOL)saveToPersistentStorage {
    NSMutableArray *foodEntryDictionaries = [NSMutableArray new];
    for (FoodEntry *foodEntry in self.foodEntries) {
        [foodEntryDictionaries addObject:[foodEntry dictionaryRepresentation]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:foodEntryDictionaries forKey:AllFoodEntriesKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    // Only return yes if it successfully saves
    return YES;
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

- (NSArray *)essentialNames {

    NSArray *essentialNames = @[@"Grains", @"Dry Beans", @"Fats And Oils", @"Powdered Milk", @"Salt", @"Water"];
    return essentialNames;
    
}

@end
