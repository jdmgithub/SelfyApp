//
//  SLFPhotoLibraryButton.h
//  Selfy
//
//  Created by Jeffery Moulds on 5/4/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLFPhotoLibraryButton : UIButton

@property (nonatomic, getter = isToggled) bool toggled;
@property (nonatomic) UIColor * toggledTintColor;

- (void)toggle;

@end
