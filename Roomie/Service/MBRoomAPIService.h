//
//  MBRoomAPIService.h
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBRoomCollectionViewDataSource.h"
#import "MBRoomDaySchedule.h"

@interface MBRoomAPIService : NSObject
@property (nonatomic) MBRoomCollectionViewDataSource *collectionViewDataSource;

-(void)loadScheduleForDay:(NSDate*)date
                     room:(MBRoom*)room
                     done:(void(^)(NSError* err, MBRoomDaySchedule* schedule))callback;
@end
