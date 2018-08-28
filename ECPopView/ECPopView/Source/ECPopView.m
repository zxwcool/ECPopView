//
//  ZXWPopView.m
//  localpod
//
//  Created by 张小伟 on 2018/8/22.
//

#import "ECPopView.h"
#import <objc/runtime.h>

@implementation UIView (EC_UIView)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end

static const void *EC_popView = &EC_popView;

static const void *EC_marsk = &EC_marsk;

static const void *EC_marskColor = &EC_marskColor;

static const void *EC_PopAnimateDuration = &EC_PopAnimateDuration;

static const void *EC_popViewWillPopBlock = &EC_popViewWillPopBlock;

static const void *EC_popViewDidDismissBlock = &EC_popViewDidDismissBlock;

static const void *EC_leftNavBarItemView = &EC_leftNavBarItemView;

static const void *EC_rightNavBarItemView = &EC_rightNavBarItemView;

static const void *EC_popViewGesture = &EC_popViewGesture;

@implementation UIViewController (ECPopView_ViewController)

@dynamic ec_popView;

@dynamic ec_marsk;

@dynamic ec_marskColor;

@dynamic ec_popAnimateDuration;
//弹出视图将要弹出前要执行的Block
@dynamic ec_popViewWillPopBlock;

@dynamic ec_popViewDidDismissBlock;

@dynamic ec_popViewPanGesture;

- (UIView*)ec_marsk{
    if(objc_getAssociatedObject(self, EC_marsk) == nil){
        UIView* mask;
        mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        mask.backgroundColor = self.ec_marskColor;
        objc_setAssociatedObject(self, EC_marsk, mask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, EC_marsk);
}

- (void)setEc_marsk:(UIView *)marsk{
    if (marsk) {
        [self releaseAssociatedObject:EC_marsk];
        objc_setAssociatedObject(self, EC_marsk, marsk, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIView*)ec_popView{
    return objc_getAssociatedObject(self, EC_popView);
}

- (void)setEc_popView:(UIView *)popView{
    if (popView) {
        [self releaseAssociatedObject:EC_popView];
        objc_setAssociatedObject(self, EC_popView, popView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor*)ec_marskColor{
    if(objc_getAssociatedObject(self, EC_marskColor) == nil){
        return EC_DEFAULT_MASK_COLOR;
    }
    return objc_getAssociatedObject(self, EC_marskColor);
}

- (void)setEc_marskColor:(UIColor*)ec_marskColor{
    if (ec_marskColor) {
        self.ec_marsk.backgroundColor = ec_marskColor;
        [self releaseAssociatedObject:EC_marskColor];
        objc_setAssociatedObject(self, EC_marskColor, ec_marskColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSNumber*)ec_popAnimateDuration{
    if(objc_getAssociatedObject(self, EC_PopAnimateDuration) == nil){
        return EC_POPANIMATE_DURATION;
    }
    return objc_getAssociatedObject(self, EC_PopAnimateDuration);
}

- (void)setEc_popAnimateDuration:(NSNumber *)ec_popAnimateDuration{
    if (ec_popAnimateDuration.doubleValue > 0) {
        [self releaseAssociatedObject:EC_PopAnimateDuration];
        objc_setAssociatedObject(self, EC_PopAnimateDuration, ec_popAnimateDuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIPanGestureRecognizer*)ec_popViewPanGesture{
    if (objc_getAssociatedObject(self, EC_popViewGesture) == nil) {
        UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
        objc_setAssociatedObject(self, EC_popViewGesture, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, EC_popViewGesture);
}

- (void)setEc_popViewPanGesture:(UIPanGestureRecognizer *)ec_popViewPanGesture{
    [self releaseAssociatedObject:EC_popViewGesture];
    objc_setAssociatedObject(self, EC_popViewGesture, ec_popViewPanGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ECPopViewWillPopBlock)ec_popViewWillPopBlock{
    return objc_getAssociatedObject(self, EC_popViewWillPopBlock);
}

- (void)setEc_popViewWillPopBlock:(ECPopViewWillPopBlock)popViewWillPopBlock{
    [self releaseAssociatedObject:EC_popViewWillPopBlock];
    objc_setAssociatedObject(self, EC_popViewWillPopBlock, popViewWillPopBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ECPopViewDidDismissBlock)ec_popViewDidDismissBlock{
    return objc_getAssociatedObject(self, EC_popViewDidDismissBlock);
}

- (void)setEc_popViewDidDismissBlock:(ECPopViewWillPopBlock)PopViewDidDismissBlock{
    [self releaseAssociatedObject:EC_popViewDidDismissBlock];
    objc_setAssociatedObject(self, EC_popViewDidDismissBlock, PopViewDidDismissBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)releaseAssociatedObject: (const void *)key{
    if (objc_getAssociatedObject(self, key) != nil) {
        objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark -默认动画
- (void)popCustomView:(UIView*)popView formPosition:(ECPopViewFromPosition)position{
    [self popCustomView:popView formPosition:position usingSpring:NO withDamping:0 velocity:0];
}

#pragma mark -Spring动画
- (void)popCustomViewSpring:(UIView*)popView formPosition:(ECPopViewFromPosition)position springVelocity:(CGFloat)velocity withDamping:(CGFloat)damping {
    [self popCustomView:popView formPosition:position usingSpring:YES withDamping:damping velocity:velocity];
}

#pragma mark -自定义弹出视图方法
- (void)popCustomView:(UIView*)popView formPosition:(ECPopViewFromPosition)position usingSpring:(BOOL)spring withDamping:(CGFloat)damping velocity:(CGFloat)velocity {
    //弹出前执行的代码
    if (self.ec_popViewWillPopBlock) {
        self.ec_popViewWillPopBlock();
    }
    UITapGestureRecognizer* tapm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopViwe:)];
    [self.ec_marsk addGestureRecognizer:tapm]; self.ec_marsk.alpha = 0;
    self.ec_marsk.userInteractionEnabled = NO;  //先禁止点击交互，待弹出动画完毕后，再打开交互，避免用户迅速点击遮罩后，收起与弹出动画效果重复穿插
    [[[UIApplication sharedApplication] delegate].window addSubview:self.ec_marsk];
    self.ec_popView = popView;
    self.view.userInteractionEnabled = NO;
    switch (position) {
        case ECPopViewFromTop:{
            self.ec_popView.bottom = 0;
            self.ec_popView.centerX = [[UIApplication sharedApplication] delegate].window.width/2;
            [[[UIApplication sharedApplication] delegate].window addSubview:self.ec_popView];
            if (spring) {
                [self springWithDamping:damping velocity:velocity];
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self afterPopWithPosition:ECPopViewFromTop];
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self finishePop];
                    }
                }];
            }else {
                //开启下移动画
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
                    [self afterPopWithPosition:ECPopViewFromTop];
                } completion:^(BOOL finish){
                    if (finish) {
                        [self finishePop];
                    }
                }];
            }
            
        }
            break;
        case ECPopViewFromBottom:{
            self.ec_popView.top = [[UIApplication sharedApplication] delegate].window.height;
            self.ec_popView.centerX = [[UIApplication sharedApplication] delegate].window.width/2;
            [[[UIApplication sharedApplication] delegate].window addSubview:self.ec_popView];
            if (spring) {
                [self springWithDamping:damping velocity:velocity];
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self afterPopWithPosition:ECPopViewFromBottom];
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self finishePop];
                    }
                }];
            }else {
                //开启上移动画
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
                    [self afterPopWithPosition:ECPopViewFromBottom];
                } completion:^(BOOL finish){
                    if (finish) {
                        [self finishePop];
                    }
                }];
            }
            
        }
            break;
        case ECPopViewFromLeft:{
            self.ec_popView.right = 0;
            self.ec_popView.top = 0;
            [popView addGestureRecognizer:self.ec_popViewPanGesture];
            [[[UIApplication sharedApplication] delegate].window addSubview:self.ec_popView];
            if (spring) {
                [self springWithDamping:damping velocity:velocity];
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self afterPopWithPosition:ECPopViewFromLeft];
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self finishePop];
                    }
                }];
            }else {
                //开启右移动画
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
                    [self afterPopWithPosition:ECPopViewFromLeft];
                } completion:^(BOOL finish){
                    if (finish) {
                        [self finishePop];
                    }
                }];
            }
            
        }
            break;
        case ECPopViewFromRight:{
            self.ec_popView.left = [[UIApplication sharedApplication] delegate].window.width;
            self.ec_popView.top = 0;
            [popView addGestureRecognizer:self.ec_popViewPanGesture];
            [[[UIApplication sharedApplication] delegate].window addSubview:self.ec_popView];
            if (spring) {
                [self springWithDamping:damping velocity:velocity];
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self afterPopWithPosition:ECPopViewFromRight];
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self finishePop];
                    }
                }];
            }else {
                //开启左移动画
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
                    [self afterPopWithPosition:ECPopViewFromRight];
                } completion:^(BOOL finish){
                    if (finish) {
                        [self finishePop];
                    }
                }];
            }
            
        }
            break;
        case ECPopViewFromCenter:{
            self.ec_popView.center = CGPointMake([[UIApplication sharedApplication] delegate].window.width / 2, [[UIApplication sharedApplication] delegate].window.height / 2);;
            [[[UIApplication sharedApplication] delegate].window addSubview:self.ec_popView];
            if (spring) {
                [self springWithDamping:damping velocity:velocity];
                self.ec_popView.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, self.ec_popView.origin.x, self.ec_popView.origin.y);
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self afterPopWithPosition:ECPopViewFromCenter];
                    self.ec_popView.transform = CGAffineTransformMake(1.0f, 0, 0, 1.0f, 0, 0);
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self finishePop];
                    }
                }];
            } else{
                //开启弹出动画
                [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
                    [self afterPopWithPosition:ECPopViewFromCenter];
                } completion:^(BOOL finish){
                    if (finish) {
                        [self finishePop];
                    }
                }];
            }
        }
            break;
        default:
            break;
    }
}

- (void)springWithDamping:(CGFloat)damping velocity:(CGFloat)velocity{
    ec_popViewUsingSpring = YES;
    ec_popViewDamping = damping;
    ec_popViewVelocity = velocity;
}

- (void)closeSpring{
    ec_popViewUsingSpring = NO;
    ec_popViewDamping = 0;
    ec_popViewVelocity = 0;
}

- (void)finishePop{
    self.view.userInteractionEnabled = YES;
    self.ec_marsk.userInteractionEnabled = YES;
    self.ec_popView.userInteractionEnabled = YES;
}

- (void)afterPopWithPosition:(ECPopViewFromPosition)position{
    self.ec_marsk.alpha = 1;
    self.ec_marsk.tag = position;
    switch (position) {
        case ECPopViewFromTop:
            self.ec_popView.top = 0;
            break;
        case ECPopViewFromBottom:
            self.ec_popView.bottom = [[UIApplication sharedApplication] delegate].window.bottom;
            break;
        case ECPopViewFromLeft:
            self.ec_popView.left = 0;
            break;
        case ECPopViewFromRight:
            self.ec_popView.right = [[UIApplication sharedApplication] delegate].window.width;
            break;
        default:
            break;
    }
}

#pragma mark -自定义弹出视图回退消失方法
- (void)dismissPopViwe:(UIGestureRecognizer*)tap{
    switch (tap.view.tag) {
        case ECPopViewFromTop:{
            [self dismissPopFromTop];
        }
            break;
        case ECPopViewFromBottom:{
            [self dismissFromBottom];
        }
            break;
        case ECPopViewFromLeft:{
            [self dismissFromLeft];
        }
            break;
        case ECPopViewFromRight:{
            [self dismissFromRight];
        }
            break;
        case ECPopViewFromCenter:{
            if (ec_popViewUsingSpring) {
                [self closeSpring];
            }
            [self clearPopView];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -自定义弹出视图回退消失方法，通过按钮主动触发
- (void)dismissPopViweWithTag:(NSInteger)tag{
    switch (tag) {
        case ECPopViewFromTop:{
            [self dismissPopFromTop];
        }
            break;
        case ECPopViewFromBottom:{
            [self dismissFromBottom];
        }
            break;
        case ECPopViewFromLeft:{
            [self dismissFromLeft];
        }
            break;
        case ECPopViewFromRight:{
            [self dismissFromRight];
        }
            break;
        case ECPopViewFromCenter:{
            if (ec_popViewUsingSpring) {
                [self closeSpring];
            }
            [self clearPopView];
        }
            break;
            
        default:
            break;
    }
}

- (void)clearPopView{
    self.view.userInteractionEnabled = YES;
    [self.ec_popView removeGestureRecognizer:self.ec_popViewPanGesture];
//    [self.ec_popView removeAllSubviews];
    [self.ec_popView removeFromSuperview];
    [self.ec_marsk removeFromSuperview];
    self.ec_popView = nil;
    self.ec_popAnimateDuration = EC_POPANIMATE_DURATION;
    self.ec_marskColor = EC_DEFAULT_MASK_COLOR;
    if (self.ec_popViewDidDismissBlock) {
        self.ec_popViewDidDismissBlock();
    }
}

- (void)afterDismiss{
    self.ec_popView.userInteractionEnabled = NO;
    self.ec_marsk.userInteractionEnabled = NO;
    self.ec_marsk.alpha = 0;
}

- (void)dismissPopFromTop{
    if (ec_popViewUsingSpring) {
        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:ec_popViewDamping initialSpringVelocity:ec_popViewVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.ec_popView.bottom = 0;
            [self afterDismiss];
        } completion:^(BOOL finished) {
            if (finished) {
                [self closeSpring];
                [self clearPopView];
            }
        }];
    }else {
        //开启上移动画
        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
            self.ec_popView.bottom = 0;
            [self afterDismiss];
        } completion:^(BOOL finished){
            if (finished) {
                [self clearPopView];
            }
        }];
    }
}

- (void)dismissFromBottom{
    //开启下移动画
    if (ec_popViewUsingSpring) {
        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:ec_popViewDamping initialSpringVelocity:ec_popViewVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.ec_popView.top = [[UIApplication sharedApplication] delegate].window.bottom;
            [self afterDismiss];
        } completion:^(BOOL finished) {
            if (finished) {
                [self closeSpring];
                [self clearPopView];
            }
        }];
    }else {
        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
            self.ec_popView.top = [[UIApplication sharedApplication] delegate].window.bottom;
            [self afterDismiss];
        } completion:^(BOOL finished){
            if (finished) {
                [self clearPopView];
            }
        }];
    }
}

- (void)dismissFromLeft{
    //开启左移动画
    if (ec_popViewUsingSpring) {
        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:ec_popViewDamping initialSpringVelocity:ec_popViewVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.ec_popView.right = 0;
            [self afterDismiss];
        } completion:^(BOOL finished) {
            if (finished) {
                [self closeSpring];
                [self clearPopView];
            }
        }];
    }else {
        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
            self.ec_popView.right = 0;
            [self afterDismiss];
        } completion:^(BOOL finished){
            if (finished) {
                [self clearPopView];
            }
        }];
    }
}

- (void)dismissFromRight{
    //开启右移动画
    if (ec_popViewUsingSpring) {
        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:ec_popViewDamping initialSpringVelocity:ec_popViewVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.ec_popView.left = [[UIApplication sharedApplication] delegate].window.width;
            [self afterDismiss];
        } completion:^(BOOL finished) {
            if (finished) {
                [self closeSpring];
                [self clearPopView];
            }
        }];
    }else {
        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
            self.ec_popView.left = [[UIApplication sharedApplication] delegate].window.width;
            [self afterDismiss];
        } completion:^(BOOL finished){
            if (finished) {
                [self clearPopView];
            }
        }];
    }
}

static CGFloat ec_popViewPanStartX = 0.0;
static BOOL ec_popViewDismissForTriger = NO;

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer*)pan{
    UIView* popView = pan.view;
    CGPoint translationPoint = [pan translationInView:self.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            ec_popViewPanStartX = translationPoint.x;
            break;
        case UIGestureRecognizerStateChanged:{
            if (ec_popViewDismissForTriger) {
                break;
            }
            CGFloat delta = ec_popViewPanStartX - translationPoint.x;
            switch (self.ec_marsk.tag) {
                case ECPopViewFromLeft:{
                    CGFloat trigerX = self.view.width/3;
                    if (delta > 0) {
                        popView.left = -delta;
                        if (popView.right <= trigerX) {
                            ec_popViewDismissForTriger = YES;
                            [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
                                popView.left = -popView.width;
                                [self afterDismiss];
                            } completion:^(BOOL finished){
                                if (finished) {
                                    [self clearPopView];
                                    [self closeSpring];
                                    ec_popViewDismissForTriger = NO;
                                }
                            }];
                            
                        }
                    }
                }
                    break;
                case ECPopViewFromRight:{
                    CGFloat trigerX = self.view.width*2/3;
                    if (delta < 0) {
                        popView.right = self.view.width - delta;
                        if (popView.left >= trigerX) {
                            ec_popViewDismissForTriger = YES;
                            [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
                                popView.left = self.view.width;
                                [self afterDismiss];
                            } completion:^(BOOL finished){
                                if (finished) {
                                    [self clearPopView];
                                    [self closeSpring];
                                    ec_popViewDismissForTriger = NO;
                                }
                            }];
                            
                        }
                    }
                }
                    
                    break;
                default:
                    break;
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:{
            if (ec_popViewDismissForTriger) {
                break;
            }
            switch (self.ec_marsk.tag) {
                case ECPopViewFromLeft:{
                    if (ec_popViewUsingSpring) {
                        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:ec_popViewDamping initialSpringVelocity:ec_popViewVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
                            self.ec_popView.left = 0;
                            [self afterPopWithPosition:ECPopViewFromLeft];
                        } completion:^(BOOL finished) {
                            
                        }];
                    }else {
                        //开启右移动画
                        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
                            self.ec_popView.left = 0;
                            [self afterPopWithPosition:ECPopViewFromLeft];
                        } completion:^(BOOL finish){
                            
                        }];
                    }
                    
                }
                    break;
                case ECPopViewFromRight:{
                    if (ec_popViewUsingSpring) {
                        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue delay:0 usingSpringWithDamping:ec_popViewDamping initialSpringVelocity:ec_popViewVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
                            self.ec_popView.right = [[UIApplication sharedApplication] delegate].window.width;
                            [self afterPopWithPosition:ECPopViewFromRight];
                        } completion:^(BOOL finished) {
                            
                        }];
                    }else {
                        //开启左移动画
                        [UIView animateWithDuration:self.ec_popAnimateDuration.doubleValue animations:^{
                            self.ec_popView.right = [[UIApplication sharedApplication] delegate].window.width;
                            [self afterPopWithPosition:ECPopViewFromRight];
                        } completion:^(BOOL finish){
                            
                        }];
                    }
                    
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
//            NSLog(@"UIGestureRecognizerStateCancelled");
            break;
        default:
            break;
    }
    
}

@end
