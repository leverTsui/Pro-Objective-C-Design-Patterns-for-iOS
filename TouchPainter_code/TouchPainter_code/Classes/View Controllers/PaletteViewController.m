//
//  PaletteViewController.m
//  TouchPainter
//
//  Created by Carlo Chung on 10/18/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "PaletteViewController.h"
#import "CoordinatingController.h"

@interface PaletteViewController ()<SetStrokeColorCommandDelegate,SetStrokeSizeCommandDelegate>

@property (nonatomic, weak) IBOutlet CommandSlider *redSlider;

@property (nonatomic, weak) IBOutlet CommandSlider *greenSlider;

@property (nonatomic, weak) IBOutlet CommandSlider *blueSlider;

@property (nonatomic, weak) IBOutlet CommandSlider *sizeSlider;

@property (nonatomic, weak) IBOutlet UIView *paletteView;

@end

@implementation PaletteViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
 
    SetStrokeColorCommand *colorCommand = [[SetStrokeColorCommand alloc] init];
    colorCommand.delegate = self;
    __weak typeof(self) weakSelf = self;
    colorCommand.RGBValuesProvider = ^(CGFloat *red, CGFloat *green, CGFloat *blue) {
         __strong typeof (weakSelf) strongSelf = weakSelf;
        *red = [strongSelf.redSlider value];
        *green = [strongSelf.greenSlider value];
        *blue = [strongSelf.blueSlider value];
    };
 
    colorCommand.postColorUpdateProvider = ^(UIColor *color) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        strongSelf.paletteView.backgroundColor = color;
    };
    
    
    self.redSlider.command = colorCommand;
    self.greenSlider.command = colorCommand;
    self.blueSlider.command = colorCommand;

    SetStrokeSizeCommand *sizeCommand = [[SetStrokeSizeCommand alloc] init];
    sizeCommand.delegate = self;
    self.sizeSlider.command = sizeCommand;

    // restore the original values of the sliders
    // and the color of the small palette view
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat redValue = [userDefaults floatForKey:@"red"];
    CGFloat greenValue = [userDefaults floatForKey:@"green"];
    CGFloat blueValue = [userDefaults floatForKey:@"blue"];
    CGFloat sizeValue = [userDefaults floatForKey:@"size"];

    [self.redSlider setValue:redValue];
    [self.greenSlider setValue:greenValue];
    [self.blueSlider setValue:blueValue];
    [self.sizeSlider setValue:sizeValue];

    UIColor *color = [UIColor colorWithRed:redValue
                                   green:greenValue
                                    blue:blueValue
                                   alpha:1.0];

    [self.paletteView setBackgroundColor:color];
}

- (void)viewDidDisappear:(BOOL)animated {
    // save the values of the sliders
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:[self.redSlider value] forKey:@"red"];
    [userDefaults setFloat:[self.greenSlider value] forKey:@"green"];
    [userDefaults setFloat:[self.blueSlider value] forKey:@"blue"];
    [userDefaults setFloat:[self.sizeSlider value] forKey:@"size"];
    [userDefaults synchronize];
}

#pragma mark -
#pragma mark SetStrokeColorCommandDelegate methods

- (void)command:(SetStrokeColorCommand *) command
                didRequestColorComponentsForRed:(CGFloat *) red
                                          green:(CGFloat *) green 
                                           blue:(CGFloat *) blue {
  *red = [self.redSlider value];
  *green = [self.greenSlider value];
  *blue = [self.blueSlider value];
}

- (void) command:(SetStrokeColorCommand *) command
                didFinishColorUpdateWithColor:(UIColor *) color {
  [self.paletteView setBackgroundColor:color];
}

#pragma mark SetStrokeSizeCommandDelegate method

- (void) command:(SetStrokeSizeCommand *)command 
                didRequestForStrokeSize:(CGFloat *)size {
  *size = [self.sizeSlider value];
}

#pragma mark -
#pragma mark Slider event handler

- (IBAction)onCommandSliderValueChanged:(CommandSlider *)slider {
  [[slider command] execute];
}

- (IBAction)requestViewChangeByObject:(id)object {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
