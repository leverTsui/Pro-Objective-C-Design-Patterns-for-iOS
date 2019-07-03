//
//  ViewController.m
//  Ch05_AbstractFactory_code
//
//  Created by 徐利华 on 2019/7/3.
//  Copyright © 2019 徐利华. All rights reserved.
//

#import "ViewController.h"
#import "BrandingFactory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNumber * boolNumber = [NSNumber numberWithBool:YES];
    NSNumber * charNumber = [NSNumber numberWithChar:'a'];
    NSNumber * intNumber = [NSNumber numberWithInt:1];
    NSNumber * floatNumber = [NSNumber numberWithFloat:1.0];
    NSNumber * doubleNumber = [NSNumber numberWithDouble:1.0];
    
    NSLog(@"%@", [[boolNumber class] description]);
    NSLog(@"%@", [[charNumber class] description]);
    NSLog(@"%@", [[intNumber class] description]);
    NSLog(@"%@", [[floatNumber class] description]);
    NSLog(@"%@", [[doubleNumber class] description]);
    
    NSLog(@"%d", [boolNumber intValue]);
    NSLog(@"%@", [charNumber boolValue] ? @"YES" : @"NO");
    
    // construct the view from
    // branded UI elements obtained
    // from a BrandingFactory
    BrandingFactory * factory = [BrandingFactory factory];
    
    //...
    UIView * view = [factory brandedView];
    //... put the view on a proper location in view
    
    //...
    UIButton * button = [factory brandedMainButton];
    //... put the button on a proper location in view
    
    //...
    UIToolbar * toolbar = [factory brandedToolbar];
    //... put the toolbar on a proper location in view
}

@end
