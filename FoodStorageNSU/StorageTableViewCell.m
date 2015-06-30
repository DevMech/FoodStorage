//
//  StorageTableViewCell.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/26/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "StorageTableViewCell.h"
@interface StorageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationLabel;


@end

@implementation StorageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithFoodEntry:(FoodEntry *)foodEntry {
    self.nameLabel.text = [foodEntry title];
    self.typeLabel.text = [foodEntry type];
    self.amountLabel.text = [NSString stringWithFormat:@"%@",[foodEntry amount]];

    // Use date formatter to convert date into string
    NSDateFormatter *formattedDated = [[NSDateFormatter alloc]init];
    [formattedDated setDateFormat:@"yyyy/MM/dd"];

    NSString *finalString = [formattedDated stringFromDate:[foodEntry expiration]];

    self.expirationLabel.text =finalString;
    
}

@end
