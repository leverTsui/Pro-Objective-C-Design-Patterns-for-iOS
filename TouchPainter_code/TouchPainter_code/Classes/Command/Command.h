//
//  Command.h
//  TouchPainter
//
//  Created by Carlo Chung on 10/19/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject 

@property (nonatomic, strong) NSDictionary *userInfo;

- (void)execute;

- (void)undo;

@end
