//
//  DetailCell.h
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BEICustomQueryNode;

@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
-(void) configureCell:(BEICustomQueryNode*)response;
@end
