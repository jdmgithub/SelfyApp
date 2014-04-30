//
//  SLFSettingsButton.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/30/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFSettingsButton.h"

@implementation SLFSettingsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)toggle
{
    // this calls setToggled Method below  ... setter and getter
    self.toggled = !self.toggled;

}


// overide set toggled
-(void)setToggled:(bool)toggled
{
// gives toggle a value
    _toggled = toggled;

    self.alpha = 0.0;
    
    
// redraws the view (the toggle button);  setneedsdisplay runs on views/buttons.  calls drawrect
    [self setNeedsDisplay];


// animating the appearance along with the self.alpha line above
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0;
    } completion:nil];
    
}


-(void)drawRect:(CGRect)rect

{

    float pad = 1.0;
    float w = rect.size.width - pad;
    float h = rect.size.height - pad;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextClearRect(context, rect);
    

 // color can be set elsewhere, called here; but default is close to blue anyway. So will leave default.


    // if toggled, it is an X.  If not toggled, it is three lines
    if([self isToggled])
    {
        if (self.toggledTintColor !=nil) [self.toggledTintColor set];
        
        CGContextMoveToPoint(context, pad, pad);
        CGContextAddLineToPoint(context, w, h);
        
        CGContextMoveToPoint(context, w, pad);
        CGContextAddLineToPoint(context, pad, h);
        
        
    } else {
        
        [self.tintColor set];
        
        CGContextMoveToPoint(context, pad, pad);
        CGContextAddLineToPoint(context, w, pad);

        CGContextMoveToPoint(context, pad, h/2);
        CGContextAddLineToPoint(context, w, h/2);

        CGContextMoveToPoint(context, pad, h);
        CGContextAddLineToPoint(context, w, h);
        
    }
    
    CGContextStrokePath(context);

}


@end
