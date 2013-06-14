//
//  MBRoomBooking.h
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBRoomBooking : NSObject
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSDate *endTime;
@property (nonatomic) NSString *clientName;
@property (nonatomic) NSString *bookingNotes;
@property (nonatomic) NSString *displayName;
@end
