//
//  NSMutableDictionary +SetObjectForFormat.h
//  QuickLink
//
//  Created by Leo on 14-7-20.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(setObjectForFormat)



//写入文本数据
- (void)setTextWithKey:(NSString *)key andInfo:(NSDictionary *)info andInfoKey:(NSString *)infoKey;

@end


