//
//  ScribbleMemento+Private.h
//  TouchPainter
//
//  Created by Carlo Chung on 9/27/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import"ScribbleMemento.h"

@interface ScribbleMemento ()

- (id)initWithMark:(id <Mark>)aMark;

@property (nonatomic, strong) id <Mark> mark;

@property (nonatomic, assign) BOOL hasCompleteSnapshot;

@end
