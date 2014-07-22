//
//  YH_Utils.m
//  QuickLink
//
//  Created by Leo on 14-7-22.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import "YH_Utils.h"

@implementation YH_Utils


+(BOOL)callByPhoneNumer:(NSString*)phoneNumber
{
    if (!phoneNumber || phoneNumber.length< 1) {
        return NO;
    }
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phoneNumber];
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    [[UIApplication sharedApplication] openURL:url];
    return YES;
}


@end
