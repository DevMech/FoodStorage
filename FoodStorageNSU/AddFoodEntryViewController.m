//
//  AddFoodEntryViewController.m
//  FoodStorageNSU
//
//  Created by Austin Mecham on 6/24/15.
//  Copyright (c) 2015 Austin Mecham. All rights reserved.
//

#import "AddFoodEntryViewController.h"
#import "CalculatorResultsStorageHelper.h"


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
    [self updateWithEssential:self.essential];
    
    self.datePicker.enabled = NO;
    self.datePicker.alpha = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    switch (self.essential) {
        case EssentialAll:
            self.title = @"All Items";
            break;
            
        default:{
            FoodEntry *entry = [CalculatorResultsStorageHelper essentialEntry:self.essential];
            self.title = entry.title;

        }
        break;
    }

}

- (void)updateWithEssential:(Essential)essential  {

    if (essential == EssentialAll) {
    
        self.UpcAndWeightLabel.text = @"UPC";
    
    } else {
        
        switch (essential) {
            case EssentialGrains:
                self.amountLabel.text = @"Pounds";
                break;
            case EssentialDryBeans:
                self.amountLabel.text = @"Pounds";
                break;
            case EssentialFatsAndOils:
                self.amountLabel.text = @"Quarts";
                break;
            case EssentialPowderedMilk:
                self.amountLabel.text = @"Pounds";
                break;
            case EssentialSalt:
                self.amountLabel.text = @"Pounds";
            case EssentialWater:
                self.amountLabel.text = @"Gallons";
                
                
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

    [[StorageController sharedInstance] createFoodEntryWithTitle:self.nameText.text amount:[[NSNumberFormatter new] numberFromString: self.amountText.text] type:self.typeText.text expiration:self.datePicker.date barcode:self.UpcAndWeightText.text essential:self.essential];

    self.nameText.text = @"";
    self.UpcAndWeightText.text = @"";
    self.typeText.text = @"";
    self.amountText.text = @"";
    
    [UIView animateWithDuration:1.5 animations:^{
        self.datePicker.alpha = 0;
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

@end
