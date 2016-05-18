//
//  EZHeartForLikeView.h
//  EZHeartForLike
//
//  Created by Netca on 16/5/6.
//  Copyright © 2016年 阿澤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EZHeartForLike : UIImageView

// 大桃心显示的用户指定的View
@property (weak, nonatomic) UIView *displayView;

// 对象方法，创建对象
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame DisplayBigHeartOnView:(UIView *)displayView;
//
- (void)setLikeImage:(UIImage *)likeImage unLikeImage:(UIImage *)unlikeImage;

@end
