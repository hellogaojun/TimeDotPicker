//
//  HRPickerView.m
//  hr
//
//  Created by bfd on 2018/3/6.
//  Copyright © 2018年 GJ. All rights reserved.
//

#import "HRPickerView.h"
#import "UIView+frame.h"

#define APP_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

@interface HRPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (nonatomic, strong) UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *holderView;
@property (weak, nonatomic) IBOutlet UIView *separateLine;

@property (nonatomic,strong) NSMutableArray *timeDotArray;
@property (nonatomic,strong) NSMutableArray *emptyArray;
@end

@implementation HRPickerView

#pragma mark - 设置UI

//xib设置的 self.holderView总高度为260，pickView高度为210
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupCenterView];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    
    [self.cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.ensureBtn addTarget:self action:@selector(ensureClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


///设置中间View
- (void)setupCenterView {
    CGFloat itemWidth = (APP_WIDTH - 10 -70 - 70 *2)/4.0;
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 + 85, APP_WIDTH, 42)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    [self.holderView insertSubview:self.bottomView atIndex:0];
    
    //left :
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(itemWidth + 70 - 13, -3, 10, 42)];
    label1.text = @":";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = RGBA(50, 50, 50, 1);
    label1.tag = 100;
    [self.bottomView addSubview:label1];
    
    //center ————
    UILabel *label0 = [[UILabel alloc]initWithFrame:CGRectMake(0, -3, 60, 42)];
    label0.text = @"——";
    label0.textAlignment = NSTextAlignmentCenter;
    label0.textColor = RGBA(50, 50, 50, 1);
    label0.tag = 200;
    [self.bottomView addSubview:label0];
    label0.centerX = self.bottomView.centerX;
    
    CGFloat rightPadding = 50;
    if (APP_WIDTH == 320) {
        rightPadding = 35;
    } else if (APP_WIDTH == 414) {
        rightPadding = 60;
    }
    //right :
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label0.frame) + rightPadding , -3, 10, 42)];
    label2.text = @":";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = RGBA(50, 50, 50, 1);
    label2.tag = 300;
    [self.bottomView addSubview:label2];
}


+ (instancetype)pickView {
    HRPickerView *pickView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    return pickView;
}

- (void)setupHeadStyleWithLeftColor:(UIColor *)leftColor leftFont:(UIFont *)leftFont rightColor:(UIColor *)rightClor rightFont:(UIFont *)rightFont separateColor:(UIColor *)separateColor {
    [self.cancelBtn setTitleColor:leftColor forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = leftFont;
    [self.ensureBtn setTitleColor:rightClor forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = rightFont;
    self.separateLine.backgroundColor = separateColor;
}

- (void)setLineColor:(UIColor *)lineColor colonColor:(UIColor *)colonColor {
    UILabel *label1 = [self.bottomView viewWithTag:100];
    label1.textColor = colonColor;
    
    UILabel *label0 = [self.bottomView viewWithTag:200];
    label0.textColor = lineColor;
    
    UILabel *label2 = [self.bottomView viewWithTag:300];
    label2.textColor = colonColor;
}

#pragma mark - btn action
- (void)cancelClick:(UIButton *)btn {
    [self removeFromSuperview];
}

- (void)ensureClick:(UIButton *)btn {
    if (self.pickerEnsureBlock) {
        self.pickerEnsureBlock(self.timeDotArray[[self.pickView selectedRowInComponent:0]], self.timeDotArray[[self.pickView selectedRowInComponent:2]], self.timeDotArray[[self.pickView selectedRowInComponent:4]], self.timeDotArray[[self.pickView selectedRowInComponent:6]]);
    }
    
    [self removeFromSuperview];
}

#pragma mark - UIPickerView delegate and dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 7;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.timeDotArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = @"";
    if (component == 1 || component == 3 || component == 5) {
        title = self.emptyArray[row];
    } else {
        title = self.timeDotArray[row];
    }
    return title;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.height < 1) {
            obj.backgroundColor = self.pickerLineColor ? self.pickerLineColor() : RGBA(232, 232, 232, 1);
        }
    }];
    
    CGFloat width = [self pickerView:self.pickView widthForComponent:component];
    CGFloat rowheight = [self pickerView:self.pickView rowHeightForComponent:(component)];
    
    UIView *myView = [[UIView alloc]init];
    myView.frame = CGRectMake(0.0f, 0.0f, width, rowheight);
    UILabel *txtlabel = [[UILabel alloc] init];
    txtlabel.textColor = self.pickerUnhighlightedTextColor ? self.pickerUnhighlightedTextColor() : RGBA(153, 153, 153, 1);
    txtlabel.font = self.pickerUnhighlightedTextFont ? self.pickerUnhighlightedTextFont() : [UIFont systemFontOfSize:12];
    txtlabel.textAlignment = NSTextAlignmentCenter;
    txtlabel.frame = myView.frame;
    txtlabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    [myView addSubview:txtlabel];
    
    UIView *subview = [self.pickView.subviews firstObject];
    for ( UIView *pickerColumnView in subview.subviews) {
        UIView *pickerView = [pickerColumnView.subviews lastObject];
        UIView *tableView = [pickerView.subviews lastObject];
//        tableView.transform = CGAffineTransformMakeTranslation(15, 0);
        
        for (UIView *cell in tableView.subviews) {
            UIView *cellview = [cell.subviews lastObject];
            UIView *labelSuper = [cellview.subviews lastObject];
            UILabel *label = [labelSuper.subviews lastObject];
            label.textColor = self.pickerHighlightedTextLineColor ? self.pickerHighlightedTextLineColor() : RGBA(50, 50, 50, 1);
            label.font = self.pickerUnhighlightedTextFont ? self.pickerUnhighlightedTextFont() : [UIFont systemFontOfSize:13];
        }
    }
    
    return myView;

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 42.f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 1 || component == 5) {
        return 5;
    } else if (component == 3) {
        return 70;
    } else {
        return (APP_WIDTH - 10 -70 - 70 *2)/4.0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"tap %zd row,%zd componment",row,component);
}


#pragma mark - lazy loading

- (NSMutableArray *)timeDotArray {
    if (!_timeDotArray) {
        _timeDotArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 24; i++) {
            NSString *str = [NSString stringWithFormat:@"%02zd",i];
            [_timeDotArray addObject:str];
        }
    }
    return _timeDotArray;
}

- (NSMutableArray *)emptyArray {
    if (!_emptyArray) {
        _emptyArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 24; i++) {
            [_emptyArray addObject:@""];
        }
    }
    return _emptyArray;
}


@end
