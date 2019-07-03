//
//  OpenScribbleCommand.h
//  TouchPainter
//
//  Created by Carlo Chung on 11/9/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#import "ScribbleSource.h"

@interface OpenScribbleCommand : Command

@property (nonatomic, strong) id <ScribbleSource> scribbleSource;

- (id)initWithScribbleSource:(id <ScribbleSource>) aScribbleSource;

- (void)execute;

@end
