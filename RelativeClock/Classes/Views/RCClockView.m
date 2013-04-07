//
//  RCClockView.m
//  RelativeClock
//
//  Created by Scott on 4/6/13.
//  Copyright (c) 2013 Stacks on Stacks. All rights reserved.
//

#import "RCClockView.h"

#define BORDER_WIDTH 2
#define SECONDS_IN_MINUTE 60
#define MINUTES_IN_HOUR 60
#define HOURS_IN_DAY 24
#define BASE 5

#define ALL_SCALE 1
#define HOUR_SCALE 1
#define MINUTE_SCALE 1
#define SECOND_SCALE 1

static const NSUInteger baseRadius = BASE;
static const NSUInteger secondsRadius = baseRadius + (SECONDS_IN_MINUTE * SECOND_SCALE);
static const NSUInteger minutesRadius = secondsRadius + BORDER_WIDTH + (MINUTES_IN_HOUR * MINUTE_SCALE);
static const NSUInteger clockRadius = minutesRadius + BORDER_WIDTH + (HOURS_IN_DAY * HOUR_SCALE);

@implementation RCClockView

@synthesize hours=_hours;
@synthesize minutes=_minutes;
@synthesize seconds=_seconds;

@synthesize ringColor=_ringColor;
@synthesize borderColor=_borderColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      // Make the pulse as big as the clock. This will (hopefully) allow for
      // easier scale calculations
      _pulse = [[RCPulseView alloc] initWithFrame:[self rectForRadius:clockRadius]];
      _secondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
      [_secondsLabel setTextAlignment:NSTextAlignmentCenter];
      [_secondsLabel setBackgroundColor:[UIColor clearColor]];
      [_secondsLabel setTextColor:[UIColor whiteColor]];
      [_secondsLabel setCenter:[self center]];
      [self addSubview:_secondsLabel];
      // These need to come after the _pulse initialization so that setRingColor
      // sets the color of _pulse as well
      [self setRingColor:[UIColor whiteColor]];
      [self setBorderColor:[UIColor redColor]];
      [self setBackgroundColor:[UIColor blackColor]];
      
      [self addSubview:_pulse];
      [_pulse setHidden:YES];
    }
    return self;
}

- (void)setRingColor:(UIColor *)ringColor {
  _ringColor = ringColor;
  [_pulse setColor:ringColor];
}

- (void)setCurrentTime {
  [self setTimeFromDate:[NSDate date]];
}

- (void)setTimeFromDate:(NSDate *)date {
  NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSDateComponents *components = [cal components:(NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:date];
  _hours = [components hour];
  _minutes = [components minute];
  [self setSeconds:[components second]];
  [self setNeedsDisplay];
}

- (void)tick {
  [self incrementSeconds];
  [self setNeedsDisplay];
}

- (void)incrementSeconds {
  _seconds = _seconds + 1;
  if (_seconds / SECONDS_IN_MINUTE) {
    _seconds = _seconds % SECONDS_IN_MINUTE;
    [self incrementMinutes];
  }
  [_secondsLabel setText:[NSString stringWithFormat:@"%i",_seconds]];
}

- (void)incrementMinutes {
  _minutes = _minutes + 1;
  if (_minutes / MINUTES_IN_HOUR) {
    _minutes = _minutes % MINUTES_IN_HOUR;
    [self incrementHours];
  }
}

- (void)incrementHours {
  _hours = _hours + 1;
  if (_hours / HOURS_IN_DAY) {
    _hours = _hours % HOURS_IN_DAY;
  }
}

- (void)setHours:(NSUInteger)hours minutes:(NSUInteger)minutes seconds:(NSUInteger)seconds {
  _hours = hours;
  _minutes = minutes;
  _seconds = seconds;
  [_secondsLabel setText:[NSString stringWithFormat:@"%i",_seconds]];
  [self setNeedsDisplay];
}

- (void)setHours:(NSUInteger)hours {
  _hours = hours;
  [self setNeedsDisplay];
}

- (void)setMinutes:(NSUInteger)minutes {
  _minutes = minutes;
  [self setNeedsDisplay];
}

- (void)setSeconds:(NSUInteger)seconds {
  _seconds = seconds;
  [_secondsLabel setText:[NSString stringWithFormat:@"%i",_seconds]];
  [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code
  NSLog(@"Drawing! %i:%i:%i",_hours,_minutes,_seconds);
  // Needs to be in this order (to avoid drawing overlaps)
  [self drawBorderAtRadiusLocation:clockRadius];
  [self drawCircleWithOuterRadius:clockRadius innerRadius:(clockRadius - (_hours * HOUR_SCALE))];
  [self drawBorderAtRadiusLocation:minutesRadius];
  [self drawCircleWithOuterRadius:minutesRadius innerRadius:(minutesRadius - (_minutes * MINUTE_SCALE))];
  [self drawBorderAtRadiusLocation:secondsRadius];
  [self drawCircleWithOuterRadius:secondsRadius innerRadius:(secondsRadius - (_seconds * SECOND_SCALE))];
}

- (void)drawCircleWithOuterRadius:(CGFloat)outer innerRadius:(CGFloat)inner {
  [self drawCircleWithOuterRadius:outer innerRadius:inner fillColor:[self ringColor]];
}

- (void)drawBorderAtRadiusLocation:(CGFloat)radius {
  [self drawCircleWithOuterRadius:radius+BORDER_WIDTH innerRadius:radius fillColor:[self borderColor]];
}

#pragma mark Private Methods

- (void)drawCircleWithOuterRadius:(CGFloat)outer innerRadius:(CGFloat)inner fillColor:(UIColor *)color {
  // Draw the outer circle in the color of the rings
  [self drawCircle:outer fillColor:color];
  // Draw the inner circle using the background color
  [self drawCircle:inner fillColor:[self backgroundColor]];
}

- (void)drawCircle:(CGFloat)radius fillColor:(UIColor *)color {
  UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:[self rectForRadius:radius]];
  [color set];
  [circle fill];
}

- (CGRect)rectForRadius:(CGFloat)radius {
  // Scale up the radius (in case of iPad etc)
  CGFloat r = ALL_SCALE * radius;
  CGPoint center = [self center];
  // Calculate the origin. We want the center of the rectangle to be the center
  // of the view, so the origin of the rectangle should be view.center - radius
  return CGRectMake(center.x - r, center.y - r, r * 2, r * 2);
}

@end