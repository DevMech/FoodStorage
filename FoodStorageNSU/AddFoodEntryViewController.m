//
//  AddFoodEntryViewController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/24/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "AddFoodEntryViewController.h"
#import "EssentialStorageController.h"


@interface AddFoodEntryViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *UpcAndWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *UpcAndWeightText;
@property (weak, nonatomic) IBOutlet UITextField *typeText;
@property (weak, nonatomic) IBOutlet UITextField *amountText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;



@end

@implementation AddFoodEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateWithEssential:self.essentialNumber];
    
    self.datePicker.enabled = NO;
    self.datePicker.alpha = 0;
}

- (void)updateWithEssential:(Essential)essential  {

    if (essential == EssentialAll) {
    
        self.UpcAndWeightLabel.text = @"UPC";
    
    } else {
        
        switch (essential) {
            case EssentialGrains:
                self.UpcAndWeightLabel.text = @"Weight";
                break;
            case EssentialDryBeans:
                self.UpcAndWeightLabel.text = @"Weight";
                break;
                
                
            default:
                break;
                
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveButtonTapped:(id)sender {

    if (self.essentialNumber == 6) {

       [[StorageController sharedInstance]createFoodEntryWithTitle:self.nameText.text amount:[[NSNumberFormatter new] numberFromString: self.amountText.text] type:self.typeText.text expiration:self.datePicker.date barcode:self.UpcAndWeightText.text];

    } else {
        
        // Save essential
        [EssentialStorageController essentialEntry:self.essentialNumber];
        
    }
        
    self.nameText.text = @"";
    self.UpcAndWeightText.text = @"";
    self.typeText.text = @"";
    self.amountText.text = @"";
    
    [UIView animateWithDuration:1.5 animations:^{
        self.datePicker.alpha = 0;
    }];
    
    
}
- (IBAction)calendarPopUp:(id)sender {
    self.datePicker.enabled = YES;
    
    [UIView animateWithDuration:1.5 animations:^{
        self.datePicker.alpha = 1;
    }];
    
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
