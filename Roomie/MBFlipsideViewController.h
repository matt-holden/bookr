//
//  MBFlipsideViewController.h
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBFlipsideViewController;

@protocol MBFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(MBFlipsideViewController *)controller;
@end

@interface MBFlipsideViewController : UIViewController

@property (weak, nonatomic) id <MBFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
