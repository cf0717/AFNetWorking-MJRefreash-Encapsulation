//
//  CFCustomFooter.m
//  AFN网络封装
//
//  Created by chaofan on 2016/11/15.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "CFCustomFooter.h"

@implementation CFCustomFooter

+(instancetype)customFooterTarget:(id)target selector:(SEL)selector
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:selector];
    
    // 样式设置
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    footer.stateLabel.textColor = [UIColor blueColor];
    
    return (CFCustomFooter *)footer;
}


@end
