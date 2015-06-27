//
//  StorageTableViewCell.h
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/26/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodEntry.h"

@interface StorageTableViewCell : UITableViewCell

- (void)updateWithFoodEntry:(FoodEntry *)foodEntry;

@end
