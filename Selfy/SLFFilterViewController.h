//
//  SLFFilterViewController.h
//  Selfy
//
//  Created by Jeffery Moulds on 5/5/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLFFilterControllerDelegate;


@interface SLFFilterViewController : UIViewController


@property (nonatomic, assign) id<SLFFilterControllerDelegate> delegate;

@property (nonatomic) UIImage * imageToFilter;

@end



@protocol PPAFilterControllerDelegate <NSObject>

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image;

@end