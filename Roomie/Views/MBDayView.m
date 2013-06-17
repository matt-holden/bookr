//
//  MBDayView.m
//  Roomie
//
//  Created by Matthew Holden on 6/16/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBDayView.h"
#import <CupertinoYankee/NSDate+CupertinoYankee.h>
#import "MBRoomDaySchedule.h"
#import "MBRoomDaySchedule+MAEvents.h"


@interface MBDayView() <MADayViewDataSource>
@property (nonatomic) id<MADayViewDataSource> realDataSource;
@property (nonatomic) NSCache *scheuduleCache;
@end

@implementation MBDayView

-(void)configure
{
    self.scheuduleCache = [[NSCache alloc] init];
    [super setDataSource:self];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self configure];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self configure];
    return self;
}
- (id)init
{
    self = [super init];
    [self configure];
    return self;
}

-(void)reloadData
{
    if (self.delegate) {
        [self.delegate dayView:self didRequestScheduleForDate:self.day];
    }
}

-(NSArray*)dayView:(MADayView *)dayView
     eventsForDate:(NSDate *)date
{
    MBRoomDaySchedule *schedule = [self.scheuduleCache objectForKey:[date beginningOfDay]];
    NSLog(@"foo: %@", self.scheuduleCache);
    NSLog(@"schedule %@", schedule);
    return [[schedule MAEvents] allObjects];
}

-(void)setSchedule:(MBRoomDaySchedule*)schedule forDate:(NSDate *)date
{
    NSDate *startOfDate = [date beginningOfDay];
    [self.scheuduleCache setObject:schedule forKey:[startOfDate copy]];
    // Reload view if this date we're storing is the same day as what's on-screen.
    if ([[self.day beginningOfDay] isEqualToDate:startOfDate]) {
        [super reloadData];
    }
}

-(void)setDataSource:(id<MADayViewDataSource>)dataSource
{
    NSAssert(0, @"You should never call this... all MADayViewDataSource"\
             "goodness should be handled in the baseclass");
}

-(void)clearCachedEvents
{
    [self.scheuduleCache removeAllObjects];
}

@end