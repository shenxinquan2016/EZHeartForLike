//
//  EZHeartForLikeView.h
//  EZHeartForLike
//
//  Created by Netca on 16/5/6.
//  Copyright © 2016年 阿澤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EZHeartForLikeView : UIView

//需要将自己的UI存放在contentView中。
@property (strong, nonatomic) UIView *contentView;
//提供小桃心的View供用户自定义其位置、大小的属性。
@property (strong, nonatomic) UIImageView *smallHeart;


@end
