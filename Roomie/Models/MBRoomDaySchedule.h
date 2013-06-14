//
//  MBRoomDaySchedule.h
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBRoom.h"
#import "MBStaff.h" // just cuz
#import "MBRoomBooking.h"

@interface MBRoomDaySchedule : NSObject

@property (nonatomic) MBRoom *room;
@property (nonatomic) NSArray *bookings;
@property (nonatomic) NSDate *date;

@end
