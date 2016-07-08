//
//  ToolBar.m
//  日期和时间
//
//  Created by 王奥东 on 16/3/12.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ToolBar.h"
@implementation ToolBar
//定义三个按钮的点击事件
- (IBAction)clickPre:(id)sender {
    if ([self.dataRource respondsToSelector:@selector(clickBtn:andBtnNum:)]) {
        [self.dataRource clickBtn:self andBtnNum:ToolBarOne];
    }
}

- (IBAction)clickNext:(id)sender {
    if ([self.dataRource respondsToSelector:@selector(clickBtn:andBtnNum:)]) {
        [self.dataRource clickBtn:self andBtnNum:ToolBarTwo];
    }
}


- (IBAction)clickOver:(id)sender {
    if ([self.dataRource respondsToSelector:@selector(clickBtn:andBtnNum:)]) {
        [self.dataRource clickBtn:self andBtnNum:ToolBarThree];
    }
}

//懒加载方式返回导航栏
+(instancetype)toolbar{
    return [[[NSBundle mainBundle]loadNibNamed:@"ToolBar" owner:nil options:nil]lastObject];
}


@end
