//
//  EssentialFoodEntry.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/23/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const TitleKey = @"title";
static NSString * const TypeKey = @"type";
static NSString * const AmountKey = @"amount";
static NSString * const WeightKey = @"weight";
static NSString * const TimestampKey = @"timestamp";

@interface EssentialFoodEntry : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSNumber *amount;
@property (strong, nonatomic) NSNumber *weight;
@property (strong, nonatomic) NSDate *timestamp;

- (instancetype)initWithDictionary:(NSDictionary *)essentialFoodDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
