//
//  YH_SystemStart.m
//  YH_FRAME
//
//  Created by Leo on 14-5-23.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import "YH_SystemStart.h"

@implementation YH_SystemStart
#pragma mark - Start
//系统启动 (这个方法无特殊情况请不要修改， 如果增加启动函数，
//请在 SystemStartBySync/SystemStartByAsync 中添加
+(BOOL)SystemStart
{
    [YH_SystemStart SystemStartBySync];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [YH_SystemStart SystemStartByAsync];
    });
    return YES;
}

//同步启动
+(BOOL)SystemStartBySync
{

    
    return YES;
}


//异步启动
+(void)SystemStartByAsync
{

}
@end
