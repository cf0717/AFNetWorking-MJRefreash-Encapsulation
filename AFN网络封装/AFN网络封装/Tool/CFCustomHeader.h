//
//  CFCustomHeader.h
//  AFN网络封装
//
//  Created by chaofan on 2016/11/15.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"

@interface CFCustomHeader : MJRefreshNormalHeader

+(instancetype)customHeaderTarget:(id)target selector:(SEL)selector;

@end
