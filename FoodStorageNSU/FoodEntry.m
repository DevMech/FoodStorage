//
//  FoodEntry.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "FoodEntry.h"

@implementation FoodEntry

- (instancetype)initWithDictionary:(NSDictionary *)foodDictionary {
    
    self = [super init];
    if (self) {
        self.title = foodDictionary[TitleKey];
        self.type = foodDictionary[TypeKey];
        self.amount = foodDictionary[AmountKey];
        self.weight = foodDictionary [WeightKey];
        self.expiration = foodDictionary[ExpirationKey];
        self.timestamp = foodDictionary [TimestampKey];
        self.requiredAmount = foodDictionary[RequiredKey];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *foodDictionary = [NSMutableDictionary new];
    
    if (self.title) {
        foodDictionary[TitleKey] = self.title;
    }
    
    if (self.type) {
        foodDictionary[TypeKey] = self.type;
    }

    if (self.amount) {
        foodDictionary[AmountKey] = self.amount;
    }

    if (self.weight) {
        foodDictionary[WeightKey] = self.weight;
    }

    if (self.expiration) {
        foodDictionary[ExpirationKey] = self.expiration;
    }

    if (self.timestamp) {
        foodDictionary[TimestampKey] = self.timestamp;
    }

    if (self.requiredAmount) {
        foodDictionary[RequiredKey] = self.requiredAmount;
    }

    return foodDictionary;
    
}



@end
