//
//  CalculatorViewController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorController.h"

@interface CalculatorViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *adultStepper;
@property (weak, nonatomic) IBOutlet UIStepper *childStepper;
@property (weak, nonatomic) IBOutlet UIStepper *weekStepper;
@property (weak, nonatomic) IBOutlet UILabel *adultLabel;
@property (weak, nonatomic) IBOutlet UILabel *childLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *adultsNumber;
@property (weak, nonatomic) IBOutlet UILabel *childNumber;
@property (weak, nonatomic) IBOutlet UILabel *weekNumber;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)adultStepperChange:(id)sender {
    self.adultsNumber.text = [@(self.adultStepper.value) stringValue];
    
}
- (IBAction)childStepperChange:(id)sender {
    self.childNumber.text = [@(self.childStepper.value) stringValue];
}
- (IBAction)weekStepperChange:(id)sender {
    self.weekNumber.text = [@(self.weekStepper.value) stringValue];
}
- (IBAction)calculateAmounts:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [[CalculatorController sharedInstance] amountByFamily:self.adultsNumber.text andKids:self.childNumber.text andNumberOfWeeks:self.weekNumber.text];
    
}

#pragma mark -
#pragma mark - DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    switch (section) {
        case 0:
            return 4;
            break;
        default:
            return 1;
            break;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


@end
