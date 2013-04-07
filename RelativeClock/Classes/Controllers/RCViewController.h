//
//  RCViewController.h
//  RelativeClock
//
//  Created by Scott on 4/6/13.
//  Copyright (c) 2013 Stacks on Stacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCClockView.h"

@interface RCViewController : UIViewController {
  RCClockView *_clock;
  NSTimer *_timer;
}

@end
