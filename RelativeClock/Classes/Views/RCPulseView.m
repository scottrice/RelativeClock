//
//  RCPulseView.m
//  RelativeClock
//
//  Created by Scott on 4/6/13.
//  Copyright (c) 2013 Stacks on Stacks. All rights reserved.
//

#import "RCPulseView.h"

@implementation RCPulseView

@synthesize color=_color;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  // Draw the ring
  CGContextRef contextRef = UIGraphicsGetCurrentContext();
  CGContextSetStrokeColorWithColor(contextRef, _color.CGColor);
  CGContextSetLineWidth(contextRef, 2);
  CGContextStrokeEllipseInRect(contextRef, [self bounds]);
}

@end
