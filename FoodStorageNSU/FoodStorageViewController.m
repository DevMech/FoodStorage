//
//  FoodStorageViewController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/19/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "FoodStorageViewController.h"
#import "StorageController.h"
#import "StorageTableViewCell.h"
#import "EssentialStorageController.h"

typedef NS_ENUM(NSUInteger, DisplaySetting) {
    DisplayGrain,
    DisplayBean,
    DisplayFat,
    DisplayMilk,
    DisplaySalt,
    DisplayWater,
    DisplayAll,
};


@interface FoodStorageViewController ()

@property (assign, nonatomic) DisplaySetting displaySetting;

@end

@implementation FoodStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)segmentedControlUpdated:(UISegmentedControl *)sender {
    
}

#pragma mark - TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StorageTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"foodCell"];
    
    FoodEntry *foodEntry = [StorageController sharedInstance].foodEntries[indexPath.row];
    [cell updateWithFoodEntry:foodEntry];
    
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    switch (self.displaySetting) {
        case DisplayGrain:
            
        case DisplayBean:
        
        case DisplayFat:
            
        case DisplayMilk:
            
        case DisplaySalt:
            
        case DisplayWater:
            
        case DisplayAll:
            return [StorageController sharedInstance].foodEntries.count;
            
        default:
            
            return 0;
            
            break;
    }
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
