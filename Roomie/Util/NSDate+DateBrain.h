//
//  NSDate+DateBrain.h
//  Roomie
//
//  Created by Matthew Holden on 6/14/13.
//  Copyright (c) 2013 MINDBODY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateBrain)

-(NSDate*)dateWithHours:(NSInteger)hours
                minutes:(NSInteger)minutes
                seconds:(NSInteger)seconds;
-(NSDate*)dateWithHours:(NSInteger)hours;
-(NSDate*)dateWithMinutes:(NSInteger)minutes;
-(NSDate*)dateWithSeconds:(NSInteger)seconds;
@end
