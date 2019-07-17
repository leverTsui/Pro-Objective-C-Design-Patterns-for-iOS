//
//  FlowerFactory.h
//  Flyweight
//
//  Created by Carlo Chung on 11/29/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FlowerType) {
  kAnemone,
  kCosmos,
  kGerberas,
  kHollyhock,
  kJasmine,
  kZinnia,
  kTotalNumberOfFlowerTypes
};

@interface FlowerFactory : NSObject

- (UIView *)flowerViewWithType:(FlowerType)type;

@end
