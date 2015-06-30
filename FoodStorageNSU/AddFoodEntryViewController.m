//
//  AddFoodEntryViewController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/24/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "AddFoodEntryViewController.h"
#import "StorageController.h"

@interface AddFoodEntryViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *UPCLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *UPCText;
@property (weak, nonatomic) IBOutlet UITextField *typeText;
@property (weak, nonatomic) IBOutlet UITextField *amountText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation AddFoodEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datePicker.enabled = NO;
    self.datePicker.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveButtonTapped:(id)sender {
    
       [[StorageController sharedInstance]createFoodEntryWithTitle:self.nameText.text amount:[[NSNumberFormatter new] numberFromString: self.amountText.text] type:self.typeText.text expiration:self.datePicker.date barcode:self.UPCText.text];
    self.nameText.text = @"";
    self.UPCText.text = @"";
    self.typeText.text = @"";
    self.amountText.text = @"";
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.datePicker.enabled = YES;
    self.datePicker.alpha = 1;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
