//
//  Hamburger.m
//  TemplateMethod
//
//  Created by Carlo Chung on 7/31/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "Hamburger.h"


@implementation Hamburger

- (void)prepareBread {
  [self getBurgerBun];
}

- (void)addMeat {
  [self addBeefPatty];
}

- (void)addCondiments {
  [self addKetchup];
  [self addMustard];
  [self addCheese];
  [self addPickles];
}

#pragma mark - Hamburger Specific Methods

- (void)getBurgerBun {
    NSLog(@"getBurgerBun");
}

- (void)addKetchup {
    NSLog(@"addKetchup");
}

- (void)addMustard {
    NSLog(@"addMustard");
}

- (void)addBeefPatty {
    NSLog(@"addBeefPatty");
}

- (void)addCheese {
    NSLog(@"addBeefPatty");
}

- (void)addPickles {
    NSLog(@"addPickles");
}

@end
