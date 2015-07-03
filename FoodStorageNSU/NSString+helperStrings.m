//
//  NSString+helperStrings.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 7/3/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "NSString+helperStrings.h"

@implementation NSString (helperStrings)

+(NSString *)getSuffixForEssential:(Essential)essential
{
    switch (essential) {
        case EssentialGrains:
            return @"lb";
            break;
        case EssentialDryBeans:
            return @"lb";
            break;
        case EssentialFatsAndOils:
            return @"qt";
            break;
        case EssentialPowderedMilk:
            return @"lb";
            break;
        case EssentialSalt:
            return @"lb";
            break;
        default:
            return @"gal";
            break;
    }
}

@end
