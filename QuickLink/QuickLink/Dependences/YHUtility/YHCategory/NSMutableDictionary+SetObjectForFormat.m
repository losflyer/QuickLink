//
//  NSMutableDictionary +SetObjectForFormat.m
//  QuickLink
//
//  Created by Leo on 14-7-20.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import "NSMutableDictionary+SetObjectForFormat.h"

@implementation NSMutableDictionary (setObjectForDatabase)

//写入文本数据
- (void)setTextWithKey:(NSString *)key andInfo:(NSDictionary *)info andInfoKey:(NSString *)infoKey
{
    NSString *value = [info objectForKey:infoKey];
    
    if (!value)
    {
        value = @"";
    }
    
    [self setObject:value forKey:key];
}
@end
