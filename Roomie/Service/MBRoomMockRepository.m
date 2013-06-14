//
//  MBRoomMockRepository.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBRoomMockRepository.h"
#import "MBRoomDaySchedule.h"
#import "NSDate+DateBrain.h"

@implementation MBRoomMockRepository

-(void)loadScheduleForDay:(NSDate*)date
                     room:(MBRoom*)room
                     done:(void(^)(NSError* err, MBRoomDaySchedule* schedule))callback
{
    NSAssert(callback, @"callback was passed");
    
    MBRoomDaySchedule *mockDay = [[MBRoomDaySchedule alloc] init];
    MBRoom *theRoom = [[MBRoom alloc] init];
    [theRoom setRoomId:@"123"];
    [theRoom setRoomName:@"MONDOPAD!"];
    [mockDay setDate:[NSDate date]];
    
    int startHour = 9;
    int length = 1;
    NSMutableArray *bookings = [[NSMutableArray alloc] initWithCapacity:3];
    for (int i = 0; i < 3; i++) {
        MBRoomBooking *booking = [[MBRoomBooking alloc] init];
        
        [booking setStartTime:[date dateWithHours:(startHour + 2*i) minutes:0 seconds:0]];
        [booking setEndTime:[date dateWithHours:(startHour + 2*i + length) minutes:0 seconds:0]];
        [bookings addObject:booking];
    }
    
    [mockDay setBookings:[NSArray arrayWithArray:bookings]];
    [mockDay setRoom:theRoom];
    
    callback(nil, mockDay);
}

@end
