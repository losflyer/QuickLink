//
//  YH_Log.m
//  YH_FRAME
//
//  Created by Leo on 14-5-23.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import "YH_Log.h"

@implementation YH_Log

+ (void)logErrorWithFormat:(NSString *)format, ... {
    if (LOG_FLAG_ERROR & LOG_LEVEL) {
        format = [NSString stringWithFormat:@"[ERROR] %@", format];
        va_list args;
        va_start(args, format);
        NSLogv(format, args);
        va_end(args);
    }
}

+ (void)logWarningWithFormat:(NSString *)format, ... {
    if (LOG_FLAG_WARN & LOG_LEVEL) {
        format = [NSString stringWithFormat:@"[WARNING] %@", format];
        va_list args;
        va_start(args, format);
        NSLogv(format, args);
        va_end(args);
    }
}

+ (void)logInfoWithFormat:(NSString *)format, ... {
    if (LOG_FLAG_WARN & LOG_LEVEL) {
        format = [NSString stringWithFormat:@"[INFO] %@", format];
        va_list args;
        va_start(args, format);
        NSLogv(format, args);
        va_end(args);
    }
}
@end
