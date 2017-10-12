//
//  JKInputItem.h
//  passDemo2
//
//  Created by lqb on 2017/10/11.
//  Copyright © 2017年 lqb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKInputItem : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *indePath;    // 需添加在 cellType 之前
@property (nonatomic, assign) NSInteger cellNum;        // 需添加在 cellType 之前

@property (nonatomic, strong) UIColor *cellBorderColor; // 设置边框颜色(默认黑色)
@property (nonatomic, copy)   NSString *titleString;    // 设置输入文本

@end
