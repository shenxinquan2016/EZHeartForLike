//
//  TweetTableViewCell.m
//  EZHeartForLike
//
//  Created by 阿澤🍀 on 16/5/4.
//  Copyright © 2016年 阿澤. All rights reserved.
//

#import "TweetTableViewCell.h"

@implementation TweetTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TweetTableViewCell" owner:nil options:nil] lastObject];
    }
    return self;
}

@end
