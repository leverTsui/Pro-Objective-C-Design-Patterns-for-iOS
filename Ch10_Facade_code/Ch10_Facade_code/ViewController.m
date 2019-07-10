//
//  ViewController.m
//  Ch10_Facade_code
//
//  Created by 徐利华 on 2019/7/10.
//  Copyright © 2019 徐利华. All rights reserved.
//

#import "ViewController.h"
#import "CabDriver.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CabDriver *cabDriver = [[CabDriver alloc] init];
    [cabDriver driveToLocation:CGPointMake(100, 100)];
}


@end
