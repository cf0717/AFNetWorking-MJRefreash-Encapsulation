//
//  CFDataModel.m
//  AFN网络封装
//
//  Created by chaofan on 2016/11/15.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "CFDataModel.h"

@implementation CFDataModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        //解析数据
        self.ID = dict[@"id"];
        self.titleStr = dict[@"title"];
        self.thumbStr = dict[@"thumb"];
        self.introStr = dict[@"introduction"];
        self.timeStr = dict[@"createAt"];
    }
    return self;
}

+(instancetype)dataModelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

+(NSMutableArray *)dataModelWithArray:(NSArray *)dataArr
{
    NSMutableArray *dataMutArr = [NSMutableArray array];
    for (int i = 0; i < dataArr.count; i++) {
        CFDataModel *dataModel = [self dataModelWithDict:dataArr[i]];
        [dataMutArr addObject:dataModel];
    }
    return dataMutArr;
}

@end
