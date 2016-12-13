//
//  CFCustomHeader.m
//  AFN网络封装
//
//  Created by chaofan on 2016/11/15.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "CFCustomHeader.h"

@implementation CFCustomHeader

+(instancetype)customHeaderTarget:(id)target selector:(SEL)selector
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:selector];
    
    // 样式设置
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    return (CFCustomHeader *)header;
}


@end
