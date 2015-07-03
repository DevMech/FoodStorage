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

- (void)createFoodEntryWithTitle:(NSString *)title amount:(NSNumber *)amount type:(NSString *)type expiration:(NSDate *)expiration barcode:(NSString *)barcode essential:(Essential)essential {
    
    FoodEntry *foodEntry = [FoodEntry new];
    foodEntry.title = title;
    foodEntry.type = type;
    foodEntry.amount = amount;
    foodEntry.expiration = expiration;
    foodEntry.timestamp = [NSDate date];
    foodEntry.barcode = barcode;
    
    [self addFoodEntry:foodEntry forEssential:essential];
    
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
    
    for (int i = 0; i < mutableFoodEntries.count; i++) {
        NSDictionary *checkEntry = mutableFoodEntries[i];
        
        // You can't create 2 at once. They will only have the same timestamp if they are the same thing.
        
        if ([checkEntry[TimestampKey] isEqualToDate:foodEntry.timestamp]) {
            [mutableFoodEntries removeObject:checkEntry];
        }
    }
    
    // Then save the new array to defaults
    [[NSUserDefaults standardUserDefaults] setObject:mutableFoodEntries forKey:essentialKey];

}

- (NSArray *)essentialNames {

    NSArray *essentialNames = @[@"Grains", @"Dry Beans", @"Fats And Oils", @"Powdered Milk", @"Salt", @"Water"];
    return essentialNames;
    
}

- (double)weightOrVolumeForEssential:(Essential)essential {
    NSArray *essentialEntries = [self entriesForEssential:essential];
    NSNumber *currentSum = [essentialEntries valueForKeyPath:@"@sum.amount"];
    
    
    
    return [currentSum doubleValue];
    
}

@end
