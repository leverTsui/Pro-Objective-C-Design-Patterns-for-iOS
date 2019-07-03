//
//  CanvasView.h
//  TouchPainter
//
//  Created by Carlo Chung on 9/14/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Mark;

@interface CanvasView : UIView  

@property (nonatomic, strong) id <Mark> mark;

@end
