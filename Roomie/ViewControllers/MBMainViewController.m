//
//  MBMainViewController.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//


#import "MBMainViewController.h"
#import "MBNowViewController.h"
#import "MBRoomService.h"
#import "MBRoomBooking+MAEvent.h"
#import "MBRoomDaySchedule+MAEvents.h"
#import <QuartzCore/QuartzCore.h>

@interface MBMainViewController ()
@property (nonatomic) MBRoomService *roomService;
@property (nonatomic) MBRoomDaySchedule *representedSchedule;
@end

@implementation MBMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.nowViewControllerContainerView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.nowViewControllerContainerView.layer setShadowOffset:CGSizeMake(0, 3)];
    [self.nowViewControllerContainerView.layer setShadowOpacity:1];
    [self.nowViewControllerContainerView.layer setShadowRadius:4];
    
    [self.nowViewController parentViewControllerDidStartLoadingSchedule:self];
    [self setRoomService:[[MBRoomService alloc] init]];
    
    [self.dayView setDelegate:self];
    [self.dayView setLabelFontSize:24];
    [self.dayView setAutoScrollToFirstEvent:YES];
    [self.dayView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark MBDayViewDelegate
- (void)dayView:(MBDayView *)dayView didRequestScheduleForDate:(NSDate*)date
{
    [self.roomService loadScheduleForDay:date
                                    room:[[MBRoom alloc] init]
                                    done:^(NSError *err, MBRoomDaySchedule *schedule) {
                                        [self setRepresentedSchedule:schedule];
                                        [self.dayView setSchedule:schedule
                                                        forDate:date];
                                        
                                        if (self.nowViewController) {
                                            [self.nowViewController parentViewController:self
                                                                         didLoadSchedule:schedule];
                                        }
                                    }];
}

- (void)dayView:(MADayView *)dayView eventTapped:(MAEvent *)event
{
    
}

#pragma mark MADayViewDataSource

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
    } else if ([[segue identifier] isEqualToString:@"NowEmbedSegue"]) {
        MBNowViewController *vc = [segue destinationViewController];
        [self setNowViewController:vc];
        if (self.representedSchedule) {
            [self.nowViewController parentViewController:self
                                         didLoadSchedule:self.representedSchedule];
        }
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
