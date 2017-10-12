//
//  JKTextField.m
//  passDemo2
//
//  Created by lqb on 2017/10/11.
//  Copyright © 2017年 lqb. All rights reserved.
//

#import "JKTextField.h"

@implementation JKTextField
// 禁止复制粘贴功能
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    
    return NO;
}


@end
