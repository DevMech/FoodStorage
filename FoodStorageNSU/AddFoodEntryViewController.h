//
//  AddFoodEntryViewController.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/24/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StorageController.h"

@interface AddFoodEntryViewController : UIViewController
@property (readwrite, nonatomic) Essential essential;
@property (readwrite, nonatomic) int essentialNumber;

@end
