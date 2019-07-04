//
//  CanvasViewController.m
//  Composite
//
//  Created by Carlo Chung on 9/11/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "CanvasViewController.h"
#import "Dot.h"
#import "Stroke.h"
#import "CoordinatingController.h"

@interface CanvasViewController ()

@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation CanvasViewController

#pragma mark - life cycle

- (void)viewDidLoad  {
    [super viewDidLoad];

    // Get a default canvas view
    // with the factory method of
    // the CanvasViewGenerator
    CanvasViewGenerator *defaultGenerator = [[CanvasViewGenerator alloc] init];
    [self loadCanvasViewWithGenerator:defaultGenerator];

    // initialize a Scribble model
    self.scribble = [[Scribble alloc] init];

    // setup default stroke color and size
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat redValue = [userDefaults floatForKey:@"red"];
    CGFloat greenValue = [userDefaults floatForKey:@"green"];
    CGFloat blueValue = [userDefaults floatForKey:@"blue"];
    CGFloat sizeValue = [userDefaults floatForKey:@"size"];
  
    self.strokeSize = sizeValue;
    self.strokeColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
}

#pragma mark - event response

- (IBAction)onBarButtonHit:(id)button {
    UIBarButtonItem *barButton = button;

    if ([barButton tag] == 4) {
    [self.undoManager undo];
    } else if ([barButton tag] == 5) {
    [self.undoManager redo];
    }
}

- (IBAction)onCustomBarButtonHit:(CommandBarButton *)barButton {
    [[barButton command] execute];
}

#pragma mark - Loading a CanvasView from a CanvasViewGenerator

- (void)loadCanvasViewWithGenerator:(CanvasViewGenerator *)generator {
  [self.canvasView removeFromSuperview];
  CGRect aFrame = CGRectMake(0, 0, 320, 436);
  CanvasView *aCanvasView = [generator canvasViewWithFrame:aFrame];
  [self setCanvasView:aCanvasView];
  NSInteger viewIndex = [[[self view] subviews] count] - 1;
  [[self view] insertSubview:self.canvasView atIndex:viewIndex];
}

#pragma mark - Touch Event Handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  self.startPoint = [[touches anyObject] locationInView:self.canvasView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint lastPoint = [[touches anyObject] previousLocationInView:self.canvasView];
  
  // add a new stroke to scribble
  // if this is indeed a drag from
  // a finger
  if (CGPointEqualToPoint(lastPoint, self.startPoint)) {
    id <Mark> newStroke = [[Stroke alloc] init];
    [newStroke setColor:self.strokeColor];
    [newStroke setSize:self.strokeSize];
    
    //[self.scribble addMark:newStroke shouldAddToPreviousMark:NO];
    
    // retrieve a new NSInvocation for drawing and
    // set new arguments for the draw command
    NSInvocation *drawInvocation = [self drawScribbleInvocation];
    [drawInvocation setArgument:&newStroke atIndex:2];
    
    // retrieve a new NSInvocation for undrawing and
    // set a new argument for the undraw command
    NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
    [undrawInvocation setArgument:&newStroke atIndex:2];
    
    // execute the draw command with the undraw command
    [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
  }
  
  // add the current touch as another vertex to the
  // temp stroke
  CGPoint thisPoint = [[touches anyObject] locationInView:self.canvasView];
  Vertex *vertex = [[Vertex alloc] initWithLocation:thisPoint];
  
  // we don't need to undo every vertex
  // so we are keeping this
  [self.scribble addMark:vertex shouldAddToPreviousMark:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint lastPoint = [[touches anyObject] previousLocationInView:self.canvasView];
  CGPoint thisPoint = [[touches anyObject] locationInView:self.canvasView];
  
  // if the touch never moves (stays at the same spot until lifted now)
  // just add a dot to an existing stroke composite
  // otherwise add it to the temp stroke as the last vertex
  if (CGPointEqualToPoint(lastPoint, thisPoint)) {
    Dot *singleDot = [[Dot alloc] initWithLocation:thisPoint];
    [singleDot setColor:self.strokeColor];
    [singleDot setSize:self.strokeSize];
    
    //[self.scribble addMark:singleDot shouldAddToPreviousMark:NO];
    
    // retrieve a new NSInvocation for drawing and
    // set new arguments for the draw command
    NSInvocation *drawInvocation = [self drawScribbleInvocation];
    [drawInvocation setArgument:&singleDot atIndex:2];
    
    // retrieve a new NSInvocation for undrawing and
    // set a new argument for the undraw command
    NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
    [undrawInvocation setArgument:&singleDot atIndex:2];
    
    // execute the draw command with the undraw command
    [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
  }
   
  // reset the start point here
  self.startPoint = CGPointZero;
  
  // if this is the last point of stroke
  // don't bother to draw it as the user
  // won't tell the difference
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  // reset the start point here
  self.startPoint = CGPointZero;
}

#pragma mark - Scribble observer method

- (void)observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object 
                         change:(NSDictionary *)change 
                        context:(void *)context {
  if ([object isKindOfClass:[Scribble class]] && 
      [keyPath isEqualToString:@"parentMark"])
  {
    id <Mark> mark = [change objectForKey:NSKeyValueChangeNewKey];
    [self.canvasView setMark:mark];
    [self.canvasView setNeedsDisplay];
  }
}

#pragma mark -  Draw Scribble Invocation Generation Methods

- (NSInvocation *)drawScribbleInvocation  {
  NSMethodSignature *executeMethodSignature = [self.scribble methodSignatureForSelector:@selector(addMark:shouldAddToPreviousMark:)];
  NSInvocation *drawInvocation = [NSInvocation invocationWithMethodSignature:executeMethodSignature];
  [drawInvocation setTarget:self.scribble];
  [drawInvocation setSelector:@selector(addMark:shouldAddToPreviousMark:)];
  BOOL attachToPreviousMark = NO;
  [drawInvocation setArgument:&attachToPreviousMark atIndex:3];
  
  return drawInvocation;
}

- (NSInvocation *)undrawScribbleInvocation {
  NSMethodSignature *unexecuteMethodSignature = [self.scribble
                                                 methodSignatureForSelector:
                                                 @selector(removeMark:)];
  NSInvocation *undrawInvocation = [NSInvocation 
                                    invocationWithMethodSignature:
                                    unexecuteMethodSignature];
  [undrawInvocation setTarget:self.scribble];
  [undrawInvocation setSelector:@selector(removeMark:)];
  
  return undrawInvocation;
}

#pragma mark - Draw Scribble Command Methods

- (void)executeInvocation:(NSInvocation *)invocation
        withUndoInvocation:(NSInvocation *)undoInvocation {
  [invocation retainArguments]; 
  [[self.undoManager prepareWithInvocationTarget:self] unexecuteInvocation:undoInvocation withRedoInvocation:invocation];
  [invocation invoke];
}

- (void)unexecuteInvocation:(NSInvocation *)invocation
          withRedoInvocation:(NSInvocation *)redoInvocation {  
  [[self.undoManager prepareWithInvocationTarget:self] executeInvocation:redoInvocation withUndoInvocation:invocation];
  [invocation invoke];
}

- (IBAction)requestViewChangeByObject:(id)object {
    switch ([(UIBarButtonItem *)object tag])
    {
            case kButtonTagOpenPaletteView:
        {
            // load a PaletteViewController
            
           
            
            PaletteViewController *controller =  [[PaletteViewController alloc] initWithNibName:@"PaletteViewController" bundle:[NSBundle mainBundle]];
            
            [self.navigationController presentViewController:controller animated:YES completion:NULL];
        }
            break;
            case kButtonTagOpenThumbnailView:
        {
            // load a ThumbnailViewController
            ThumbnailViewController *controller = [[NSBundle mainBundle] loadNibNamed:@"ThumbnailViewController" owner:self options:nil].firstObject;
            [self.navigationController presentViewController:controller animated:YES completion:NULL];
        }
            break;
            default:
            break;
    }
    
}

#pragma mark - getter & setter

// hook up everything with a new Scribble instance
- (void)setScribble:(Scribble *)aScribble {
    if (_scribble != aScribble) {
        _scribble = aScribble;
        [_scribble addObserver:self
                    forKeyPath:@"parentMark"
                       options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                       context:nil];
    }
}

- (void)setStrokeSize:(CGFloat)aSize {
    // enforce the smallest size
    // allowed
    if (aSize < 5.0)  {
        _strokeSize = 5.0;
    } else {
        _strokeSize = aSize;
    }
}

@end
