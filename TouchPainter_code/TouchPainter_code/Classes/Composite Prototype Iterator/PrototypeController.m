//
//  PrototypeController.m
//  TouchPainter
//
//  Created by Carlo Chung on 11/20/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "PrototypeController.h"
#import "Mark.h"
#import "CanvasView.h"

@implementation PrototypeController
- (void)viewDidLoad  {
  [super viewDidLoad];
  
  // The following code snippets are
  // for illustration purposes in 
  // the book only and not part of the
  // app
  id <Mark> selectedMark;
  NSMutableArray *templateArray = [[NSMutableArray alloc] initWithCapacity:1];
  id <Mark> patternTemplate = [selectedMark copy];
  
  // save the patternTemplate in
  // a data structure so it can be
  // used later
  [templateArray addObject:patternTemplate];
  
  CanvasView *canvasView;
  id <Mark> currentMark;
  int patternIndex = 0;
  
  id <Mark> patternClone = [templateArray objectAtIndex:patternIndex];
  [currentMark addMark:patternClone];
  [canvasView setMark:currentMark];
  [canvasView setNeedsDisplay];
}

@end
