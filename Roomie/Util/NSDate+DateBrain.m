//
//  NSDate+DateBrain.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "NSDate+DateBrain.h"

#define CURRENT_CALENDAR [NSCalendar currentCalendar]
@implementation NSDate (DateBrain)

-(NSDate*)dateWithHours:(NSInteger)hours
                minutes:(NSInteger)minutes
                seconds:(NSInteger)seconds
{
    NSDateComponents *comp = [self dateComponents];
    [comp setHour:hours];
    [comp setMinute:minutes];
    [comp setSecond:seconds];
    
    return [CURRENT_CALENDAR dateFromComponents:comp];
}

-(NSDate*)dateWithHours:(NSInteger)hours
{
    NSDateComponents *comp = [self dateComponents];
    [comp setHour:hours];
    return [CURRENT_CALENDAR dateFromComponents:comp];
}
-(NSDate*)dateWithMinutes:(NSInteger)minutes
{
    NSDateComponents *comp = [self dateComponents];
    [comp setMinute:minutes];
    return [CURRENT_CALENDAR dateFromComponents:comp];
}
-(NSDate*)dateWithSeconds:(NSInteger)seconds
{
    NSDateComponents *comp = [self dateComponents];
    [comp setSecond:seconds];
    return [CURRENT_CALENDAR dateFromComponents:comp];
}

-(NSDateComponents*)dateComponents
{
    // Use the user's current calendar and time zone
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSCalendar *calendar = CURRENT_CALENDAR;
    [calendar setTimeZone:timeZone];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    return dateComps;
}
@end
