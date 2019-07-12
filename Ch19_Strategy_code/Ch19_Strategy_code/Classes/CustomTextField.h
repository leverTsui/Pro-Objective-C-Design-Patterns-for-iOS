//
//  CustomTextField.h
//  Strategy
//
//  Created by Carlo Chung on 8/2/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputValidator.h"

@interface CustomTextField : UITextField

@property (nonatomic, weak) IBOutlet InputValidator *inputValidator;

- (BOOL) validate;

@end
