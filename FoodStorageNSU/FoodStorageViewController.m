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
#import "AddFoodEntryViewController.h"

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
@property (weak, nonatomic) IBOutlet UILabel *recommendedLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (assign, nonatomic) CGFloat headerViewHeight;

@end

@implementation FoodStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headerViewHeight = self.headerView.frame.size.height;
    self.navigationItem.title = @"Grain";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)setDisplayValues:(DisplaySetting)displaySetting Alpha:(int)alpha {
    
    self.displaySetting = displaySetting;
    self.recommendedLabel.alpha = alpha;
    self.currentLabel.alpha = alpha;
    self.progressBar.alpha = alpha;
    self.imageView.alpha = alpha;
    if (alpha == 0) {
        CGRect newView = self.headerView.frame;
        newView.size.height = self.segmentedController.frame.size.height + 10;
        self.headerView.frame = newView;
        [self.tableView setTableHeaderView:self.headerView];
    }
    else {
        CGRect newView = self.headerView.frame;
        newView.size.height = self.headerViewHeight;
        self.headerView.frame = newView;
        [self.tableView setTableHeaderView:self.headerView];
        
        
    }
}

#pragma mark - Actions

- (IBAction)segmentedControlUpdated:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case DisplayGrain:
            [self setDisplayValues:DisplayGrain Alpha:1];
            break;
            
        case DisplayBean:
            [self setDisplayValues:DisplayBean Alpha:1];
            break;
            
        case DisplayFat:
            [self setDisplayValues:DisplayFat Alpha:1];
            break;
         
        case DisplayMilk:
            [self setDisplayValues:DisplayMilk Alpha:1];
            break;
           
        case DisplaySalt:
            [self setDisplayValues:DisplaySalt Alpha:1];
            break;
            
        case DisplayWater:
            [self setDisplayValues:DisplayWater Alpha:1];
            break;
            
        case DisplayAll:
            [self setDisplayValues:DisplayAll Alpha:0];
            break;
    }
    
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




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddFoodEntryViewController *foodEntryViewController = [segue destinationViewController];
    
    
    switch (self.displaySetting) {
        case DisplayGrain:
            foodEntryViewController.essentialNumber = self.displaySetting;
            break;
        case DisplayBean:
            
        case DisplayFat:
            
        case DisplayMilk:
            
        case DisplaySalt:
            
        case DisplayWater:
            
        case DisplayAll:
            foodEntryViewController.essentialNumber = self.displaySetting;
            break;
    }
    
}

@end
