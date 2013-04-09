//
//  RCViewController.m
//  RelativeClock
//
//  Created by Scott on 4/6/13.
//  Copyright (c) 2013 Stacks on Stacks. All rights reserved.
//

#import "RCViewController.h"

@interface RCViewController ()

@end

@implementation RCViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [[self view] setFrame:[[UIScreen mainScreen] bounds]];
  _clock = [[RCClockView alloc] initWithFrame:[[self view] bounds]];
  [[self view] addSubview:_clock];
  [self start];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)start {
  if (!_timer) {
    [_clock setCurrentTime];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
  }
  // 4/6/2013 5:29:59PM
  //  NSDate *staticTime = [NSDate dateWithTimeIntervalSince1970:1365287399];
  //  [_clock setTimeFromDate:staticTime];
}

- (void)timerDidFire:(NSTimer *)timer {
  [_clock tick];
}

- (void)pause {
  [_timer invalidate];
  _timer = nil;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
