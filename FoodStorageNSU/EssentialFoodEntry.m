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
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSDictionary *essentialFoodDictionary = @{
                                     TitleKey : self.title,
                                     TypeKey : self.type,
                                     AmountKey : self.amount,
                                     WeightKey : self.weight,
                                     TimestampKey : self.timestamp,
                                     };
    
    return essentialFoodDictionary;
    
}





@end
