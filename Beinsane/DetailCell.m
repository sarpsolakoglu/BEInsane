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

//Set the text and subtitle field
-(void) configureCell:(BEICustomQueryNode*)response {
    if (response.title) {
        self.titleLabel.text = response.title;
    }
    if (response.snippet) {
        self.subtitleLabel.text = response.snippet;
    }
}

- (void)awakeFromNib {
    // To make imageview round
    self.cImageView.layer.cornerRadius = (self.cImageView.frame.size.height / 2);
    self.cImageView.layer.masksToBounds = YES;
    // Set content mode
    self.cImageView.contentMode = UIViewContentModeScaleToFill;
}

@end
