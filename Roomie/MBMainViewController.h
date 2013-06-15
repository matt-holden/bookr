//
//  MBMainViewController.h
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBFlipsideViewController.h"
#import <MACalendarUI/MADayView.h>

@interface MBMainViewController : UIViewController <MBFlipsideViewControllerDelegate, UIPopoverControllerDelegate, MADayViewDataSource, MADayViewDelegate, MADayViewDelegate>
{
    IBOutlet UINavigationItem *_navItem;
}

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (nonatomic) IBOutlet MADayView *dayView;
@end
