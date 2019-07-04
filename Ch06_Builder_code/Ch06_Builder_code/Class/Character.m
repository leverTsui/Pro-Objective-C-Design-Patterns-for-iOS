//
//  Character.m
//  Builder
//
//  Created by Carlo Chung on 11/27/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "Character.h"


@implementation Character

- (id)init {
  if (self = [super init]) {
    self.protection = 1.0;
    self.power = 1.0;
    self.strength = 1.0;
    self.stamina = 1.0;
    self.intelligence = 1.0;
    self.agility = 1.0;
    self.aggressiveness = 1.0;
  } 
  return self;
}

@end
