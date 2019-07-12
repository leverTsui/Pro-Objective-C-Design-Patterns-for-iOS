//
//  AbstractSandwich.h
//  TemplateMethod
//
//  Created by Carlo Chung on 7/31/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnySandwich : NSObject  

- (void)make;

// 制作三明治的基本步骤

//1、准备面包
- (void)prepareBread;

//2、把面包放在盘子上
- (void)putBreadOnPlate;

//3、往面包上加肉
- (void)addMeat;

//4、加调味料
- (void)addCondiments;

//5、额外操作
- (void)extraStep;

//6、上餐
- (void)serve;

@end
