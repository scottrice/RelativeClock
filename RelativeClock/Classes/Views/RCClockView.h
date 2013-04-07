//
//  RCClockView.h
//  RelativeClock
//
//  Created by Scott on 4/6/13.
//  Copyright (c) 2013 Stacks on Stacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCPulseView.h"

@interface RCClockView : UIView {
  RCPulseView *_pulse;
}

// Increments the clock by 1 second
- (void)tick;
// Displays the current time on the clock
- (void)setCurrentTime;
// Displays the time represented by date on the clock
- (void)setTimeFromDate:(NSDate *)date;

@property(nonatomic)NSUInteger hours;
@property(nonatomic)NSUInteger minutes;
@property(nonatomic)NSUInteger seconds;

@property(nonatomic,strong)UIColor *ringColor;
@property(nonatomic,strong)UIColor *borderColor;

@end
