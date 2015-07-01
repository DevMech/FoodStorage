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
#import "CalculatorResultsStorageHelper.h"
#import "AddFoodEntryViewController.h"


@interface FoodStorageViewController ()

@property (assign, nonatomic) Essential displayEssential;
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

- (void)setEssentialValues:(Essential)EssentialSetting Alpha:(int)alpha {
    
    self.displayEssential = EssentialSetting;
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


    BOOL greater = sender.selectedSegmentIndex > self.displayEssential;
    
    if (sender.selectedSegmentIndex == EssentialAll) {
        [self setEssentialValues:sender.selectedSegmentIndex Alpha:0];
    } else {
        [self setEssentialValues:sender.selectedSegmentIndex Alpha:1];
    }

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation: greater ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight];
    
}

#pragma mark - TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StorageTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"foodCell"];
    
    FoodEntry *foodEntry = [[StorageController sharedInstance] entriesForEssential:self.displayEssential][indexPath.row];
    [cell updateWithFoodEntry:foodEntry];
    
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[StorageController sharedInstance] entriesForEssential:self.displayEssential].count;
    
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AddFoodEntryViewController *foodEntryViewController = [segue destinationViewController];
    foodEntryViewController.essential = self.displayEssential;
    
}

@end
