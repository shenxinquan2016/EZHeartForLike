![](logo.png)
    
    
![](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
![](https://img.shields.io/badge/CocoaPods-v0.0.1-green.svg?style=flat)
![](https://img.shields.io/badge/platform-iOS-red.svg?style=flat)
> EZHeartForLike in Objective-C.    
> EZHeartForLike 是点赞动画的实现，但是值得注意的是动画的**执行位置**，从下图可以看出，大桃心和小桃心所在的View是不同的View。因此解决动画的跨View实现才是EZHeartForLike的真正目的。    
> 而且这个动画也是萌萌哒，哈哈哈哈

![](single.gif)
![](double.gif)


## How To Get Started

### Installation

You can install EZHeartForLike in a traditional way -- drag the **EZHeartForLike folder** into your project. However, it is strongly recommended that you install via CocoaPods.    
你可以直接在 **EZHeartForLike**文件夹中将EZHeartForLike的.h、.m加入到项目中直接使用


### Usage
**一行代码完成实现**
#### Create a EZHeartForLike

1. import the "EZHeartForLike.h" to your controller.
    
    ``` 
    #import "EZHeartForLike.h"
    ```
    
2. init the EZHeartForLike into your controller.

    ```
    EZHeartForLike *heart = [[EZHeartForLike alloc] initWithFrame:CGRectMake(0, 0, 24, 24) DisplayBigHeartOnView:self.tweetImageView];    
    ```
创建的EZHeartForLike是右下角的小桃心（见图1）    
指定的displayView是上图的ImageView，可实现双击（见图2）

3. If you want the EZHeartForLike to show your own image, just set the likeImage and the unlikeImage using follow function:

    ```
    [heart setLikeImage:[UIImage imageNamed:@"liked"] unLikeImage:[UIImage imageNamed:@"unlike"]];
    ```    


4. add the EZHeartForLike to your view;

    ```
    [self.view addSubview:heart];
    ```
    
5. enjoy.  :)

## Issues, Bugs, Suggestions

Open an [issue](https://github.com/Ezfen/EZHeartForLike/issues)

## License

EZHeartForLike is available under the MIT license. See the LICENSE file for more info.