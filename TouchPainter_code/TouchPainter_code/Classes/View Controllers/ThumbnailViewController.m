//
//  ScribblesViewController.m
//  TouchPainter
//
//  Created by Carlo Chung on 10/18/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "ThumbnailViewController.h"
#import "ScribbleThumbnailCell.h"
#import "ScribbleManager.h"
#import "CommandBarButton.h"

@interface ThumbnailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UINavigationItem *navItem;

@property (nonatomic, strong) ScribbleManager *scribbleManager;

@end

@implementation ThumbnailViewController

- (void)viewDidLoad  {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_texture"]];
    
    self.scribbleManager = [[ScribbleManager alloc] init];
 
    NSInteger numberOfScribbles = [self.scribbleManager numberOfScribbles];
    [self.navItem setTitle:[NSString stringWithFormat:numberOfScribbles > 1 ? @"%ld items" : @"%ld item", numberOfScribbles]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
  CGFloat numberOfPlaceholders = [ScribbleThumbnailCell numberOfPlaceHolders];
  NSInteger numberOfScribbles = [self.scribbleManager numberOfScribbles];
  NSInteger numberOfRows = ceil(numberOfScribbles / numberOfPlaceholders);
  return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  ScribbleThumbnailCell *cell = (ScribbleThumbnailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil)  {
    cell = [[ScribbleThumbnailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
   
  NSInteger numberOfSupportedThumbnails = [ScribbleThumbnailCell numberOfPlaceHolders];
    
  NSInteger thumbnailIndex = indexPath.row *numberOfSupportedThumbnails;
  NSInteger numberOfScribbles = [self.scribbleManager numberOfScribbles];
    
  for (NSInteger i = 0; i < numberOfSupportedThumbnails && 
       (thumbnailIndex + i) < numberOfScribbles; ++i) {
    UIView *scribbleThumbnail = [self.scribbleManager scribbleThumbnailViewAtIndex:
                                            thumbnailIndex + i];
    [cell addThumbnailView:scribbleThumbnail atIndex:i];
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 150;
}

#pragma mark - event response
- (IBAction)requestViewChangeByObject:(id)object {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
