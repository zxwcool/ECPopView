//
//  ZXWPopView.h
//  localpod
//
//  Created by 张小伟 on 2018/8/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define EC_POPANIMATE_DURATION  [NSNumber numberWithDouble:0.25]
#define EC_DEFAULT_MASK_COLOR [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:0.5f]

#pragma mark - 弹出视图位置类型
typedef NS_ENUM(NSInteger, ECPopViewFromPosition) {
    ECPopViewFromTop = -1000,        //顶部弹出
    ECPopViewFromBottom = -1001,     //底部弹出
    ECPopViewFromCenter = -1002,      //中心弹出
    ECPopViewFromLeft = -1003,
    ECPopViewFromRight = -1004
};

static CGFloat ec_popViewDamping = 0.0;
static CGFloat ec_popViewVelocity = 0.0;
static BOOL ec_popViewUsingSpring = NO;

typedef void(^ECPopViewWillPopBlock)(void);
typedef void(^ECPopViewDidDismissBlock)(void);

@interface UIViewController (ECPopView_ViewController)

@property (strong, nonatomic) UIView* ec_marsk;

@property (strong, nonatomic) UIColor* ec_marskColor;

@property (strong, nonatomic) NSNumber* ec_popAnimateDuration;

@property (strong, nonatomic) UIView* ec_popView;

@property (strong, nonatomic) ECPopViewWillPopBlock ec_popViewWillPopBlock;

@property (strong, nonatomic) ECPopViewDidDismissBlock ec_popViewDidDismissBlock;

@property (strong, nonatomic) UIPanGestureRecognizer* ec_popViewPanGesture;

#pragma mark -自定义弹出视图方法
- (void)popCustomView:(UIView*)popView formPosition:(ECPopViewFromPosition)position;
#pragma mark -Spring动画
- (void)popCustomViewSpring:(UIView*)popView formPosition:(ECPopViewFromPosition)position springVelocity:(CGFloat)velocity withDamping:(CGFloat)damping;
#pragma mark -弹出视图消失
- (void)dismissPopViwe:(UIGestureRecognizer*)tap;
#pragma mark -自定义弹出视图回退消失方法，通过按钮主动触发
- (void)dismissPopViweWithTag:(NSInteger)tag;

@end


