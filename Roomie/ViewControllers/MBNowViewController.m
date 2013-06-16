//
//  MBNowViewController.m
//  Roomie
//
//  Created by Matthew Holden on 6/15/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBNowViewController.h"
#import <UIColor+Expanded.h>

#define MB_REFRESH_INTERVAL 1.f

@interface MBNowViewController()
@property (nonatomic) MBRoomDaySchedule *representedSchedule;
@property (nonatomic) NSArray *sortedBookings;
@property (nonatomic) NSTimer *clockRefreshTimer;
@property (nonatomic) NSTimer *currentStatusUpdateTimer;
@end

#define MB_ROOM_IN_USE_BACKGROUND_COLOR     [UIColor colorWithHexString:@"#DB2C35"]
#define MB_ROOM_IN_USE_TEXT                 NSLocalizedString(@"In Use", @"")

#define MB_ROOM_AVAILABLE_BACKGROUND_COLOR  [UIColor colorWithHexString:@"#82C055"]
#define MB_ROOM_AVAILABLE_TEXT              NSLocalizedString(@"Available", @"")

@implementation MBNowViewController

-(NSArray*)allLabels
{
    
    return @[ self.roomNameLabel, self.roomStatusLabel, self.roomClientNameLabel, self.nextAvailabilityLabel, self.nowLabel ];
}

-(void)viewDidLoad
{
    // Clean everything out
    [[self allLabels] setValue:@"" forKey:@"text"];
    [self.roomNameLabel setText:@"Loading..."];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self updateClockUI];
    [self startTimers];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self stopTimers];
    [self.clockRefreshTimer invalidate];
}

-(void)setRepresentedSchedule:(MBRoomDaySchedule*)representedSchedule
{
    [self.roomNameLabel setText:[representedSchedule.room roomName]];
    [self setRepresentedSchedule:representedSchedule];
}

-(void)updateCurrentStatusUI
{
    MBRoomBooking *booking;
    if ((booking = [self.representedSchedule currentBooking])) {
        // Room is in use
        [self.view setBackgroundColor:MB_ROOM_IN_USE_BACKGROUND_COLOR];
        [self.roomStatusLabel setText:MB_ROOM_IN_USE_TEXT];
    }
    else {
        [self.view setBackgroundColor:MB_ROOM_AVAILABLE_BACKGROUND_COLOR];
        [self.roomStatusLabel setText:MB_ROOM_AVAILABLE_TEXT];
        
        if ((booking = [self.representedSchedule nextBooking])) {
        }
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
}
@end
