//
//  CFSendNet.m
//  AFN网络封装
//
//  Created by chaofan on 2016/11/15.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "CFSendNet.h"

@implementation CFSendNet

+(void)sendNetAFNManger:(AFHTTPSessionManager *)manager urlStr:(NSString *)urlStr parameter:(NSDictionary *)parameter completion:(void(^)(NSDictionary *dict))completion faild:(void(^)(NSError *error))faild
{
    [manager GET:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        completion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        faild(error);
    }];
}

+(void)cancelAFNManger:(AFHTTPSessionManager *)manager
{
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

@end
