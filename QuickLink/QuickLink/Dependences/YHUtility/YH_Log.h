//
//  YH_Log.h
//  YH_FRAME
//
//  Created by Leo on 14-5-23.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LOG_FLAG_ERROR    (1 << 0)  // 0...0001
#define LOG_FLAG_WARN     (1 << 1)  // 0...0010
#define LOG_FLAG_INFO     (1 << 2)  // 0...0100

#define LOG_LEVEL_OFF     0
#define LOG_LEVEL_ERROR   (LOG_FLAG_ERROR)                                     // 0...0001
#define LOG_LEVEL_WARN    (LOG_FLAG_ERROR | LOG_FLAG_WARN)                    // 0...0011
#define LOG_LEVEL_INFO    (LOG_FLAG_ERROR | LOG_FLAG_WARN | LOG_FLAG_INFO)  // 0...0111

#ifdef DEBUG
#define LOG_LEVEL     LOG_LEVEL_INFO
#else
#define LOG_LEVEL     LOG_LEVEL_ERROR
#endif

#define LogError(frmt, ...)   [Log logErrorWithFormat:(frmt), ##__VA_ARGS__]
#define LogWarning(frmt, ...) [Log logWarningWithFormat:(frmt), ##__VA_ARGS__]
#define LogInfo(frmt, ...)    [Log logInfoWithFormat:(frmt), ##__VA_ARGS__]

@interface YH_Log : NSObject

+ (void)logErrorWithFormat:(NSString *)format, ...;
+ (void)logWarningWithFormat:(NSString *)format, ...;
+ (void)logInfoWithFormat:(NSString *)format, ...;
@end