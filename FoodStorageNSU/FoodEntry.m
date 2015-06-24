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
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSDictionary *foodDictionary = @{
                                     TitleKey : self.title,
                                     TypeKey : self.type,
                                     AmountKey : self.amount,
                                     WeightKey : self.weight,
                                     ExpirationKey : self.expiration,
                                     TimestampKey : self.timestamp,
                                     };
    
    return foodDictionary;
    
}



@end
