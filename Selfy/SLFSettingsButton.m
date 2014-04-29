//
//  SLFSettingsButton.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/29/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFSettingsButton.h"

@implementation SLFSettingsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
    
        
        
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
 
//    
//    float h= rect.size.width = 2;
//    float w= rect.size.width = 2;
//
//    
    CGContextRef context = UIGraphicsGetCurrentContext();

    [[UIColor blueColor]set];

    // 3 lines
    CGContextMoveToPoint(context, 1, 1);
    CGContextAddLineToPoint(context, 19, 1);
    
    CGContextMoveToPoint(context, 1, 10);
    CGContextAddLineToPoint(context, 19, 10);

    CGContextMoveToPoint(context, 1, 19);
    CGContextAddLineToPoint(context, 19, 19);
    
    
    CGContextStrokePath(context);

    
    
    
}


@end
