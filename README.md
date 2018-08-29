# ECPopView
Pop a custom view from UIViewController, you can custom the pop position, pop from top, bottom, left, right or center, the will be poped view is created all by yourself, that means you can pop up any view or subclass inherited form UIView
![image](https://github.com/zxwcool/ECPopView/blob/master/ECPopViewGIF.gif)

## customize the mask back ground color 
via ec_marskColor property, you can customize the mask back ground color, if you do not set the property, it will use the default back color defined in the header file:
```
#define EC_DEFAULT_MASK_COLOR [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:0.5f]
```
you can change the defined color for global mask back ground color or set a different color for a indvidual pop-up view, but it will only effect onece
