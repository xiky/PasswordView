//
//  ViewController.m
//  passDemo
//
//  Created by lqb on 2017/10/11.
//  Copyright © 2017年 lqb. All rights reserved.
//

#import "ViewController.h"
#import "AlertViewController.h"


#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kPAYMENT_WIDTH kSCREEN_WIDTH-80

static NSInteger const kPasswordCount = 6;

static CGFloat const kTitleHeight     = 46.f;
static CGFloat const kDotWidth        = 10;
static CGFloat const kKeyboardHeight  = 216;
static CGFloat const kAlertHeight     = 200;
static CGFloat const kCommonMargin    = 100;

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) NSMutableArray <UILabel *> *pwdIndicators;
@property (nonatomic, strong) UILabel *subLab;


@property (nonatomic, copy) void (^completeHandle)(NSString *inputPwd);
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 84, kSCREEN_WIDTH, 30);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"第二步, 设置交易密码";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:_titleLabel];
    
    _subLab = [[UILabel alloc] init];
    _subLab.frame = CGRectMake(0, 144, kSCREEN_WIDTH, 20);
    _subLab.textAlignment = NSTextAlignmentCenter;
    _subLab.text = @"请设置交易密码";
    _subLab.textColor = [UIColor lightGrayColor];
    _subLab.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:_subLab];
    
    
    [self.view addSubview:self.inputView];
    [self.inputView addSubview:self.pwdTextField];
    self.completeHandle = ^(NSString *inputPwd) {
        NSLog(@"密码是%@",inputPwd);
    };
    
    CGFloat width = self.inputView.bounds.size.width/kPasswordCount;
    for (int i = 0; i < kPasswordCount; i ++) {
        UILabel *dot = [[UILabel alloc] initWithFrame:CGRectMake((width-kDotWidth)/2.f + i*width, (self.inputView.bounds.size.height-kDotWidth)/2.f, kDotWidth, kDotWidth)];
        dot.backgroundColor = [UIColor blackColor];
        dot.backgroundColor = [UIColor greenColor];
        dot.layer.cornerRadius = kDotWidth/2.;
        dot.clipsToBounds = YES;
        dot.hidden = YES;
        [self.inputView addSubview:dot];
        [self.pwdIndicators addObject:dot];
        if (i == kPasswordCount-1) {
            continue;
        }
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake((i+1)*width, 0, 1.0f, self.inputView.bounds.size.height)];
        line.backgroundColor = [UIColor colorWithRed:0.59 green:0.61 blue:0.75 alpha:1.];
//        line.backgroundColor = [UIColor redColor];
        [self.inputView addSubview:line];
    }
    
    [_pwdTextField becomeFirstResponder];
}

#pragma mark - delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= kPasswordCount && string.length) {
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    
    return YES;
}


#pragma mark - action

- (void)textDidChange:(UITextField *)textField {
    [self setDotWithCount:textField.text.length];
    if (textField.text.length == 6) {
        if (self.completeHandle) {
            self.completeHandle(textField.text);
        }
    }
}

- (void)setDotWithCount:(NSInteger)count {
    for (UILabel *dot in self.pwdIndicators) {
        dot.hidden = YES;
    }
    
    for (int i = 0; i< count; i++) {
        ((UILabel*)[self.pwdIndicators objectAtIndex:i]).hidden = NO;
    }
}



- (UIView *)inputView {
    if (_inputView == nil) {
        _inputView = [[UIView alloc]initWithFrame:CGRectMake(15, 184, kSCREEN_WIDTH-30, (kPAYMENT_WIDTH-30)/6)];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.layer.borderWidth = 1.f;
        _inputView.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.].CGColor;
    }
    return _inputView;
}
- (UITextField *)pwdTextField {
    if (_pwdTextField == nil) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _pwdTextField.hidden = YES;
        _pwdTextField.delegate = self;
        _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_pwdTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _pwdTextField;
}

- (NSMutableArray *)pwdIndicators {
    if (_pwdIndicators == nil) {
        _pwdIndicators = [[NSMutableArray alloc] init];
    }
    return _pwdIndicators;
}

@end
