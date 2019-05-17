![title](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Image/title.png)

## 特点:

* 采用UICollectionView+UIpageViewController方案，子控制器和标题不需要提前创建，减少App启动时的资源消耗。
* 支持刷新，内置缓存(非复用)机制，刷新时已存在的的子控制器不会重新创建。
* 丰富的默认样式配置，可实现大部分主流App样式。
* 支持用户自定义标题样式。
* 支持多层嵌套。

## 结构:

![结构图](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Image/structure.png)

## App举例：

| App | 示例 | 
| ---- | ---- | 
|今日头条|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/1-1.gif)|
|腾讯新闻|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/1-2.gif)|
|澎湃新闻|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/1-3.gif)|
|爱奇艺|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/1-4.gif)|
|优酷|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/1-5.gif)|
|腾讯视频|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/1-6.gif)|
|网易新闻|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/1-7.gif)|
|人民日报|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/1-8.gif)|

## 基本属性：

| 功能 | 示例 | 
| ---- | ---- | 
|基本样式-标题正常显示|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-1.gif)|
|基本样式-标题显示在导航栏上|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-2.gif)|
|Segmented样式-标题正常显示|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-3.gif)|
|Segmented样式-标题显示在导航栏上|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-4.gif)|
|标题栏-局左|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-5.gif)|
|标题栏-局中|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-6.gif)|
|标题栏-局右|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-7.gif)|
|标题-自定义宽度|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-8.gif)|
|标题-自定义高度|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-9.gif)|
|标题-文字局上|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-10.gif)|
|标题-文字居下|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-11.gif)|
|标题-关闭标题颜色过渡|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-12.gif)|
|阴影动画-缩放|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-13.gif)|
|阴影动画-无|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-14.gif)|
|阴影末端形状-圆角|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-15.gif)|
|阴影末端形状-直角|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-16.gif)|
|阴影-居上|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-17.gif)|
|阴影-居中|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/2-18.gif)|


## 特殊用法：

| 场景 | 示例 | 
| ---- | ---- | 
|自定义Cell|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/3-1.gif)|
|频道定制|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/3-2.gif)|
|多级嵌套|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/3-3.gif)|
|子View滚动冲突|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/3-4.gif)|
|手动切换|![image](https://github.com/mengxianliang/XLPageViewController/blob/master/Images/Gif/3-5.gif)|

## 使用:

### 1、创建方法

#### 1.1 导入头文件

```objc
#import "XLPageViewController.h"
```

#### 1.2 遵守协议

```objc
@interface ViewController ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>
```


#### 1.3 创建外观配置类。

*注：config负责所有的外观配置，```defaultConfig```方法设定了默认参数，使用时可按需配置。* 

[Config属性列表](https://github.com/mengxianliang/XLPageViewController/blob/master/ConfigPropertyList.md)

```objc
  XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
```

#### 1.4 创建分页控制器

*注：需要把```pageViewController```添加为当前视图控制器的子试图控制器，才能实现```pageViewController```子试图控制器中的界面跳转。*
  
```objc
  XLPageViewController *pageViewController = [[XLPageViewController alloc] initWithConfig:config];
  pageViewController.view.frame = self.view.bounds;
  pageViewController.delegate = self;
  pageViewController.dataSource = self;
  [self.view addSubview:pageViewController.view];
  [self addChildViewController:pageViewController];
```

### 2、协议

#### 2.1 XLPageViewControllerDelegate

```objc
//位置回调方法：回调切换位置
- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index;
```

#### 2.2 XLPageViewControllerDataSrouce

```objc
//根据index创建对应的视图控制器，每个试图控制器只会被创建一次。
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index;
```

```objc
//根据index返回对应的标题
- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index;
```

```objc
//返回分页数
- (NSInteger)pageViewControllerNumberOfPage;
```

```objc
//标题cell复用方法，自定义标题cell时用到
- (__kindof XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index;
```

### 3、自定义标题cell

#### 3.1 创建一个```XLPageTitleCell```的子类

```objc
#import "XLPageTitleCell.h"

@interface CustomPageTitleCell : XLPageTitleCell

@end
```

#### 3.2 注册cell、添加创建cell的数据源方法

```objc
[self.pageViewController registerClass:CustomPageTitleCell.class forTitleViewCellWithReuseIdentifier:@"CustomPageTitleCell"];
```

```objc
- (XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    CustomPageTitleCell *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:@"CustomPageTitleCell" forIndex:index];
    return cell;
}
```

#### 3.3 复写cell父类方法

```objc
//通过此父类方法配置cell是否被选中样式
- (void)configCellOfSelected:(BOOL)selected {

}

//通过此父类方法配置cell动画 type:区分是当前选中cell/将要被选中的cell progress，动画进度0~1
- (void)showAnimationOfProgress:(CGFloat)progress type:(XLPageTitleCellAnimationType)type {
    
}

```

### 4、特殊情况处理

#### 4.1 和子view冲突问题

当pageViewController的子视图中存可滚动的子view，例如UISlider、UIScrollView等，如果和pageViewController发生滚动冲突时，可设置子view的   xl_letMeScrollFirst属性为真，这样可以避免和子view的滚动冲突。

```objc
  slider.xl_letMeScrollFirst = true;
```

## 其他

* 频道管理工具[XLChannelControl](https://github.com/mengxianliang/XLChannelControl)

* 开发过的其他UI工具[XLUIKit](https://github.com/mengxianliang/XLUIKit)
