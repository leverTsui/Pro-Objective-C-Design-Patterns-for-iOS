//
//  FlyweightView.m
//  Flyweight
//
//  Created by Carlo Chung on 11/29/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "FlyweightView.h"
#import "ExtrinsicFlower.h"

@implementation FlyweightView 

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code
  
  for (ExtrinsicFlower *stateValue in self.flowerList) {
    UIView *flowerView = stateValue.flowerView;
    CGRect area = stateValue.area;
    
    [flowerView drawRect:area];
  }
}  

@end
