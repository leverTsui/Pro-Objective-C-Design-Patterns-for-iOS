//
//  Hotdog.m
//  TemplateMethod
//
//  Created by Carlo Chung on 7/31/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "Hotdog.h"

@implementation Hotdog

- (void)prepareBread {
  [self getHotdogBun];
}

- (void)addMeat {
  [self addWiener];
}

- (void)addCondiments {
  [self addKetchup];
  [self addMustard];
  [self addOnion];
}

#pragma mark - Hotdog Specific Methods

- (void)getHotdogBun {
    NSLog(@"getHotdogBun");
}

- (void)addWiener {
    NSLog(@"addWiener");
}

- (void)addKetchup {
    NSLog(@"addKetchup");
}

- (void)addMustard{
    NSLog(@"addMustard");
}

- (void)addOnion {
    NSLog(@"addOnion"); 
}

@end
