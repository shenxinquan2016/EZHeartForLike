//
//  TweetTableViewCell.m
//  EZHeartForLike
//
//  Created by 阿澤🍀 on 16/5/4.
//  Copyright © 2016年 阿澤. All rights reserved.
//

#import "TweetTableViewCell.h"

@interface TweetTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *tweetImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    self.containerView.layer.cornerRadius = 10;
    self.containerView.clipsToBounds = YES;
}

- (void)setTweetImageName:(NSString *)tweetImageName {
    _tweetImageName = tweetImageName;
    self.tweetImageView.image = [UIImage imageNamed:self.tweetImageName];
}

@end
