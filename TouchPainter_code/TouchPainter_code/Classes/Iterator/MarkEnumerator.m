//
//  MarkEnumerator.m
//  TouchPainter
//
//  Created by Carlo Chung on 1/6/11.
//  Copyright 2011 Carlo Chung. All rights reserved.
//

#import "MarkEnumerator.h"
#import "MarkEnumerator+Internal.h"

@interface MarkEnumerator ()

@property (nonatomic, strong) NSMutableArray *stack;

@end

@implementation MarkEnumerator

- (NSArray *)allObjects
{
  // returns an array of yet-visited Mark nodes
  // i.e. the remaining elements in the stack
  return [[self.stack reverseObjectEnumerator] allObjects];
}

- (id)nextObject
{
  return [self.stack pop];
} 

#pragma mark -
#pragma mark Private Methods

- (id) initWithMark:(id <Mark>)aMark
{
  if (self = [super init])
  {
    self.stack = [[NSMutableArray alloc] initWithCapacity:[aMark count]];
    
    // post-orderly traverse the whole Mark aggregate
    // and add individual Marks in a private stack
    [self traverseAndBuildStackWithMark:aMark];
  }
  
  return self;
}

- (void) traverseAndBuildStackWithMark:(id <Mark>)mark
{
  // push post-order traversal
  // into the stack
  if (mark == nil) return;
  
  [self.stack push:mark];
  
  NSUInteger index = [mark count];
  id <Mark> childMark;
  while (childMark = [mark childMarkAtIndex:--index]) 
  {
    [self traverseAndBuildStackWithMark:childMark];
  }
}

@end
