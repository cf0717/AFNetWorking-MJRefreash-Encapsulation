//
//  CFSendNet.h
//  AFN网络封装
//
//  Created by chaofan on 2016/11/15.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

@interface CFSendNet : NSObject

/**
 发送网络请求
 
 @param manager 请求管理者
 @param urlStr 请求网址
 @param parameter 请求参数
 @param completion 请求成功返回
 @param faild 请求失败返回
 */
+(void)sendNetAFNManger:(AFHTTPSessionManager *)manager urlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter completion:(void(^)(NSDictionary *dict))completion faild:(void(^)(NSError *error))faild;


/**
 结束任务
 */
+(void)cancelAFNManger:(AFHTTPSessionManager *)manager;



@end
