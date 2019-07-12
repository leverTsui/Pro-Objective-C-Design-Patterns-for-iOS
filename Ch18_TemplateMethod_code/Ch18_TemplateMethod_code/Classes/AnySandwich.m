//
//  AbstractSandwich.m
//  TemplateMethod
//
//  Created by Carlo Chung on 7/31/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "AnySandwich.h"

@implementation AnySandwich

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"\n");
        NSLog(@"%@ :",[self class]);
    }
    return self;
}

- (void)make {
  [self prepareBread];
  [self putBreadOnPlate];
  [self addMeat];
  [self addCondiments];
  [self extraStep];
  [self serve];
}

- (void)putBreadOnPlate {
    NSLog(@"putBreadOnPlate");
    // We need first to put bread on a plate for any sandwich.
}

- (void)serve {
    NSLog(@"serve");
  // Any sandwich will be served eventually.
}

#pragma mark - Details will be handled by subclasses

- (void)prepareBread {
    NSLog(@"prepareBread");
}

- (void)addMeat {
    NSLog(@"addMeat");
}

- (void)addCondiments {
    NSLog(@"addCondiments");
}

- (void)extraStep{
    NSLog(@"extraStep");
}

@end
