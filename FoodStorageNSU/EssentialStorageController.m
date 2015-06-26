//
//  EssentialStorageController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/23/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "EssentialStorageController.h"



static NSString * AllEssentialEntriesKey = @"allEssentialEntries";

@interface EssentialStorageController ()

@property (nonatomic, strong) NSArray *essentialEntries;

@end

@implementation EssentialStorageController

+ (EssentialStorageController *)sharedInstance {
    
    static EssentialStorageController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EssentialStorageController alloc] init];
        [sharedInstance loadFromPersistentStorage];
        [sharedInstance CreateEssentialObjects];
    });
    return sharedInstance;
}

- (NSArray *)essentialNames {

    NSArray *essentialNames = @[@"Grains", @"Dry Beans", @"Fats And Oils", @"Powdered Milk", @"Salt", @"Water"];
    return essentialNames;

}

//- (void)createEssentialEntryWithTitle:(NSString *)title amount:(NSNumber *)amount type:(NSString *)type weight:(NSNumber *)weight expiration:(NSString *)expiration toEntry:(EssentialFoodEntry *)essentialEntry{
//    
//    essentialEntry.title = title;
//    essentialEntry.amount = amount;
//    essentialEntry.weight = weight;
//    essentialEntry.expiration = expiration;
//    essentialEntry.timestamp = [NSDate date];
//    
//    [self addEssentialEntry:essentialEntry];
//        
//}

- (void)CreateEssentialObjects
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:AllEssentialEntriesKey]) {
        
        self.essentialEntries = [[NSArray alloc] init];
        for (NSString *name in self.essentialNames) {
            EssentialFoodEntry *essentialFood = [[EssentialFoodEntry alloc]init];
            essentialFood.title = name;
            essentialFood.type = name;
            essentialFood.amount = @0;
            essentialFood.weight = @0;
            essentialFood.timestamp = [NSDate date];
            
            self.essentialEntries = [self.essentialEntries arrayByAddingObject:essentialFood];
        }
        
        [self saveToPersistentStorage];

    }
}


- (void)addEssentialEntry:(EssentialFoodEntry *)essentialEntry {
    if (!essentialEntry) {
        return;
    }
    NSMutableArray *mutableEssentialEntries = self.essentialEntries.mutableCopy;
    [mutableEssentialEntries addObject:essentialEntry];
    
    self.essentialEntries = mutableEssentialEntries;
    [self saveToPersistentStorage];
    
}

- (void)saveToPersistentStorage {
    NSMutableArray *essentialEntryDictionaries = [NSMutableArray new];
    for (EssentialFoodEntry *essentialEntry in self.essentialEntries) {
        [essentialEntryDictionaries addObject:[essentialEntry dictionaryRepresentation]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:essentialEntryDictionaries forKey:AllEssentialEntriesKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (void)loadFromPersistentStorage {
    NSArray *foodEntryDictionaries = [[NSUserDefaults standardUserDefaults]objectForKey:AllEssentialEntriesKey];
    
    NSMutableArray *essentialEntries = [NSMutableArray new];
    for (NSDictionary *essentialEntry in foodEntryDictionaries) {
        [essentialEntries addObject:[[EssentialFoodEntry alloc] initWithDictionary:essentialEntry]];
    }
    
    self.essentialEntries = essentialEntries;
}

- (void)save {
    [self saveToPersistentStorage];
    
}

- (void)removeEssentialEntry:(EssentialFoodEntry *)essentialEntry {
    if (!essentialEntry) {
        return;
    }
    
    NSMutableArray *mutableEssentialEntries = self.essentialEntries.mutableCopy;
    [mutableEssentialEntries removeObject:essentialEntry];
    
    self.essentialEntries = mutableEssentialEntries;
    [self saveToPersistentStorage];
    
}

@end
