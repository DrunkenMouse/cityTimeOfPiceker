//
//  ToolBar.h
//  日期和时间
//
//  Created by 王奥东 on 16/3/12.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ToolBar;
typedef enum{
    ToolBarOne,
    ToolBarTwo,
    ToolBarThree
}ToolBarBtn;

@protocol ClickDataRource <NSObject>
//通过代理方法完成导航栏按钮的点击事件
@optional
-(void)clickBtn:(ToolBar *)Bar  andBtnNum:(ToolBarBtn)btnNum;

@end

@interface ToolBar : UIToolbar
//导航栏的三个按钮
@property(weak,nonatomic) IBOutlet UIBarButtonItem * preBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Over;
//代理对象
@property(weak,nonatomic) id<ClickDataRource> dataRource;
//懒加载方式返回导航栏
+(instancetype)toolbar;
@end
