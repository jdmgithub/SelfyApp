//
//  SLFTableViewCell.m
//  Selfy
//
//  Created by Jeffery Moulds on 4/21/14.
//  Copyright (c) 2014 Jeffery Moulds. All rights reserved.
//

#import "SLFTableViewCell.h"

@implementation SLFTableViewCell


{
    UIImageView * imageView;
    UIImageView * avatarView;
    UILabel * caption;
    
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
 
      
        
// slefy image View
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
        imageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:imageView];
        
// avatar image view
        
        avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 320, 60, 60)];
        avatarView.layer.cornerRadius = 30;
        avatarView.layer.masksToBounds = YES;

        [self.contentView addSubview:avatarView];
        
// selfy caption
        
        caption = [[UILabel alloc] initWithFrame:CGRectMake(100, 320, 200, 30)];
        caption.textColor = [UIColor darkGrayColor];
        caption.font = [UIFont systemFontOfSize:20];
    
        [self.contentView addSubview:caption];
    
    
    
    }
    return self;
}



- (void)setSelfyInfo:(NSDictionary *)selfyInfo
{
    
    _selfyInfo = selfyInfo;

    caption.text = selfyInfo[@"caption"];

    NSURL * imageURL = [NSURL URLWithString:selfyInfo[@"image"]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];

    imageView.image = image;

    NSURL * avatarURL = [NSURL URLWithString:selfyInfo[@"avatar"]];
    NSData * avatarData = [NSData dataWithContentsOfURL:avatarURL];
    UIImage * avatar = [UIImage imageWithData:avatarData];

    avatarView.image = avatar;


}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
