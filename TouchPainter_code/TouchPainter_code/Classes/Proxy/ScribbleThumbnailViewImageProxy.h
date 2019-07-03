//
//  ScribbleThumbnailProxy.h
//  TouchPainter
//
//  Created by Carlo Chung on 10/3/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "Command.h"
#import "Scribble.h"
#import "ScribbleSource.h"

@interface ScribbleThumbnailViewImageProxy : UIView <ScribbleSource>

@property (nonatomic, retain) Command *touchCommand;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) Scribble *scribble;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *scribblePath;

@end
