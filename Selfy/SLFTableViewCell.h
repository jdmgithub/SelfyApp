//
//  SLFTableViewCell.h
//  Selfy
//
//  Created by Jeffery Moulds on 4/21/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SLFTableViewCell : UITableViewCell

@property (nonatomic) PFObject * selfyInfo;

@end
