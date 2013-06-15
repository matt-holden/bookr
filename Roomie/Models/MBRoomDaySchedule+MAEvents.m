//
//  MBRoomDaySchedule+MAEventArray.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBRoomDaySchedule+MAEvents.h"
#import "MBRoomBooking+MAEvent.h"

@implementation MBRoomDaySchedule (MAEvents)
-(NSSet*)MAEvents
{
    NSMutableSet *set = [[NSMutableSet alloc] initWithCapacity:20];
    for (MBRoomBooking *booking in self.bookings) {
        MAEvent *event = [booking MAEvent];
        if (![event.title length]) {
            [event setTitle:NSLocalizedString(@"Reserved",@"")];
        }
        [set addObject:event];
    }
    return [NSSet setWithSet:set];
}
@end
