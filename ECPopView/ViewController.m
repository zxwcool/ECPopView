//
//  ViewController.m
//  ECPopView
//
//  Created by 张小伟 on 2018/8/28.
//  Copyright © 2018年 张小伟. All rights reserved.
//

#import "ViewController.h"
#import "ECPopView.h"
#import "Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self layoutBtns];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutBtns{
    UIButton* btnTop =  [self makePopBtn:ECPopViewFromTop];
    UIButton* btnBottom = [self makePopBtn:ECPopViewFromBottom];
    UIButton* btnLeft = [self makePopBtn:ECPopViewFromLeft];
    UIButton* btnRight = [self makePopBtn:ECPopViewFromRight];
    UIButton* btnCenter = [self makePopBtn:ECPopViewFromCenter];
    btnBottom.top = btnTop.bottom + 10;
    btnLeft.top = btnBottom.bottom + 10;
    btnRight.top = btnLeft.bottom + 10;
    btnCenter.top = btnRight.bottom + 10;
    [self.view addSubview:btnTop];
    [self.view addSubview:btnBottom];
    [self.view addSubview:btnLeft];
    [self.view addSubview:btnRight];
    [self.view addSubview:btnCenter];
}


- (UIButton*)makePopBtn:(ECPopViewFromPosition)popPosition{
    NSString* btnTitle = @"";
    UIColor* btnColor = UIColor.whiteColor;
    switch (popPosition) {
    case ECPopViewFromTop:
            btnColor = UIColor.redColor;
            btnTitle = @"PopFromTop";
            break;
    case ECPopViewFromBottom:
            btnColor = UIColor.blueColor;
            btnTitle = @"PopFromBottom";
            break;
    case ECPopViewFromLeft:
            btnColor = UIColor.greenColor;
            btnTitle = @"PopFromLeft";
            break;
    case ECPopViewFromRight:
            btnColor = UIColor.brownColor;
            btnTitle = @"PopFromRight";
            break;
    case ECPopViewFromCenter:
            btnColor = UIColor.cyanColor;
            btnTitle = @"PopFromCenter";
            break;
    }
    UIButton* btn = [UIButton new];
    btn.backgroundColor = btnColor;
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    btn.width = self.view.width - 30;
    btn.height = 40;
    btn.top = 150;
    btn.left = 15;
    btn.tag = popPosition;
    [btn addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)popView:(UIButton*)btn {
    UIView* view = [UIView new];
    switch (btn.tag) {
        case ECPopViewFromTop:
            view.backgroundColor = UIColor.redColor;
            view.size = CGSizeMake(self.view.width - 30, 200);
            self.ec_marskColor = [UIColor colorWithRed:115/255 green:30/255 blue:10/255 alpha:0.7];
            [self popCustomViewSpring:view formPosition:ECPopViewFromTop springVelocity:1.0 withDamping:0.5];
            break;
        case ECPopViewFromBottom:
            view.backgroundColor = UIColor.blueColor;
            view.size = CGSizeMake(self.view.width - 30, 200);
            self.ec_popAnimateDuration = [NSNumber numberWithFloat:0.50];
            [self popCustomView:view formPosition:ECPopViewFromBottom];
            break;
        case ECPopViewFromLeft:
            view.backgroundColor = UIColor.greenColor;
            view.size = CGSizeMake(self.view.width*2/3, self.view.height);
            [self popCustomViewSpring:view formPosition:ECPopViewFromLeft springVelocity:1.0 withDamping:0.5];
            break;
        case ECPopViewFromRight:
            view.backgroundColor = UIColor.brownColor;
            view.size = CGSizeMake(self.view.width*2/3, self.view.height);
            [self popCustomView:view formPosition:ECPopViewFromRight];
            break;
        case ECPopViewFromCenter:
            view.backgroundColor = UIColor.cyanColor;
            view.size = CGSizeMake(self.view.width*2/3, 200);
            [self popCustomViewSpring:view formPosition:ECPopViewFromCenter springVelocity:1.0 withDamping:0.5];
            break;
        default:
            break;
    }
}

- (UIView*)makeSomeUsfullView{
    UIView* view = [UIView new];
    view.frame = CGRectMake(0, 0, self.view.width - 80, 200);
    UIButton* btnSure = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, view.width/2, 40)];
    UIButton* btnConcle = [[UIButton alloc] initWithFrame:btnSure.frame];
    
    return view;
}


@end
