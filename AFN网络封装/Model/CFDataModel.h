//
//  CFDataModel.h
//  AFN网络封装
//
//  Created by chaofan on 2016/11/15.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFDataModel : NSObject


/** 新闻ID */
@property (nonatomic,copy) NSString *ID;

/** 标题 */
@property (nonatomic,copy) NSString *titleStr;

/** 图片 */
@property (nonatomic,copy) NSString *thumbStr;

/** 内容 */
@property (nonatomic,copy) NSString *introStr;

/** 创建时间 */
@property (nonatomic,copy) NSString *timeStr;

//返回模型
+(instancetype)dataModelWithDict:(NSDictionary *)dict;

//返回数组
+(NSMutableArray *)dataModelWithArray:(NSArray *)dataArr;

@end
