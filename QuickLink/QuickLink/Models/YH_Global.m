//
//  YH_Global.m
//  YH_FRAME
//
//  Created by Leo on 14-5-23.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import "YH_Global.h"

@implementation YH_Global
+ (YH_Global *)sharedInstance
{
    static YH_Global *sharedGlobalInstance = nil;
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedGlobalInstance = [[YH_Global alloc] init];
    });
    return sharedGlobalInstance;
}
@end
