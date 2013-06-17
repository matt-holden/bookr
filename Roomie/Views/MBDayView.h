//
//  MBDayView.h
//  Roomie
//
//  Created by Matthew Holden on 6/16/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MADayView.h"

// This subclasses MADayView in order to support asynchronous
// event loading

@class MBDayView;
@class MBRoomDaySchedule;

@protocol MBDayViewDelegate <MADayViewDelegate>
-(void)dayView:(MBDayView*)dayView didRequestScheduleForDate:(NSDate*)date;
@end


@interface MBDayView : MADayView
@property (nonatomic, weak) id<MBDayViewDelegate>delegate;
-(void)setSchedule:(MBRoomDaySchedule*)schedule forDate:(NSDate *)date;
-(void)clearCachedEvents;
@end

