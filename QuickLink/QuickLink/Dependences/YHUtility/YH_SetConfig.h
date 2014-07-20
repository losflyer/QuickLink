//
//  YH_Setting.h
//  QuickLink
//
//  Created by Leo on 14-7-20.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YH_SetConfig : NSObject
//获取类实例
+ (YH_SetConfig *)sharedInstance;

//将设置信息从资源文件同步至应用
+ (void)registerDefaultsWithContentOfFile:(NSString *)name;


//根据关键字读取对应的设置信息
- (id)parameterForKey:(NSString *)key;

//根据关键字保存对应的设置信息
- (void)setParameter:(id)value forKey:(NSString *)key;


//根据关键字读取对应的设置信息
+ (id)parameterForKey:(NSString *)key;

//根据关键字保存对应的设置信息
+ (void)setParameter:(id)value forKey:(NSString *)key;

@end
