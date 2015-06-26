//
//  EssentialFoodEntry.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/23/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "EssentialFoodEntry.h"

@implementation EssentialFoodEntry




- (instancetype)initWithDictionary:(NSDictionary *)essentialFoodDictionary {
    
    self = [super init];
    if (self) {
        self.title = essentialFoodDictionary[TitleKey];
        self.type = essentialFoodDictionary[TypeKey];
        self.amount = essentialFoodDictionary[AmountKey];
        self.weight = essentialFoodDictionary [WeightKey];
        self.timestamp = essentialFoodDictionary [TimestampKey];
        self.requiredAmount = essentialFoodDictionary [RequiredAmountKey];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    
    NSMutableDictionary *essentialFoodDictionary = [[NSMutableDictionary alloc]init];
    if (self.title) {
        essentialFoodDictionary[TitleKey] = self.title;
    }
    if (self.type) {
        essentialFoodDictionary[TypeKey] = self.type;
    }
    if (self.amount) {
        essentialFoodDictionary[AmountKey] = self.amount;
    }
    if (self.weight) {
        essentialFoodDictionary[WeightKey] = self.weight;
    }
    if (self.timestamp) {
        essentialFoodDictionary[TimestampKey] = self.timestamp;
    }
    if (self.requiredAmount) {
        essentialFoodDictionary[RequiredAmountKey] = self.requiredAmount;
    }
    
    return essentialFoodDictionary;
    
}

 
@end
