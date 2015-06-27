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

- (FoodEntry *)essentialEntry:(Essential)essential {
    NSMutableDictionary *essentialEntry = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:self.essentialNames[essential]]];
    return [[FoodEntry alloc] initWithDictionary:essentialEntry];
}

- (void)addFoodEntry:(FoodEntry *)entry forEssential:(Essential)essential {

    NSMutableDictionary *essentialEntry = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:self.essentialNames[essential]]];
    if (essentialEntry.allKeys.count == 0) {

        // setting the first entry for essentials
        essentialEntry = [NSMutableDictionary new];
        essentialEntry[TitleKey] = self.essentialNames[essential];
        essentialEntry[TypeKey] = @"";
        essentialEntry[AmountKey] = @(0);
        essentialEntry[WeightKey] = @(0);
        essentialEntry[ExpirationKey] = @"";
        essentialEntry[TimestampKey] = @"";
        essentialEntry[Barcode] = @"";
        essentialEntry[RequiredKey] = @(0);
    }
    
    FoodEntry *newEntry = [[FoodEntry alloc] initWithDictionary:essentialEntry];
    newEntry.title = self.essentialNames[essential];
    newEntry.type = entry.type;
    newEntry.amount = entry.amount;
    newEntry.weight = entry.weight;
    newEntry.expiration = entry.expiration;
    newEntry.timestamp = entry.timestamp;
    newEntry.barcode = entry.barcode;
    newEntry.requiredAmount = entry.requiredAmount;
    
    [[NSUserDefaults standardUserDefaults] setObject:[newEntry dictionaryRepresentation] forKey:self.essentialNames[essential]];
    
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
