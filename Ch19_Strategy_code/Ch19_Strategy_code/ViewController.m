//
//  ViewController.m
//  Ch19_Strategy_code
//
//  Created by 徐利华 on 2019/7/12.
//  Copyright © 2019 徐利华. All rights reserved.
//

#import "ViewController.h"
#import "NumericInputValidator.h"
#import "AlphaInputValidator.h"

@interface ViewController ()<UITextFieldDelegate>  

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    //if (textField == numericTextField)
    //{
    // validate [textField text] and make sure
    // the value is numeric
    //}
    //else if (textField == alphaTextField)
    //{
    // validate [textField text] and make sure
    // the value contains only letters
    //}
    
    if ([textField isKindOfClass:[CustomTextField class]]) {
        [(CustomTextField*)textField validate];
    }
}

@end
