//
//  provinces.h
//  日期和时间
//
//  Created by 王奥东 on 16/3/12.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface provinces : UIView
@property(strong,nonatomic)NSArray * cities;
/**
 *  省
 */
@property(copy,nonatomic)NSString * name;

/**
 *  模型的懒加载声明
 *  需要一个文件路径与模型名字
 */
+(NSArray *)provincesWithFile:(NSString *)fileName;
/**
 *  模型的初始化声明
 */
-(instancetype)initWtihDict:(NSDictionary *)dict;
+(instancetype)provinceWihDict:(NSDictionary *)dict;
@end
