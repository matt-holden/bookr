//
//  MBMainViewController.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//


#import "MBMainViewController.h"
#import "MBRoomService.h"
#import "MBRoomBooking+MAEvent.h"
#import "MBRoomDaySchedule+MAEvents.h"

@interface MBMainViewController ()
@property (nonatomic) MBRoomService *roomService;
@property (nonatomic) MBRoomDaySchedule *representedSchedule;
@end

@implementation MBMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRoomService:[[MBRoomService alloc] init]];
    
    [self.dayView setDataSource:self];
    [self.dayView setDelegate:self];
    [self.dayView setLabelFontSize:24];
    [self.dayView setAutoScrollToFirstEvent:YES];
    [self.roomService loadScheduleForDay:[NSDate date]
                                    room:[[MBRoom alloc] init]
                                    done:^(NSError *err, MBRoomDaySchedule *schedule) {
                                        [self setRepresentedSchedule:schedule];
                                        [_navItem setTitle:[schedule.room roomName]];
                                        [self.dayView reloadData];
                                    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark MADayViewDelegate
- (void)dayView:(MADayView *)dayView eventTapped:(MAEvent *)event
{
    
}

#pragma mark MADayViewDataSource
- (NSArray *)dayView:(MADayView *)dayView eventsForDate:(NSDate *)startDate {
    NSSet *events = [self.representedSchedule MAEvents];
    return [events allObjects];
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
