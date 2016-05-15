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
            self.liked = YES;
        }
    } else {
        // 没有指定显示大桃心的View或者取消like，直接翻转
        [self rollOver];
        self.liked = NO;
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
    // 获得共同的SuperView
    UIView * mutualSuperView = [self findTheMutualSuperView];
    
    // 然后映射两个Heart的坐标。
    // 首先是小桃心(self)
    UIView *view1 = self;
    CGPoint smallHeartPoint = CGPointZero;
    while (view1 != mutualSuperView) {
        smallHeartPoint.x += view1.frame.origin.x;
        smallHeartPoint.y += view1.frame.origin.y;
        view1 = view1.superview;
    }
    // 其次是大桃心(self.BigHeart)
    UIView *view2 = self.BigHeart;
    CGPoint bigHeartPoint = CGPointZero;
    while (view2 != mutualSuperView) {
        bigHeartPoint.x += view2.frame.origin.x;
        bigHeartPoint.y += view2.frame.origin.y;
        view2 = view2.superview;
    }
    
    // 在SuperView上完成Transform Animation
    self.BigHeart.hidden = YES;
    CGRect rect = self.BigHeart.frame;
    rect.origin.x = bigHeartPoint.x;
    rect.origin.y = bigHeartPoint.y;
    __block UIView *tempBigHeart = [[UIView alloc] initWithFrame:rect];
    tempBigHeart.backgroundColor = self.BigHeart.backgroundColor;
    [mutualSuperView addSubview:tempBigHeart];
    __weak EZHeartForLike *weakSelf = self;
    [UIView animateWithDuration:.2 animations:^{
        CGRect rect = tempBigHeart.frame;
        if (bigHeartPoint.x < smallHeartPoint.x) rect.origin.x -= 20;
        else rect.origin.x += 20;
        if (bigHeartPoint.y < smallHeartPoint.y) rect.origin.y -= 20;
        else rect.origin.y += 20;
        rect.size.width *= 1.5;
        rect.size.height *= 1.5;
        tempBigHeart.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut
        animations:^{
            CGRect rect = weakSelf.frame;
            rect.origin.x = smallHeartPoint.x;
            rect.origin.y = smallHeartPoint.y;
            tempBigHeart.frame = rect;
        } completion:^(BOOL finished) {
            [tempBigHeart removeFromSuperview];
            tempBigHeart = nil;
        }];
    }];
    self.BigHeart = nil;
}
- (UIView *)findTheMutualSuperView {
    // 找出小桃心（self）和大桃心（self.BigHeart）的共同的SuperView
    // 计算self到UIWindow的距离（以中间View的层数为距离计量）
    UIView *view1 = self;
    NSInteger smallViewSuperViewCount = 0;
    while (![view1 isKindOfClass:[UIWindow class]]) {
        smallViewSuperViewCount ++;
        view1 = view1.superview;
    }
    NSLog(@"%ld", smallViewSuperViewCount);
    // 计算self.BigHeart到UIWindow的距离（以中间View的层数为距离计量）
    UIView *view2 = self.BigHeart;
    NSInteger bigViewSuperViewCount = 0;
    while (![view2 isKindOfClass:[UIWindow class]]) {
        bigViewSuperViewCount ++;
        view2 = view2.superview;
    }
    NSLog(@"%ld", bigViewSuperViewCount);
    // 共同的SuperView之后的View肯定是一致的，因此小桃心和大桃心到UIWindow的距离之间的差
    // 实在共同的SuperView之前就存在的。所以，判断二者到UIWindow的距离大小，并利用两者之间
    // 的差距就可以找到共同的SuperView
    NSInteger mutualViewCount = labs(smallViewSuperViewCount - bigViewSuperViewCount);
    view1 = self;
    view2 = self.BigHeart;
    if (smallViewSuperViewCount > bigViewSuperViewCount) {
        for (int i = 0; i < mutualViewCount; ++ i) {
            view1 = view1.superview;
        }
    } else {
        for (int i = 0; i < mutualViewCount; ++ i) {
            view2 = view2.superview;
        }
    }
    while (view1 != view2) {
        view1 = view1.superview;
        view2 = view2.superview;
    }
    return view1;
}

#pragma mark - withoutDisplayView
- (void)rollOver {
    
}
@end
