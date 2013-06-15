//
//  MBRoomAPIService.m
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "RoomService.h"
#import "MBRoomRepository.h"
#import "MBRoomMockRepository.h"


@interface RoomService()
@property (nonatomic) id<MBRoomRepository> roomRepository;
@end
@implementation RoomService

-(MBRoomCollectionViewDataSource*)collectionViewDataSource
{
    if (!_collectionViewDataSource) {
        _collectionViewDataSource = [[MBRoomCollectionViewDataSource alloc] init];
    }
    return _collectionViewDataSource;
}

-(id)init
{
    self = [super init];
#if MB_USE_MOCK_REPOS
    self.roomRepository = [[MBRoomMockRepository alloc] init];
#else
    self.roomRepository = [[MBRoomAPIRepostiory alloc] init];
#endif
    
    return self;
}

-(void)loadScheduleForDay:(NSDate*)date
                     room:(MBRoom*)room
                     done:(void(^)(NSError* err, MBRoomDaySchedule* schedule))callback
{
    [self.roomRepository loadScheduleForDay:date
                                       room:room
                                       done:^(NSError *err, MBRoomDaySchedule *schedule) {
                                           if (err) {
                                               NSLog(@"error!: %@", err);
                                               NSAssert(0, @"bad bad bad");
                                               return;
                                           }
                                           
                                           callback(nil, schedule);
                                       }];
}

@end
