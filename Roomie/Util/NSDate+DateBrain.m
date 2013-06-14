//
//  NSDate+DateBrain.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "NSDate+DateBrain.h"

@implementation NSDate (DateBrain)

-(NSDate*)dateWithHours:(NSInteger)hours
                minutes:(NSInteger)minutes
                seconds:(NSInteger)seconds
{
    NSDateComponents *comp = [self components];
    [comp setHour:hours];
    [comp setMinute:minutes];
    [comp setSecond:seconds];
    return [comp date];
}

-(NSDate*)dateWithHours:(NSInteger)hours
{
    NSDateComponents *comp = [self components];
    [comp setHour:hours];
    return [comp date];
}
-(NSDate*)dateWithMinutes:(NSInteger)minutes
{
    NSDateComponents *comp = [self components];
    [comp setMinute:minutes];
    return [comp date];
}
-(NSDate*)dateWithSeconds:(NSInteger)seconds
{
    NSDateComponents *comp = [self components];
    [comp setSecond:seconds];
    return [comp date];
}
-(NSDateComponents*)components
{
    // Use the user's current calendar and time zone
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    return dateComps;
}
@end
