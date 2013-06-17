//
//  MBRoomDaySchedule+Engine.m
//  Roomie
//
//  Created by Matthew Holden on 6/15/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBRoomDaySchedule+Engine.h"
#import <CupertinoYankee/NSDate+CupertinoYankee.h>

@implementation MBRoomDaySchedule (Engine)

-(NSArray*)sortedBookings
{
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
    return [[self bookings] sortedArrayUsingDescriptors:@[ sd ]];
}

-(MBRoomBooking*)currentBooking
{
    NSArray *sortedBookings = [self sortedBookings];
    NSDate *now = [NSDate date];
    for (int i = 0, count = [sortedBookings count]; i < count; i++) {
        MBRoomBooking *booking = self.sortedBookings[i];
        
        if ([now compare:[booking endTime]] == NSOrderedDescending)
            // We've already looked at everything that's already happened
            break;
        else if ([now compare:[booking startTime]] == NSOrderedDescending)
            return booking;
    }
    return nil;
}
-(MBRoomBooking*)nextBooking
{
    NSArray *sortedBookings = [self sortedBookings];
    NSDate *now = [NSDate date];
    for (int i = 0, count = [sortedBookings count]; i < count; i++) {
        MBRoomBooking *booking = self.sortedBookings[i];
        
        if ([now compare:[booking startTime]] == NSOrderedAscending)
            // The first thing that's starts after now is the one we want
            return booking;
    }
    return nil;
}

-(NSArray*)availableTimeWindows
{
    NSDate *startTime = [self date];
    NSMutableArray *timeWindows = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0, count = [self.bookings count]; i < count; i++) {
        MBRoomBooking *thisBooking;
        MBTimeWindow *tw = [[MBTimeWindow alloc] init];
        [tw setStartTime:startTime];
        [tw setEndTime:[thisBooking startTime]];
        if ([tw.endTime timeIntervalSinceDate:tw.startTime] != 0) {
            [timeWindows addObject:tw];
        }
        startTime = [thisBooking endTime];
    }
    // Account for time from end of last booking until midnight
    if ([startTime compare:[self.date endOfDay]] == NSOrderedAscending) {
        MBTimeWindow *tw = [[MBTimeWindow alloc] init];
        [tw setStartTime:startTime];
        [tw setEndTime:[self.date endOfDay]];
        [timeWindows addObject:tw];
    }
    return [NSArray arrayWithArray:timeWindows];
}

-(MBTimeWindow*)nextAvailableTimeWindow
{
    NSArray *timeWindows = [self availableTimeWindows];
    NSDate *now = [NSDate date];
    int index = [timeWindows indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        MBTimeWindow *tw = (MBTimeWindow*)obj;
        if ([now compare:[tw startTime]] == NSOrderedAscending) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    return index == NSNotFound ? nil : timeWindows[index];
}

-(BOOL)isInUseNow
{
    return !![self currentBooking];
}


@end
