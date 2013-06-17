//
//  MBMainViewController.h
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBFlipsideViewController.h"
#import <MACalendarUI/MADayView.h>
#import "MBDayView.h"

@class MBNowViewController;

@interface MBMainViewController : UIViewController <MBFlipsideViewControllerDelegate, UIPopoverControllerDelegate, MBDayViewDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (nonatomic) IBOutlet MBDayView *dayView;

@property (nonatomic) MBNowViewController *nowViewController;
@property (weak, nonatomic) IBOutlet UIView *nowViewControllerContainerView;
@end
