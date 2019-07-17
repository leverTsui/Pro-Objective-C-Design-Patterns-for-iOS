//
//  ExtrinsicFlower.h
//  Ch21_Flyweight_code
//
//  Created by 徐利华 on 2019/7/17.
//  Copyright © 2019 徐利华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExtrinsicFlower : NSObject

@property (nonatomic, strong) UIView *flowerView;

@property (nonatomic, assign) CGRect area;

@end

NS_ASSUME_NONNULL_END
