//
//  Stroke.m
//  Composite
//
//  Created by Carlo Chung on 9/9/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "Stroke.h"
#import "MarkEnumerator+Internal.h"

@interface Stroke ()

@property (nonatomic, strong) NSMutableArray *children;

@end

@implementation Stroke

- (id) init {
  if (self = [super init])
  {
    self.children = [[NSMutableArray alloc] initWithCapacity:5];
  }
  
  return self;
}

- (CGPoint)location {
  // return the location of the first child
  if ([self.children count] > 0) {
      id <Mark> mark = [self.children objectAtIndex:0];
      return [mark location];
  }
  
  // otherwise returns the origin
  return CGPointZero;
}

- (void)addMark:(id <Mark>)mark {
  [self.children addObject:mark];
}

- (void)removeMark:(id <Mark>)mark {
  // if mark is at this level then
  // remove it and return
  // otherwise, let every child
  // search for it
  if ([self.children containsObject:mark]) {
    [self.children removeObject:mark];
  } else  {
    [self.children makeObjectsPerformSelector:@selector(removeMark:)
                               withObject:mark];
  }
}

- (id <Mark>)childMarkAtIndex:(NSUInteger)index {
  if (index >= [self.children count]) return nil;
  
  return [self.children objectAtIndex:index];
}

// a convenience method to return the last child
- (id <Mark>)lastChild {
  return [self.children lastObject];
}

// returns number of children
- (NSUInteger)count {
  return [self.children count];
}

- (void)acceptMarkVisitor:(id <MarkVisitor>)visitor {
  for (id <Mark> dot in self.children) {
    [dot acceptMarkVisitor:visitor];
  }
  
  [visitor visitStroke:self];
}

#pragma mark -
#pragma mark NSCopying method

- (id)copyWithZone:(NSZone *)zone {
  Stroke *strokeCopy = [[[self class] allocWithZone:zone] init];
  
  // copy the color
  [strokeCopy setColor:[UIColor colorWithCGColor:[self.color CGColor]]];
  
  // copy the size
  [strokeCopy setSize:self.size];
  
  // copy the children
  for (id <Mark> child in self.children)
  {
    id <Mark> childCopy = [child copy];
    [strokeCopy addMark:childCopy];
  }
  
  return strokeCopy;
}

#pragma mark -
#pragma mark NSCoder methods

- (id)initWithCoder:(NSCoder *)coder {
  if (self = [super init])
  {
    self.color = [coder decodeObjectForKey:@"StrokeColor"];
    self.size = [coder decodeFloatForKey:@"StrokeSize"];
    self.children = [coder decodeObjectForKey:@"StrokeChildren"];
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:self.color forKey:@"StrokeColor"];
  [coder encodeFloat:self.size forKey:@"StrokeSize"];
  [coder encodeObject:self.children forKey:@"StrokeChildren"];
}

#pragma mark - enumerator methods

- (NSEnumerator *) enumerator {
  return [[MarkEnumerator alloc] initWithMark:self];
}

- (void)enumerateMarksUsingBlock:(void (^)(id <Mark> item, BOOL *stop))block {
  BOOL stop = NO;
  
  NSEnumerator *enumerator = [self enumerator];
  
  for (id <Mark> mark in enumerator) {
    block (mark, &stop);
    if (stop)
      break;
  }
}

#pragma mark -
#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void)drawWithContext:(CGContextRef)context {
  CGContextMoveToPoint(context, self.location.x, self.location.y);
  
  for (id <Mark> mark in self.children) {
    [mark drawWithContext:context];
  }
  
  CGContextSetLineWidth(context, self.size);
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetStrokeColorWithColor(context,[self.color CGColor]);
  CGContextStrokePath(context);
}

@end
