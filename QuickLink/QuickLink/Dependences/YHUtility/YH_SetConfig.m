//
//  YH_Setting.m
//  QuickLink
//
//  Created by Leo on 14-7-20.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import "YH_SetConfig.h"
#import "NSMutableDictionary+SetObjectForFormat.h"


@implementation YH_SetConfig


//获取实例
static YH_SetConfig * instance;

+ (YH_SetConfig *)sharedInstance
{
    static YH_SetConfig *sharedSetConfigInstance = nil;
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedSetConfigInstance = [[YH_SetConfig alloc] init];
    });
    return sharedSetConfigInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}


#pragma mark -
#pragma mark - Load data

//将设置信息从资源文件同步至应用
+ (void)registerDefaultsWithContentOfFile:(NSString *)name
{
  
}

#pragma mark - Handle parameter

//根据关键字读取对应的设置信息
- (id)parameterForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

//根据关键字保存对应的设置信息
- (void)setParameter:(id)value forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

//根据关键字读取对应的设置信息
+ (id)parameterForKey:(NSString *)key
{
    return [[YH_SetConfig sharedInstance] parameterForKey:key];
}

//根据关键字保存对应的设置信息
+ (void)setParameter:(id)value forKey:(NSString *)key
{
    [[YH_SetConfig sharedInstance] setParameter:value forKey:key];
}

@end
