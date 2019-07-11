//
//  Entity.h
//  ChainOfResponsibility
//
//  Created by Carlo Chung on 11/28/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attack.h"

@interface AttackHandler : NSObject  

@property (nonatomic, strong) AttackHandler *nextAttackHandler;

- (void)handleAttack:(Attack *)attack;

@end
