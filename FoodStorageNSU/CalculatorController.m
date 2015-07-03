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
//@property (nonatomic, strong) NSNumber *numberOfWeeks;

@end

@implementation CalculatorController

+ (instancetype)sharedInstance { //Create Variable
    
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

        
        // CONSTANTS FOR THE CALCULATIONS

    }
    return self;
}
- (void)numberOfWeeks:(NSNumber *)numberofWeeks {
    
}
- (void)amountByFamily:(NSString *)adults andKids:(NSString *)kids andNumberOfWeeks:(NSString *)weeks
{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    //We're Formatting the incoming string to become NSNumbers
    
    
    NSNumber *numberOfAdults = [formatter numberFromString:adults];
    [[NSUserDefaults standardUserDefaults] setObject:numberOfAdults forKey:@"adultsKey"];
    NSNumber *numberOfKids = [formatter numberFromString:kids];
    [[NSUserDefaults standardUserDefaults] setObject:numberOfKids forKey:@"kidsKey"];
    NSNumber *numberOfWeeks = [formatter numberFromString:weeks];
    [[NSUserDefaults standardUserDefaults] setObject:numberOfWeeks forKey:@"weeksKey"];
    //Defining the instances using the foramtting to use the numbers from the labels
    
    
    NSNumber *numberOfPeople = @([numberOfAdults floatValue] + [numberOfKids floatValue]);
    //Defining what number of people is adding the number of adults by the number of kids.
    
    NSNumber *requiredGrains = @([numberOfPeople floatValue] * [grainsPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredDryBeans = @([numberOfPeople floatValue] * [dryBeansPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredFatsAndOils = @([numberOfPeople floatValue] * [fatsAndOilsPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredPowderedMilk = @([numberOfPeople floatValue] * [powderedMilkPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredSalt = @([numberOfPeople floatValue] * [saltPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredWater = @([numberOfPeople floatValue] * [waterPerPerson floatValue] * [numberOfWeeks floatValue]);
    
    //setting the requiered ammount of essentials - taking the number of people multiplied by the requiered amount and the number of weeks
        
    for (int i = 0; i < [StorageController sharedInstance].essentialNames.count; i++) {
        // THE INDEX NUMBER NEEDS TO CORRELATE WITH THE INDEXES OF THE TABLE VIEW IN THE MAIN VIEW CONTROLLER
        
        
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
