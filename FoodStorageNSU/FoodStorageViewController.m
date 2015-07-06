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
#import "CalculatorController.h"
#import "NSString+helperStrings.h"



@interface FoodStorageViewController ()

@property (assign, nonatomic) Essential displayEssential;
@property (weak, nonatomic) IBOutlet UILabel *recommendedLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (assign, nonatomic) CGFloat headerViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *recommendedPlaceHolder;
@property (weak, nonatomic) IBOutlet UILabel *currentPlaceHolder;
@property (weak, nonatomic) IBOutlet UILabel *numberOfWeeks;
@property (weak, nonatomic) IBOutlet UILabel *numberOfWeeksPlaceHolder;

@end

@implementation FoodStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headerViewHeight = self.headerView.frame.size.height;
    self.displayEssential = EssentialGrains;
    self.imageView.image = [UIImage imageNamed:@"grains"];
    self.progressBar.transform = CGAffineTransformMakeScale(1.0f, 4.0f);

    
    
   
}

- (void)showProgressBar
{
    if (self.displayEssential != EssentialAll) {
        
        double values = [[StorageController sharedInstance] weightOrVolumeForEssential:self.displayEssential]/[CalculatorResultsStorageHelper requiredAmountForEssential:self.displayEssential];
        NSNumber *percentageForProgress = [NSNumber numberWithDouble:values];
        self.progressBar.progress = [percentageForProgress floatValue]; NSLog(@"%@", percentageForProgress);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.displayEssential == EssentialAll) {
        self.recommendedPlaceHolder.text = @"";
        self.currentPlaceHolder.text = @"";
        
    }
    else
    {
        [self displayStats];
        [self showProgressBar];
    }
    [self.tableView reloadData];
    
}


-(void)displayStats
{
    NSString *temporaryString = [NSString stringWithFormat:@"%.1f %@",[CalculatorResultsStorageHelper requiredAmountForEssential:self.displayEssential], [NSString getSuffixForEssential:self.displayEssential]];
    self.recommendedPlaceHolder.text = temporaryString;
    NSString *string = [NSString stringWithFormat:@"%.1f %@",[[StorageController sharedInstance] weightOrVolumeForEssential:self.displayEssential], [NSString getSuffixForEssential:self.displayEssential]];
    self.currentPlaceHolder.text = string;
    NSString *weeksString = [NSString stringWithFormat:@"%.1f", [CalculatorController sharedInstance].numberOfWeeks];
    self.numberOfWeeksPlaceHolder.text = weeksString;
}

- (void)setEssentialValues:(Essential)EssentialSetting Alpha:(int)alpha {
    
    self.displayEssential = EssentialSetting;
    self.recommendedLabel.alpha = alpha;
    self.currentLabel.alpha = alpha;
    self.numberOfWeeks.alpha = alpha;
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
    self.displayEssential = sender.selectedSegmentIndex;
    [self showProgressBar];
    
    if (sender.selectedSegmentIndex == EssentialAll) {
        self.recommendedPlaceHolder.text = @"";
        self.currentPlaceHolder.text = @"";
        self.numberOfWeeksPlaceHolder.text = @"";
        [self setEssentialValues:sender.selectedSegmentIndex Alpha:0];
    } else {
        [self displayStats];

        [self setEssentialValues:sender.selectedSegmentIndex Alpha:1];
    }
    

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation: greater ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight];
    switch (self.displayEssential) {
        case EssentialGrains:
            self.imageView.image = [UIImage imageNamed:@"grains"];
            break;
        case EssentialDryBeans:
            self.imageView.image = [UIImage imageNamed:@"beans"];
            break;
        case EssentialFatsAndOils:
            self.imageView.image = [UIImage imageNamed:@"oils"];
            break;
        case EssentialPowderedMilk:
            self.imageView.image = [UIImage imageNamed:@"milk"];
            break;
        case EssentialSalt:
            self.imageView.image = [UIImage imageNamed:@"salt"];
            break;
        case EssentialWater:
            self.imageView.image = [UIImage imageNamed:@"water"];
            break;
            
        case EssentialAll:
            self.imageView.image = nil;
            break;
            
    }
}

#pragma mark - TableViewDatasource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StorageTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"foodCell"];
    
    FoodEntry *foodEntry = [[StorageController sharedInstance] entriesForEssential:self.displayEssential][indexPath.row];
    [cell updateWithFoodEntry:foodEntry];
    
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[StorageController sharedInstance] entriesForEssential:self.displayEssential].count;
    
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodEntry *foodEntry = [[StorageController sharedInstance] entriesForEssential:self.displayEssential][indexPath.row];
    [[StorageController sharedInstance] removeFoodEntry:foodEntry forEssential:self.displayEssential];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView reloadData];
        [self viewDidAppear:YES];
        
       
        
    }

}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addSegue"]) {
        AddFoodEntryViewController *foodEntryViewController = [segue destinationViewController];
        foodEntryViewController.essential = self.displayEssential;
    }
    

    
    
}

@end
