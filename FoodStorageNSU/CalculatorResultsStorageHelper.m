//
//  CalculatorResultsStorageHelper.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/23/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "CalculatorResultsStorageHelper.h"



static NSString * AllEssentialEntriesKey = @"allEssentialEntries";

@interface CalculatorResultsStorageHelper ()

@property (nonatomic, strong) NSArray *essentialEntries;
@property (nonatomic, assign) double currentValue;


@end

@implementation CalculatorResultsStorageHelper

+ (FoodEntry *)essentialEntry:(Essential)essential {
    NSMutableDictionary *essentialEntry = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:[StorageController sharedInstance].essentialNames[essential]]];
    return [[FoodEntry alloc] initWithDictionary:essentialEntry];
}

+ (void)updateFoodEntry:(FoodEntry *)entry forEssential:(Essential)essential {
    
    NSMutableDictionary *essentialEntry = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:[StorageController sharedInstance].essentialNames[essential]]];
    if (essentialEntry.allKeys.count == 0) {
        
        // setting the first entry for essentials
        essentialEntry = [NSMutableDictionary new];
        essentialEntry[TitleKey] = [StorageController sharedInstance].essentialNames[essential];
        essentialEntry[TypeKey] = @"";
        essentialEntry[AmountKey] = @(0);
        essentialEntry[WeightKey] = @(0);
        essentialEntry[ExpirationKey] = @"";
        essentialEntry[TimestampKey] = @"";
        essentialEntry[Barcode] = @"";
        essentialEntry[RequiredKey] = @(0);
    }
    
    FoodEntry *newEntry = [[FoodEntry alloc] initWithDictionary:essentialEntry];
    newEntry.title = [StorageController sharedInstance].essentialNames[essential];
    newEntry.type = entry.type;
    newEntry.amount = entry.amount;
    newEntry.weight = entry.weight;
    newEntry.expiration = entry.expiration;
    newEntry.timestamp = entry.timestamp;
    newEntry.barcode = entry.barcode;
    newEntry.requiredAmount = entry.requiredAmount;
    
    [[NSUserDefaults standardUserDefaults] setObject:[newEntry dictionaryRepresentation] forKey:[StorageController sharedInstance].essentialNames[essential]];
    
}

+ (double)requiredAmountForEssential:(Essential)essential {

    FoodEntry *entry = [self essentialEntry:essential];
    return entry.requiredAmount.doubleValue;
    
}



@end
