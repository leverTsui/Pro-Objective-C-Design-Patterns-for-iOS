//
//  VirtualController.h
//  Bridge
//
//  Created by Carlo Chung on 11/26/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsoleEmulator.h"
#import "ConsoleCommands.h"

@interface ConsoleController : NSObject

@property (nonatomic, strong) ConsoleEmulator *emulator;

- (void)setCommand:(ConsoleCommand)command;

// other behaviors and properties

@end
