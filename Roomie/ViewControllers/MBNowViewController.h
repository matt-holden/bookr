//
//  MBNowViewController.h
//  Roomie
//
//  Created by Matthew Holden on 6/15/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models.h"

@interface MBNowViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomClientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextAvailabilityLabel;

@property (nonatomic) MBRoomDaySchedule *representedSchedule;

@end
