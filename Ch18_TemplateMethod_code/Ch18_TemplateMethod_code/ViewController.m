//
//  ViewController.m
//  Ch18_TemplateMethod_code
//
//  Created by 徐利华 on 2019/7/12.
//  Copyright © 2019 徐利华. All rights reserved.
//

#import "ViewController.h"
#import "AnySandwich.h"
#import "Hamburger.h"
#import "Hotdog.h"
#import "ReubenSandwich.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AnySandwich *sandwich = [[AnySandwich alloc] init];
    [sandwich make];
    
    Hamburger *hamburger = [[Hamburger alloc] init];
    [hamburger make];
    
    Hotdog *hotdog = [[Hotdog alloc] init];
    [hotdog make];
    
    ReubenSandwich *reubenSandwich = [[ReubenSandwich alloc] init];
    [reubenSandwich make];
}

@end
