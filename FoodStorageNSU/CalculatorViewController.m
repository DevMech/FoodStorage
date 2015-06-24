//
//  CalculatorViewController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/18/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "CalculatorViewController.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
