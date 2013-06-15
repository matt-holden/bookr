//
//  MBMainViewController.h
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import "MBFlipsideViewController.h"

@interface MBMainViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource,MBFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
