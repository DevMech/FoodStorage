//
//  CalculatorController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "CalculatorController.h"
#import "EssentialFoodEntry.h"

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

+ (instancetype)sharedInstance { //Create Variable
    
    static CalculatorController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CalculatorController alloc] init];
        
//        sharedInstance.arrayOfRequirements = @[
        grainsPerPerson = [NSNumber numberWithFloat:6.25f];
        dryBeansPerPerson = [NSNumber numberWithFloat:1.25f];
        fatsAndOilsPerPerson = [NSNumber numberWithFloat:2.5f];
        powderedMilkPerPerson = [NSNumber numberWithFloat:4];
        saltPerPerson = [NSNumber numberWithFloat:2];
        waterPerPerson = [NSNumber numberWithFloat:7];
//        ];
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

- (void)amountByFamily:(NSString *)adults andKids:(NSString *)kids andNumberOfWeeks:(NSString *)weeks
{

#pragma mark - DONT TOUCH THIS
    NSArray *arrayOfEssentials = [EssentialStorageController sharedInstance].essentialEntries;
    //Array of Essential food stored in the Essential Storage Controller
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    //We're Formatting the incoming string to become NSNumbers
    
    
    NSNumber *numberOfAdults = [formatter numberFromString:adults];
    NSNumber *numberOfKids = [formatter numberFromString:kids];
    NSNumber *numberOfWeeks = [formatter numberFromString:weeks];
    //Defining the instances using the foramtting to use the numbers from the labels
    
    
    NSNumber *numberOfPeople = @([numberOfAdults floatValue] + [numberOfKids floatValue]);
    //Defining what number of people is adding the number of adults by the number of kids.
    
//#warning Need to setup all the required amounts here - Daniel
    NSNumber *requiredGrains = @([numberOfPeople floatValue] * [grainsPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredDryBeans = @([numberOfPeople floatValue] * [dryBeansPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredFatsAndOils = @([numberOfPeople floatValue] * [fatsAndOilsPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredPowderedMilk = @([numberOfPeople floatValue] * [powderedMilkPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredSalt = @([numberOfPeople floatValue] * [saltPerPerson floatValue] * [numberOfWeeks floatValue]);
    NSNumber *requiredWater = @([numberOfPeople floatValue] * [waterPerPerson floatValue] * [numberOfWeeks floatValue]);
    
//    NSArray *requiredFoodAmount = [[NSArray alloc]init];
//    for (NSNumber *requireAmount in self.arrayOfRequirements) {
//        NSNumber *requireFood =  @([numberOfPeople floatValue] * [requireAmount floatValue] * [numberOfWeeks floatValue]);
//        requiredFoodAmount = [requiredFoodAmount arrayByAddingObject:requireFood];
//    }
    
    //setting the requiered ammount of essentials - taking the number of people multiplied by the requiered amount and the number of weeks
    NSMutableArray *arrayToSave = [[NSMutableArray alloc]init];
    //IMPORTANT: Array to replace/update the existant array [EssentialStorageController sharedInstance].essentialEntries with the new values
    
    
    for (int i = 0; 0 < arrayOfEssentials.count; i++) {
        // THE INDEX NUMBER NEEDS TO CORRELATE WITH THE INDEXES OF THE TABLE VIEW IN THE MAIN VIEW CONTROLLER

        EssentialIndex index = i;
        
        EssentialFoodEntry *entry = arrayOfEssentials[index];
        
        switch (index) {
            case EssentialIndexDryBeans:
                entry.requiredAmount = requiredGrains;
                break;
            case EssentialIndexGrains:
                entry.requiredAmount = requiredDryBeans;
                break;
            case EssentialIndexFatsAndOils:
                entry.requiredAmount = requiredFatsAndOils;
                break;
            case EssentialIndexPowderedMilk:
                entry.requiredAmount = requiredPowderedMilk;
                break;
            case EssentialIndexSalt:
                entry.requiredAmount = requiredSalt;
                break;
            case EssentialIndexWater:
                entry.requiredAmount = requiredWater;
                break;
        }
        
        [arrayToSave addObject:entry];
    }

        [EssentialStorageController sharedInstance].essentialEntries = arrayToSave;

}

@end
