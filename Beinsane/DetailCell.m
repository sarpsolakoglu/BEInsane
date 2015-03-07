//
//  DetailCell.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "DetailCell.h"
#import "BEIResponse.h"

@implementation DetailCell

-(void) configureCell:(BEICustomQueryNode*)response {
    if (response.title) {
        self.titleLabel.text = response.title;
    }
    if (response.snippet) {
        self.subtitleLabel.text = response.snippet;
    }
}

- (void)awakeFromNib {
    // Initialization code
    self.cImageView.layer.cornerRadius = (self.cImageView.frame.size.height / 2);
    self.cImageView.layer.masksToBounds = YES;
    self.cImageView.contentMode = UIViewContentModeScaleToFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
