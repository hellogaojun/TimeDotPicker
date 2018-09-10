//
//  ViewController.m
//  TimeDotPickView
//
//  Created by bfd on 2018/9/10.
//  Copyright © 2018年 GJ. All rights reserved.
//

#import "ViewController.h"
#import "HRPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *origianlPicker = [self.view.window viewWithTag:100];
    [origianlPicker removeFromSuperview];
    
    HRPickerView *picker = [HRPickerView pickView];
    picker.tag = 100;
    picker.frame = CGRectMake(0, self.view.frame.size.height - 260, self.view.frame.size.width, 260);
    
    //此处设置你自己的风格[根据需要自己选择]
//    picker.pickerLineColor = ^UIColor *{
//        return [UIColor redColor];
//    };
//    picker.pickerHighlightedTextLineColor = ^UIColor *{
//        return [UIColor blueColor];
//    };
//    picker.pickerUnhighlightedTextFont = ^UIFont *{
//        return [UIFont systemFontOfSize:25];
//    };
//    picker.pickerUnhighlightedTextColor = ^UIColor *{
//        return [UIColor orangeColor];
//    };
//    picker.pickerHighlightedTextLineFont = ^UIFont *{
//        return [UIFont systemFontOfSize:28];
//    };
//
//    [picker setupHeadStyleWithLeftColor:[UIColor redColor] leftFont:[UIFont systemFontOfSize:13] rightColor:[UIColor blueColor] rightFont:[UIFont systemFontOfSize:16] separateColor:[UIColor greenColor]];
//    [picker setLineColor:[UIColor grayColor] colonColor:[UIColor redColor]];
    picker.pickerEnsureBlock = ^(NSString *startHour, NSString *startMinute, NSString *endHour, NSString *endMinute) {
        NSLog(@"startHour:%@,startMinute:%@,endHour:%@,endMinute:%@",startHour,startMinute,endHour,endMinute);
    };
    [self.view.window addSubview:picker];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
