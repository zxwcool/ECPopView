# ECPopView
Pop up a custom view from UIViewController, you can custom the pop position, from top, bottom, left, right or center, this will be poped view is created all by yourself, that means you can pop up any view you created and modified or any subclasses inherited form UIView

弹出一个来自UIViewController的自定义视图，你可以自定义弹出位置，从顶部，底部，左边，右边或中间，弹出视图是由你自己创建的，这意味着你可以弹出你创建和修改的任何视图或者任何继承自UIView的子类

![image](https://github.com/zxwcool/ECPopView/blob/master/ECPopViewGIF.gif)

in the UIViewController you can write this:
```
    UIView* aView = [[UIView alloc] init];//do anything you want to modify the view...

    [self popCustomView:aView formPosition:ECPopViewFromTop];//then just pop up the view and set the pop position
```

## Customize the mask back ground color 
via ec_marskColor property, you can customize the mask back ground color, if you do not set the property for another value before your pop action, it will use the default back color defined in the header file:

通过ec_marskColor属性，您可以自定义蒙版背景颜色，如果您在弹出操作之前没有为另一个值设置属性，它将使用头文件中定义的默认背景颜色:
```
#define EC_DEFAULT_MASK_COLOR [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:0.5f]
```
you can change the defined color for global mask back ground color or set a different color for a indvidual pop-up view, but it will only effect onece

您可以为全局蒙版背景颜色更改定义的颜色，或为单个弹出视图设置不同的颜色，但这只会影响这一次的弹出

```
    UIView* aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    aView.backgroundColor = UIColor.redColor;
    //change the pop mask back ground color, but it only effect onece, for next pop it will use the default color
    UIColor* differentColor = [UIColor colorWithRed:88/255.0 green:88/255.0 blue:88/255.0 alpha:0.5f];
    self.ec_marskColor = differentColor;
    [self popCustomView:aView formPosition:ECPopViewFromTop];
```

## Using spring effective
you can determin to use a spring effective animation or just to pop up the view with classic animation

你可以决定是否使用带有弹性效果的弹出动画，或者只是用普通的动画来弹出视图

if you want a spring effective, you need to set the spring affective parameter, springVelocity and springDamping

如果你想要一个有弹簧效果的动画，你需要设置相应参数，弹簧速度和弹簧阻尼

```
    //no spring effective
    [self popCustomView:aView formPosition:ECPopViewFromTop];
    //with spring effective
    [self popCustomViewSpring:aView formPosition:ECPopViewFromTop springVelocity:1.0 withDamping:0.5];
```
## Config the pop animation duration
you can control the pop animation duration before you pop a view every time

您可以在每次弹出视图之前控制弹出动画的持续时间

via set the ec_popAnimateDuration property to any value you want to control the pop animation duration, it is a NSNumber property.

通过将ec_popAnimateDuration属性设置为任何您想要控制pop动画持续时间的值，它是一个NSNumber属性
```
    self.ec_popAnimateDuration = [NSNumber numberWithFloat:0.50];
    [self popCustomView:view formPosition:ECPopViewFromBottom];
```
