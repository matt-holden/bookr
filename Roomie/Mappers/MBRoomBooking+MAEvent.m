//
//  MBRoomBooking+MAEvent.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBRoomBooking+MAEvent.h"

@implementation MBRoomBooking (MAEvent)

-(MAEvent*)MAEvent
{
    MAEvent *evt = [[MAEvent alloc] init];
    
    [evt setStart:self.startTime];
    [evt setDisplayDate:self.startTime];
    [evt setEnd:self.endTime];
    
    [evt setTitle:self.clientName];
    [evt setBackgroundColor:[UIColor purpleColor]];
	[evt setTextColor:[UIColor whiteColor]];
    [evt setAllDay:NO];
    
    __weak id weakSelf = self;
    [evt setUserInfo:@{
         NSStringFromClass(self.class) : weakSelf
    }];
    
    return evt;
}

@end
