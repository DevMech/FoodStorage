//
//  CalculatorController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "CalculatorController.h"
#import "StorageController.h"
#import "CalculatorResultsStorageHelper.h"
#import "FoodEntry.h"

static NSNumber *grainsPerPerson;
static NSNumber *dryBeansPerPerson;
static NSNumber *fatsAndOilsPerPerson;
static NSNumber *powderedMilkPerPerson;
static NSNumber *saltPerPerson;
static NSNumber *waterPerPerson;

@interface CalculatorController ()

@property (nonatomic,strong) NSArray *arrayOfRequirements;


@end

@implementation CalculatorController

+ (instancetype)sharedInstance {
    
    static CalculatorController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CalculatorController alloc] init];
        

        grainsPerPerson = [NSNumber numberWithFloat:6.25f];
        dryBeansPerPerson = [NSNumber numberWithFloat:1.25f];
        fatsAndOilsPerPerson = [NSNumber numberWithFloat:2.5f];
        powderedMilkPerPerson = [NSNumber numberWithFloat:4];
        saltPerPerson = [NSNumber numberWithFloat:2];
        waterPerPerson = [NSNumber numberWithFloat:7];

    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        

    }
    return self;
}
- (void)numberOfWeeks:(NSNumber *)numberofWeeks {
    
}
- (void)amountByFamily:(NSString *)adults andKids:(NSString *)kids andNumberOfWeeks:(NSString *)weeks
{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    
    
    NSNumber *numberOfAdults = [formatter numberFromString:adults];
    [[NSUserDefaults standardUserDefaults] setObject:numberOfAdults forKey:@"adultsKey"];
    NSNumber *numberOfKids = [formatter numberFromString:kids];
    [[NSUserDefaults standardUserDefaults] setObject:numberOfKids forKey:@"kidsKey"];
    NSNumber *numberOfWeeks = [formatter numberFromString:weeks];
    [[NSUserDefaults standardUserDefaults] setObject:numberOfWeeks forKey:@"weeksKey"];
    
    
    
    NSNumber *numberOfPeople = @([numberOfAdults floatValue] + [numberOfKids floatValue]);
   
    
    NSNumber *requiredGrains = @([numberOfPeople floatValue] * [grainsPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredDryBeans = @([numberOfPeople floatValue] * [dryBeansPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredFatsAndOils = @([numberOfPeople floatValue] * [fatsAndOilsPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredPowderedMilk = @([numberOfPeople floatValue] * [powderedMilkPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredSalt = @([numberOfPeople floatValue] * [saltPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredWater = @([numberOfPeople floatValue] * [waterPerPerson floatValue] * [numberOfWeeks floatValue]);
    
        
    for (int i = 0; i < [StorageController sharedInstance].essentialNames.count; i++) {
        
        
        Essential essential = i;
        FoodEntry *entry = [CalculatorResultsStorageHelper essentialEntry:essential];
        
        switch (essential) {
            case EssentialGrains:
                entry.requiredAmount = requiredGrains;
                break;
            case EssentialDryBeans:
                entry.requiredAmount = requiredDryBeans;
                break;
            case EssentialFatsAndOils:
                entry.requiredAmount = requiredFatsAndOils;
                break;
            case EssentialPowderedMilk:
                entry.requiredAmount = requiredPowderedMilk;
                break;
            case EssentialSalt:
                entry.requiredAmount = requiredSalt;
                break;
            case EssentialWater:
                entry.requiredAmount = requiredWater;
                break;
            case EssentialAll:
                entry.requiredAmount = @0;
                break;
        }
     
        [CalculatorResultsStorageHelper updateFoodEntry:entry forEssential:essential];
         
    }

}

-(double)numberOfWeeks
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"weeksKey"]) {
        return [[[NSUserDefaults standardUserDefaults] objectForKey:@"weeksKey"] doubleValue];
    }
    else
    {
        return 0.0;
    }
}

@end
