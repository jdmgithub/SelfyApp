//
//  SLFSettingsButton.h
//  Selfy
//
//  Created by Jeffery Moulds on 4/30/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLFSettingsButton : UIButton

@property (nonatomic, getter = isToggled) bool toggled;
@property (nonatomic) UIColor * toggledTintColor;

- (void)toggle;
// button itself is managing its toggled state


@end
