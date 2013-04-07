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
  _clock = [[RCClockView alloc] initWithFrame:[[self view] bounds]];
  [[self view] addSubview:_clock];
//  NSDate *staticTime = [NSDate dateWithTimeIntervalSince1970:1365287359];
//  [_clock setTimeFromDate:staticTime];
  [_clock setCurrentTime];
  _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)timerDidFire:(NSTimer *)timer {
  [_clock tick];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
