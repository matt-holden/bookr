//
//  MBRoomDaySchedule+Engine.h
//  Roomie
//
//  Created by Matthew Holden on 6/15/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBRoomDaySchedule.h"
#import "MBTimeWindow.h"

@interface MBRoomDaySchedule (Engine)
-(BOOL)isInUseNow;
-(NSArray*)availableTimeWindows;
-(MBTimeWindow*)nextAvailableTimeWindow;
-(MBRoomBooking*)currentBooking;
-(MBRoomBooking*)nextBooking;
@end
