//
//  MainViewController.m
//  Calculater
//
//  Created by li on 16/5/17.
//  Copyright © 2016年 li. All rights reserved.
// (i > 16) ? (KW/2 + (i - 16) * KW/4) :

#import "MainViewController.h"
#import "UIColor+FlatUI.h"

@interface MainViewController ()<UITextFieldDelegate>


@property (nonatomic, strong) NSArray *keyboardTextArr;

@property (nonatomic, strong) UITextField *YLtextField;

@end


#define KW self.view.bounds.size.width
#define KH self.view.bounds.size.height
#define KC self.keyboardTextArr.count

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createLabel];
    
    [self createTextField];
    
    [self creatBtn];

    self.YLtextField.delegate = self;
}

#pragma mark - 创建头视图
- (void)createLabel{

    UILabel *YLlabel = [[UILabel alloc] initWithFrame:CGRectMake(10,20, KW - 20, 140)];
    YLlabel.backgroundColor = [UIColor whiteColor];
    YLlabel.text = @"Welcome to YLCalculter";
    YLlabel.textAlignment = NSTextAlignmentCenter;
    YLlabel.font = [UIFont fontWithName:@"Georgia" size:32.0];
    YLlabel.layer.cornerRadius = 15;
    YLlabel.clipsToBounds = YES;
    [self.view addSubview:YLlabel];
    
}

#pragma mark - 创建textField
- (void)createTextField{

    UITextField *YLtextField = [[UITextField alloc] initWithFrame:CGRectMake(10, ((KH - (KW/4)*5) - 50), KW - 20,50)];
    YLtextField.backgroundColor = [UIColor colorFromHexCode:@"F2E8B5"];
    YLtextField.layer.cornerRadius = 15;
    YLtextField.clipsToBounds = YES;
    YLtextField.textAlignment = NSTextAlignmentRight;
    YLtextField.font = [UIFont systemFontOfSize:30.0];
    YLtextField.placeholder = @"请输入数字";
    // 设置文本的内边距
    YLtextField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
    YLtextField.rightViewMode = UITextFieldViewModeAlways;
    
    self.YLtextField = YLtextField;
    [self.view addSubview:YLtextField];

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [textField resignFirstResponder];
}



#pragma mark - 循环创建键盘按钮
- (void)creatBtn{
    for (int i = 0; i < KC ; i++) {
        CGFloat YLBtnX = 5 + (i%4 * (KW / 4));
        CGFloat YLBtnY = 10 + (KH - (KW/4) * 5) + i/4 * (KW / 4);
        CGFloat YLBtnW = (i == KC - 1)? KW/2 - 10 : KW/4 - 10;
        CGFloat YLBtnH = KW/4 - 10;
        
        UIButton *YLBtn = [[UIButton alloc] initWithFrame:CGRectMake(YLBtnX, YLBtnY, YLBtnW, YLBtnH)];
        [YLBtn setBackgroundColor:[UIColor colorFromHexCode:@"F2E8B5"]];
        [YLBtn setTitle:self.keyboardTextArr[i] forState:UIControlStateNormal];
        [YLBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        YLBtn.titleLabel.font = [UIFont systemFontOfSize:40.0];
        YLBtn.layer.cornerRadius = 15;
        YLBtn.clipsToBounds = YES;
        YLBtn.tag = i * 100;
        [YLBtn addTarget:self action:@selector(YLBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:YLBtn];
    }
}

#pragma mark - 按钮的点击方法
- (void)YLBtnClick:(UIButton *)sender{
    
    if (sender.tag == 0){
    
        self.YLtextField.text = @"0";
    }
    
}


#pragma mark - keyboardTextArr 惰性实例化
- (NSArray *)keyboardTextArr{

    if (_keyboardTextArr == nil) {
        _keyboardTextArr = @[@"C",@"+／-",@"%",@"/",@"7",@"8",@"9",@"x",@"4",@"5",@"6",@"-",@"1",@"2",@"3",@"+",@"0",@".",@"="];
    }
    return _keyboardTextArr;
}

@end
