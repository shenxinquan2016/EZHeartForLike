//
//  EZHeartForLikeView.m
//  EZHeartForLike
//
//  Created by Netca on 16/5/6.
//  Copyright © 2016年 阿澤. All rights reserved.
//

#import "EZHeartForLike.h"

@interface EZHeartForLike()
// 显示在特定View上的大桃心
@property (strong, nonatomic) UIView *BigHeart;
@property (nonatomic, getter=isLiked) BOOL liked;

@end

@implementation EZHeartForLike

#pragma mark - initial
- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 32, 32)];
}
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame DisplayBigHeartOnView:nil];
}
- (instancetype)initWithFrame:(CGRect)frame DisplayBigHeartOnView:(UIView *)displayView {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1.000 green:0.038 blue:0.460 alpha:1.000];
        // 为小桃心添加单击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheSmallHeart:)];
        [self addGestureRecognizer:tap];
        // 将DisplayView保存起来，并为DisplayView添加双击事件
        if (displayView) {
            self.displayView = displayView;
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
            doubleTap.numberOfTapsRequired = 2;
            [self.displayView addGestureRecognizer:doubleTap];
        }
    }
    return self;
}

#pragma mark - UITapGestureRecognizer
- (void)tapTheSmallHeart:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self transferOrRollOver];
    }
}
- (void)doubleTap:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self transferOrRollOver];
    }
}

#pragma mark - achieve function
- (void)transferOrRollOver {
    if (!self.isLiked) {
        if (self.displayView) {
            // 指定了显示大桃心的View，显示大桃心
            [self displayBigHeartAndMove];
        }
    } else {
        // 没有指定显示大桃心的View或者取消like，直接翻转
        [self rollOver];
    }
}

#pragma mark - withDisplayView
- (void)displayBigHeartAndMove {
    self.BigHeart = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.BigHeart.backgroundColor = [UIColor colorWithRed:1.000 green:0.148 blue:0.440 alpha:1.000];
    self.BigHeart.center = self.displayView.center;
    [self.displayView addSubview:self.BigHeart];
    // 动态在displayView上展示大桃心
    [UIView animateWithDuration:.2 animations:^{
        CGAffineTransform transform = CGAffineTransformScale(self.BigHeart.transform, 64, 64);
        self.BigHeart.transform = transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.4 animations:^{
            self.BigHeart.transform = CGAffineTransformScale(self.BigHeart.transform, 0.8, 0.8);
        }];
    }];
    [self MoveToSmallHeart];
}
- (void)MoveToSmallHeart {
    // 获得共同的SuperView，然后映射两个Heart的坐标。
    UIView * mutualSuperView = [self findTheMutualSuperView];
    // 在SuperView上完成Transform Animation
    
}
- (UIView *)findTheMutualSuperView {
    // 找出小桃心和大桃心的共同的SuperView
    
    
    
    return nil;
}

#pragma mark - withoutDisplayView
- (void)rollOver {
    
}
@end
