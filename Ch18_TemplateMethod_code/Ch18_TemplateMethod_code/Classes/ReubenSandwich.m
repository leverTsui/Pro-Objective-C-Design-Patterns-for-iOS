//
//  ReubenSandwich.m
//  TemplateMethod
//
//  Created by Carlo Chung on 7/31/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "ReubenSandwich.h"

@implementation ReubenSandwich

- (void)prepareBread {
  [self cutRyeBread];
}

- (void)addMeat {
  [self addCornBeef];
}

- (void)addCondiments {
  [self addSauerkraut];
  [self addThousandIslandDressing];
  [self addSwissCheese];
}

- (void)extraStep {
  [self grillIt];
}

#pragma mark - ReubenSandwich Specific Methods

- (void)cutRyeBread {
    NSLog(@"cutRyeBread");
}

- (void)addCornBeef {
    NSLog(@"addCornBeef");
}

- (void)addSauerkraut {
    NSLog(@"addSauerkraut");
}

- (void)addThousandIslandDressing {
    NSLog(@"addThousandIslandDressing");
}

- (void)addSwissCheese {
    NSLog(@"addSwissCheese");
}

- (void)grillIt {
    NSLog(@"grillIt");
}

@end
