//
//  SLFPhotoLibraryButton.m
//  Selfy
//
//  Created by Jeffery Moulds on 5/4/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFPhotoLibraryButton.h"

@implementation SLFPhotoLibraryButton

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

    [self setNeedsDisplay];
   
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0;
    } completion:nil];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
