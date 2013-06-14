//
//  MBMainViewController.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBMainViewController.h"
#import <MSCollectionViewCalendarLayout/MSCollectionViewCalendarLayout.h>
#import "MBRoomAPIService.h"

@interface MBMainViewController () <MSCollectionViewDelegateCalendarLayout>
@property (nonatomic) MBRoomAPIService *roomAPIService;
@end

@implementation MBMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setRoomAPIService:[[MBRoomAPIService alloc] init]];
    
    [self.collectionView setCollectionViewLayout:[[MSCollectionViewCalendarLayout alloc] init]];
    
    [self.collectionView setDataSource:self.roomAPIService.collectionViewDataSource];
    
//    [self.collectionView registerClass:MSEventCell.class forCellWithReuseIdentifier:MSEventCellReuseIdentifier];
//    [self.collectionView registerClass:MSDayColumnHeader.class forSupplementaryViewOfKind:MSCollectionElementKindDayColumnHeader withReuseIdentifier:MSDayColumnHeaderReuseIdentifier];
//    [self.collectionView registerClass:MSTimeRowHeader.class forSupplementaryViewOfKind:MSCollectionElementKindTimeRowHeader withReuseIdentifier:MSTimeRowHeaderReuseIdentifier];
//    
//    // These are optional—if you don't want any of the decoration views, just don't register a class for it
//    [self.collectionView.collectionViewLayout registerClass:MSCurrentTimeIndicator.class forDecorationViewOfKind:MSCollectionElementKindCurrentTimeIndicator];
//    [self.collectionView.collectionViewLayout registerClass:MSCurrentTimeGridline.class forDecorationViewOfKind:MSCollectionElementKindCurrentTimeHorizontalGridline];
//    [self.collectionView.collectionViewLayout registerClass:MSGridline.class forDecorationViewOfKind:MSCollectionElementKindHorizontalGridline];
//    [self.collectionView.collectionViewLayout registerClass:MSTimeRowHeaderBackground.class forDecorationViewOfKind:MSCollectionElementKindTimeRowHeaderBackground];
//    [self.collectionView.collectionViewLayout registerClass:MSDayColumnHeaderBackground.class forDecorationViewOfKind:MSCollectionElementKindDayColumnHeaderBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(MBFlipsideViewController *)controller
{
    [self.flipsidePopoverController dismissPopoverAnimated:YES];
    self.flipsidePopoverController = nil;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        self.flipsidePopoverController = popoverController;
        popoverController.delegate = self;
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}
#pragma mark - MSCollectionViewCalendarLayout

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewLayout dayForSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    MSEvent *event = sectionInfo.objects[0];
    return [event day];
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewLayout startTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return event.start;
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewLayout endTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Sports usually last about 3 hours, and SeatGeek doesn't provide an end time
    return [event.start dateByAddingTimeInterval:(60 * 60 * 3)];
}

- (NSDate *)currentTimeComponentsForCollectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewLayout
{
    return [NSDate date];
}

@end
