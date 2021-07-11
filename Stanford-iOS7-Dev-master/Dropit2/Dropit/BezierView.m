//
//  BezierView.m
//  Dropit
//
//  Created by Mark Lewis on 15-8-14.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "BezierView.h"

@implementation BezierView

- (void)setPath:(UIBezierPath *)path
{
    if (_path != path)
    {
        _path = path;
        [self setNeedsDisplay];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.path stroke];
}

@end
