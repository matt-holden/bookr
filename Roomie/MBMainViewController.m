//
//  MBMainViewController.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//


#import "MBMainViewController.h"
#import "MBRoomService.h"
#import "MSCollectionViewCalendarLayout.h"
#import "MSCurrentTimeGridline.h"
#import "MSCurrentTimeIndicator.h"
#import "MSDayColumnHeader.h"
#import "MSDayColumnHeaderBackground.h"
#import "MSEvent.h"
#import "MSEventCell.h"
#import "MSGridline.h"
#import "MSTimeRowHeader.h"
#import "MSTimeRowHeaderBackground.h"
#import <MSCollectionViewCalendarLayout/MSCollectionViewCalendarLayout.h>

NSString * const MSEventCellReuseIdentifier = @"MSEventCellReuseIdentifier";
NSString * const MSDayColumnHeaderReuseIdentifier = @"MSDayColumnHeaderReuseIdentifier";
NSString * const MSTimeRowHeaderReuseIdentifier = @"MSTimeRowHeaderReuseIdentifier";

@interface MBMainViewController () <MSCollectionViewDelegateCalendarLayout>
@property (nonatomic) MBRoomService *roomService;
@property (nonatomic) MBRoomDaySchedule *representedSchedule;
@property (nonatomic) MSCollectionViewCalendarLayout *collectionViewLayout;
@end

@implementation MBMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRoomService:[[MBRoomService alloc] init]];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:MSEventCell.class forCellWithReuseIdentifier:MSEventCellReuseIdentifier];
    [self.collectionView registerClass:MSDayColumnHeader.class forSupplementaryViewOfKind:MSCollectionElementKindDayColumnHeader withReuseIdentifier:MSDayColumnHeaderReuseIdentifier];
    [self.collectionView registerClass:MSTimeRowHeader.class forSupplementaryViewOfKind:MSCollectionElementKindTimeRowHeader withReuseIdentifier:MSTimeRowHeaderReuseIdentifier];
    
    self.collectionViewLayout = [[MSCollectionViewCalendarLayout alloc] init];
    [self.collectionView setCollectionViewLayout:self.collectionViewLayout];
    
    // These are optional—if you don't want any of the decoration views, just don't register a class for it
    [self.collectionViewLayout registerClass:MSCurrentTimeIndicator.class forDecorationViewOfKind:MSCollectionElementKindCurrentTimeIndicator];
    [self.collectionViewLayout registerClass:MSCurrentTimeGridline.class forDecorationViewOfKind:MSCollectionElementKindCurrentTimeHorizontalGridline];
    [self.collectionViewLayout registerClass:MSGridline.class forDecorationViewOfKind:MSCollectionElementKindHorizontalGridline];
    [self.collectionViewLayout registerClass:MSTimeRowHeaderBackground.class forDecorationViewOfKind:MSCollectionElementKindTimeRowHeaderBackground];
    [self.collectionViewLayout registerClass:MSDayColumnHeaderBackground.class forDecorationViewOfKind:MSCollectionElementKindDayColumnHeaderBackground];
    
    
    
    
    [self.roomService loadScheduleForDay:[NSDate date]
                                    room:[[MBRoom alloc] init]
                                    done:^(NSError *err, MBRoomDaySchedule *schedule) {
                                        [self setRepresentedSchedule:schedule];
                                        [self.collectionViewLayout invalidateLayoutCache];
                                        [self.collectionView reloadData];
                                    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionViewLayout scrollCollectionViewToClosetSectionToCurrentTimeAnimated:NO];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([[self.representedSchedule bookings] count])
        return 1; //self.representedSchedule.count
    else return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([[self.representedSchedule bookings] count])
        return [self.representedSchedule.bookings count];
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MSEventCellReuseIdentifier forIndexPath:indexPath];
    MBRoomBooking *booking = self.representedSchedule.bookings[indexPath.row];
    MSEvent *eventWrapper = [[MSEvent alloc] init];
    
    [eventWrapper setStart:[booking startTime]];
    [eventWrapper setEnd:[booking endTime]];
    [eventWrapper setTitle:@"Reserved"];
    [eventWrapper setLocation:@"Hatha"];
    [eventWrapper setTimeToBeDecided:0];
    [eventWrapper setDateToBeDecided:0];
    
    cell.event = eventWrapper;// [self.fetchedResultsController objectAtIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view;
    if ([kind isEqualToString:MSCollectionElementKindDayColumnHeader]) {
        MSDayColumnHeader *dayColumnHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MSDayColumnHeaderReuseIdentifier forIndexPath:indexPath];
        dayColumnHeader.day = [self.collectionViewLayout dateForDayColumnHeaderAtIndexPath:indexPath];
        view = dayColumnHeader;
    }
    else if ([kind isEqualToString:MSCollectionElementKindTimeRowHeader]) {
        MSTimeRowHeader *timeRowHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MSTimeRowHeaderReuseIdentifier forIndexPath:indexPath];
        timeRowHeader.time = [self.collectionViewLayout dateForTimeRowHeaderAtIndexPath:indexPath];
        view = timeRowHeader;
    }
    return view;
}

#pragma mark - MSCollectionViewCalendarLayout

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewLayout dayForSection:(NSInteger)section
{
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
//    MSEvent *event = sectionInfo.objects[0];
//    return [event day];
    return [NSDate date];
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewLayout startTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    MSEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return [NSDate date];
//    return nil;
//    return event.start;
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewLayout endTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    MSEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    // Sports usually last about 3 hours, and SeatGeek doesn't provide an end time
    return [[NSDate date] dateByAddingTimeInterval:(60*60*2)];
    //    return [event.start dateByAddingTimeInterval:(60 * 60 * 3)];
}

- (NSDate *)currentTimeComponentsForCollectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewLayout
{
    return [NSDate date];
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

@end
