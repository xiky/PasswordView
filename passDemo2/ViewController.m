//
//  ViewController.m
//  passDemo2
//
//  Created by lqb on 2017/10/11.
//  Copyright © 2017年 lqb. All rights reserved.
//

#import "ViewController.h"
#import "JKInputView.h"

#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define RGBCOLOR(c)                [UIColor colorWithRed:((c>>16)&0xFF)/255.0    \
green:((c>>8)&0xFF)/255.0    \
blue:((c>>0)&0xFF)/255.0    \
alpha:1]

@interface ViewController ()

@property (nonatomic, strong) UILabel       *titleLab;
@property (nonatomic, strong) UILabel       *subLab;
@property (nonatomic, strong) JKInputView   *textField;
@property (nonatomic, strong) UIButton      *sureBtn;
@property (nonatomic, strong) UIButton      *cancelBtn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.frame = CGRectMake(0, 84, kSCREEN_WIDTH, 30);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = @"第二步, 设置交易密码";
    _titleLab.textColor = [UIColor blackColor];
    _titleLab.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:_titleLab];
    
    _subLab = [[UILabel alloc] init];
    _subLab.frame = CGRectMake(0, CGRectGetMaxY(_titleLab.frame) + 60, kSCREEN_WIDTH, 20);
    _subLab.textAlignment = NSTextAlignmentCenter;
    _subLab.text = @"请设置交易密码";
    _subLab.textColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1.];
    _subLab.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:_subLab];
    
    _textField = [[JKInputView alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(_subLab.frame) + 20, kSCREEN_WIDTH - 50, 60)];
    _textField.borderSpace = 5;
    _textField.ciphertext = @"●";
    _textField.borderColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1.];
    [self.view addSubview:_textField];
    
    __weak typeof(self) weakSelf = self;
    _textField.currentBlock = ^(NSString *currentPayCodeString, NSString *currentInputString) {
        NSLog(@"%@ --- %@ --- %@", currentPayCodeString, currentInputString, weakSelf.textField.payCodeString);
    };
    _textField.finishedBlock = ^(NSString *payCodeString) {
        NSLog(@"%@", payCodeString);
    };
    
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.backgroundColor = RGBCOLOR(0x4490ff);
    _sureBtn.frame = CGRectMake(18, CGRectGetMaxY(_textField.frame) + 60, kSCREEN_WIDTH - 36, 44);
    [_sureBtn setTitle:@"确认设置" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15.];
    _sureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _sureBtn.layer.cornerRadius = 4;
    _sureBtn.layer.masksToBounds = YES;
    [_sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
    
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.backgroundColor = [UIColor whiteColor];
    _cancelBtn.frame = CGRectMake(18, CGRectGetMaxY(_sureBtn.frame), kSCREEN_WIDTH - 36, 44);
    [_cancelBtn setTitle:@"我先看看" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:RGBCOLOR(0x4490ff) forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.];
    _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_sureBtn];
    [self.view addSubview:_cancelBtn];
}

- (void)cancelClick:(UIButton *)btn {
    
    [self.view endEditing:YES];
}

- (void)sureClick:(UIButton *)btn {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
