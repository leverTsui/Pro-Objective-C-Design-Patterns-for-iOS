//
//  Car.m
//  Facade
//
//  Created by Carlo Chung on 11/15/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "Car.h"

@implementation Car

- (void)releaseBrakes {
    NSLog(@"releaseBrakes");
}

- (void)changeGears {
    NSLog(@"changeGears");
}

- (void)pressAccelerator {
    NSLog(@"pressAccelerator");
}

- (void)pressBrakes {
    NSLog(@"pressBrakes");
}

- (void)releaseAccelerator {
    NSLog(@"releaseAccelerator");
}

@end
