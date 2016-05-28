//
//  MainViewController.m
//  Calculater
//
//  Created by li on 16/5/17.
//  Copyright © 2016年 li. All rights reserved.
// (i > 16) ? (KW/2 + (i - 16) * KW/4) :

#import "MainViewController.h"
#import "UIColor+FlatUI.h"

@interface MainViewController ()

// 键盘里的字符数组
@property (nonatomic, strong) NSArray *keyboardTextArr;
// 文本输入框
@property (nonatomic, strong) UILabel *YLLabel;
// 第一个数字
@property (nonatomic,assign) double firstNum;
// 第二个数字
@property (nonatomic, assign) double secondNum;
// 答案
@property (nonatomic, assign) double answerNum;
@end


#define KW self.view.bounds.size.width
#define KH self.view.bounds.size.height
#define KC self.keyboardTextArr.count

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建文本输入框
    [self creatYLLabel];
    // 创建按钮
    [self creatBtn];
    
    self.YLLabel.text = @"0";
    

    //NSLog(@"%@",[self deleteZero:@"5.232003400000000"]);
}

#pragma mark - 创建YLLabel
- (void)creatYLLabel{

    UILabel *YLLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, ((KH - (KW/4)*5) - 180), KW - 10,180)];
    YLLabel.backgroundColor = [UIColor colorFromHexCode:@"F2E8B5"];
    YLLabel.numberOfLines = 0;
    YLLabel.layer.cornerRadius = 15;
    YLLabel.clipsToBounds = YES;
    YLLabel.textAlignment = NSTextAlignmentRight;
    YLLabel.font = [UIFont systemFontOfSize:30.0];
    
    self.YLLabel = YLLabel;
    [self.view addSubview:YLLabel];

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}


// KC = 19
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
        YLBtn.tag = i * 10;
        [YLBtn addTarget:self action:@selector(YLBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:YLBtn];
    }
}

static  int calculateTag = 0; // 当前点击的计算按钮的tag
static BOOL DecimalPointClick = NO; // 当前小数点按钮是否被点击过
static BOOL equalClick = NO; // 等号按钮是否被点击过
#pragma mark - 按钮的点击方法
- (void)YLBtnClick:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
            // 数字AC键盘的点击方法
            self.YLLabel.text = @"0";
            calculateTag = 0;
            DecimalPointClick = NO;
            equalClick = NO;
            
            break;
            
        case 10:
            
            // 数字+/-键盘的点击方法
            self.YLLabel.text = [NSString stringWithFormat:@"%.2f",(0 - [self.YLLabel.text doubleValue])];
            break;
        
        case 40:
            
            // 数字7键盘的点击方法
            [self numkeyboardClick:@"7"];
            break;
            
        case 50:
            
            // 数字8键盘的点击方法
            [self numkeyboardClick:@"8"];
            break;
    
        case 60:
            
            // 数字9键盘的点击方法
            [self numkeyboardClick:@"9"];
            break;
        
        case 80:
            
            // 数字4键盘的点击方法
            [self numkeyboardClick:@"4"];
            break;
        
        case 90:
            
            // 数字5键盘的点击方法
            [self numkeyboardClick:@"5"];
            break;
        case 100:
            
            // 数字6键盘的点击方法
            [self numkeyboardClick:@"6"];
            break;
            
        case 120:
            
            // 数字1键盘的点击方法
            [self numkeyboardClick:@"1"];
            break;
            
        case 130:
            
            // 数字2键盘的点击方法
            [self numkeyboardClick:@"2"];
            break;
        
        case 140:
            
            // 数字3键盘的点击方法
            [self numkeyboardClick:@"3"];
            break;
        
        case 160:
            
            // 数字0键盘的点击方法 (值为零且不包含小数点的时候，为零的时候，返回不加零)
            if ([self.YLLabel.text isEqualToString: @"0"]) return;
            self.YLLabel.text = [self.YLLabel.text stringByAppendingString:@"0"];
            break;
        
        case 170:
            
            // 小数点键盘的点击方法
            if (DecimalPointClick == NO) {
                self.YLLabel.text = [self.YLLabel.text stringByAppendingString:@"."];
                DecimalPointClick = YES;
            }else return;
            
            break;
      
        case 30:
            
            // 除法按钮的点击方法
            calculateTag = 30;
            self.firstNum = [self.YLLabel.text doubleValue];
            self.YLLabel.text = @"0";
            DecimalPointClick = NO;
            break;
        
        case 20:
            // 百分号按钮的点击方法
            // %.2f 保留小数点后两位数。模运算（取余运算只能两边都是整数才可以运算）
            self.YLLabel.text = [NSString stringWithFormat:@"%.2f",[self.YLLabel.text doubleValue] * 0.001];
            break;
         
        case 70:
            
            // 乘法按钮的点击方法
            calculateTag = 70;
            self.firstNum = [self.YLLabel.text doubleValue];
            self.YLLabel.text = @"0";
            DecimalPointClick = NO;
            break;
         
        case 110:
            
            // 减法按钮的点击方法
            calculateTag = 110;
            self.firstNum = [self.YLLabel.text doubleValue];
            self.YLLabel.text = @"0";
            DecimalPointClick = NO;
            break;
         
        case 150:
            
            // 加法按钮的点击方法
            calculateTag = 150;
            self.firstNum = [self.YLLabel.text doubleValue];
            self.YLLabel.text = @"0";
            DecimalPointClick = NO;
            break;
        
        case 180:
            if (equalClick == NO){ // 给第二个数字赋值，只赋值一次。
            self.secondNum = [self.YLLabel.text doubleValue];
            }
            
            // MARK: 等号按钮的点击方法
            switch (calculateTag) {
                case 30: // 除法运算
                    self.answerNum = equalClick == NO ? self.firstNum / self.secondNum : [self.YLLabel.text doubleValue] / self.secondNum;
                    break;
                
                case 70: // 乘法运算
                    self.answerNum = equalClick == NO ? self.firstNum * self.secondNum : [self.YLLabel.text doubleValue] * self.secondNum;
                    break;
                    
                case 110: // 减法运算
                    self.answerNum = equalClick == NO ? self.firstNum - self.secondNum : [self.YLLabel.text doubleValue] - self.secondNum;
                    NSLog(@"firstNum:%f,secondNum:%f",self.firstNum,self.secondNum);
                    break;
                    
                case 150: // 加法运算
//                    if (equalClick == NO) {
//                        self.answerNum = self.firstNum + self.secondNum ;
//                        NSLog(@"firstNum:%f,secondNum:%f",self.firstNum,self.secondNum );
//                    }else
//                        self.answerNum = [self.YLLabel.text doubleValue] + self.secondNum;
                    // 三目运算代替上面的代码
                    self.answerNum = equalClick == NO ? self.firstNum + self.secondNum : [self.YLLabel.text doubleValue] + self.secondNum;
                    break;
                default:
                    break;
                 
            }
            break;

        default:
            break;
    }

}

#pragma mark - 重写answerNum的set方法，当answerNum被赋值的时候，同时给YLLabel赋值
-(void)setAnswerNum:(double)answerNum{
    _answerNum = answerNum;
    self.YLLabel.text = [self deleteZero:[NSString stringWithFormat:@"%.8f",_answerNum]];
    equalClick = YES;
}

#pragma mark - 取出小数点后面无效的零。
- (NSString *)deleteZero:(NSString *)String{
    
    if ([String rangeOfString:@"."].length ) {
        for (int i = 0 ; i < String.length + 1; i++) {
            // 取出最后的一个字符
            char s = [String characterAtIndex:(String.length-1)];
            // 判断最后一个字符
            if (s == '0' || s == '.') {
                String = [String substringToIndex:(String.length-1)];
                NSLog(@"%@",String);
            }
        }
        return String;
    }else
        return String;
}

#pragma mark 数字键盘的点击方法
-(void)numkeyboardClick:(NSString *)numStr{

    self.YLLabel.text = ([self.YLLabel.text isEqualToString:@"0"]) ? numStr :  [self.YLLabel.text stringByAppendingString:numStr];
}



#pragma mark - keyboardTextArr 惰性实例化
- (NSArray *)keyboardTextArr{

    if (_keyboardTextArr == nil) {
        _keyboardTextArr = @[@"C",@"+／-",@"%",@"÷",@"7",@"8",@"9",@"x",@"4",@"5",@"6",@"-",@"1",@"2",@"3",@"+",@"0",@".",@"="];
    }
    return _keyboardTextArr;
}

@end
