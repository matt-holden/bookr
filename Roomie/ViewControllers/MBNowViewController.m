//
//  MBNowViewController.m
//  Roomie
//
//  Created by Matthew Holden on 6/15/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBNowViewController.h"
#import <UIColor+Expanded.h>
#import <QuartzCore/QuartzCore.h>

#define MB_REFRESH_INTERVAL 1.f

@interface MBNowViewController()
@property (nonatomic, readonly) MBRoomDaySchedule *representedSchedule;
@property (nonatomic) NSArray *sortedBookings;
@property (nonatomic) NSTimer *clockRefreshTimer;
@property (nonatomic) NSTimer *currentStatusRefreshTimer;
@end

#define MB_ROOM_IN_USE_BACKGROUND_COLOR     [UIColor colorWithHexString:@"#DB2C35"]
#define MB_ROOM_IN_USE_TEXT                 NSLocalizedString(@"In Use", @"")

#define MB_ROOM_AVAILABLE_BACKGROUND_COLOR  [UIColor colorWithHexString:@"#82C055"]
#define MB_ROOM_AVAILABLE_TEXT              NSLocalizedString(@"Available", @"")

#define MB_ROOM_NEXT_AVAILABILITY_TEXT      NSLocalizedString(@"Next Availability", @"")
#define MB_ROOM_NEXT_BOOKING                NSLocalizedString(@"Next Booking", @"")

@implementation MBNowViewController

-(NSArray*)allLabels
{
    
    return @[ self.roomNameLabel, self.roomStatusLabel, self.roomClientNameLabel, self.nextAvailabilityLabel, self.nowLabel ];
}

-(void)viewDidLoad
{
    // Clean everything out
}
-(void)viewWillAppear:(BOOL)animated
{
    [self updateClockUI];
//    [self startTimers];
}
-(void)viewDidDisappear:(BOOL)animated
{
//    [self stopTimers];
    [self.clockRefreshTimer invalidate];
}


-(void)updateCurrentStatusUI
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    MBRoomBooking *booking;
    NSDate *nextChangeTime;
    
    if ((booking = [self.representedSchedule currentBooking])) {
        nextChangeTime = [booking endTime];
        // Room is in use
        [self.view setBackgroundColor:MB_ROOM_IN_USE_BACKGROUND_COLOR];
        [self.roomStatusLabel setText:MB_ROOM_IN_USE_TEXT];
        
        NSDate *nextAvailableTime = [[self.representedSchedule nextAvailableTimeWindow] startTime];
        if (nextAvailableTime) {
            NSString *nextTimeString = [NSString stringWithFormat:@"%@: %@", MB_ROOM_NEXT_AVAILABILITY_TEXT, [formatter stringFromDate:nextAvailableTime]];
            [self.nextAvailabilityLabel setText:nextTimeString];
        }
        
    }
    else {
        // Room is not occupied
        [self.view setBackgroundColor:MB_ROOM_AVAILABLE_BACKGROUND_COLOR];
        [self.roomStatusLabel setText:MB_ROOM_AVAILABLE_TEXT];
        
        NSString *nextBookingTime;
        NSString *nextBookingString;
        if ((booking = [self.representedSchedule nextBooking])) {
            nextChangeTime = [booking startTime];
            
            nextBookingTime = [formatter stringFromDate:[booking startTime]];
            nextBookingString = [NSString stringWithFormat:@"%@: %@",
                                 MB_ROOM_NEXT_BOOKING, nextBookingTime];
            
            [NSTimer scheduledTimerWithTimeInterval:[nextChangeTime timeIntervalSinceNow]
                                             target:self
                                           selector:@selector(updateCurrentStatusUI)
                                           userInfo:nil
                                            repeats:NO];
        } else {
            // Refresh again at the end of the day
            nextChangeTime = [[NSDate date] endOfDay];
            
            nextBookingString = @"";
        }
        
        [self.nextAvailabilityLabel setText:nextBookingString];
    }
    
}
-(void)updateClockUI
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    NSString *newTime = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *nowText = NSLocalizedString(@"Now", @"");
    NSString *clockText = [NSString stringWithFormat:@"%@: %@", nowText, newTime];
    [self.nowLabel setText:clockText];
}

-(void)startTimers
{
    self.clockRefreshTimer =
    [NSTimer scheduledTimerWithTimeInterval:MB_REFRESH_INTERVAL
                                     target:self
                                   selector:@selector(updateClockUI)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)stopTimers
{
    [self.clockRefreshTimer invalidate];
    [self.currentStatusRefreshTimer invalidate];
}

#pragma mark Communication with parent
-(void)parentViewControllerDidStartLoadingSchedule:(UIViewController*)vc
{
    [[self allLabels] setValue:@"" forKey:@"text"];
    [self.roomNameLabel setText:@"Loading..."];
}

-(void)parentViewController:(UIViewController*)vc
            didLoadSchedule:(MBRoomDaySchedule*)schedule
{
    [self.roomNameLabel setText:[schedule.room roomName]];
    _representedSchedule = schedule;
    [self updateCurrentStatusUI];
}
@end
