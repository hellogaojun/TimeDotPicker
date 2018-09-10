//
//  HRPickerView.h
//  hr
//
//  Created by bfd on 2018/3/6.
//  Copyright © 2018年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>


/// 时间选择器
@interface HRPickerView : UIView

/**
 picker 确定操作的回调
 */
@property (nonatomic, copy) void (^pickerEnsureBlock)(NSString *startHour,NSString *startMinute,NSString *endHour,NSString *endMinute);

/**
 picker显示的两根线
 */
@property (nonatomic, copy) UIColor *(^pickerLineColor)(void);

/**
 picker灰度文本
 */
@property (nonatomic, copy) UIColor *(^pickerUnhighlightedTextColor)(void);

/**
 picker亮度文本
 */
@property (nonatomic, copy) UIColor *(^pickerHighlightedTextLineColor)(void);

/**
 快速初始化

 */
+ (instancetype)pickView;


/**
 设置头部风格

 @param leftColor [取消]颜色
 @param leftFont [取消]字号
 @param rightClor [确定]颜色
 @param rightFont [确定]字号
 */
- (void)setupHeadStyleWithLeftColor:(UIColor *)leftColor
                           leftFont:(UIFont *)leftFont rightColor:(UIColor *)rightClor rightFont:(UIFont *)rightFont;

/**
 设置冒号和中间横线颜色

 @param lineColor 中间横线
 @param colonColor 冒号
 */
- (void)setLineColor:(UIColor *)lineColor colonColor:(UIColor *)colonColor;

@end
