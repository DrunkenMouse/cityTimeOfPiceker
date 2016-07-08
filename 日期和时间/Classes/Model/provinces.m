//
//  provinces.m
//  日期和时间
//
//  Created by 王奥东 on 16/3/12.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "provinces.h"

@implementation provinces
+(NSArray *)provincesWithFile:(NSString *)fileName{
    
    NSMutableArray *arrys = [NSMutableArray array];
    NSArray *file = [NSArray arrayWithContentsOfFile:fileName];
    for (NSDictionary *dict in file) {
        provinces * model = [[provinces alloc]initWtihDict:dict];
        [arrys addObject:model];
    }
    return arrys;
}
/**
 *  模型初始化实现
 */
-(instancetype)initWtihDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)provinceWihDict:(NSDictionary *)dict{
    return [[self alloc]initWtihDict:dict];
}

@end
