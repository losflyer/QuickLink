//
//  YH_Global.m
//  YH_FRAME
//
//  Created by Leo on 14-5-23.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import "Global.h"

@implementation Global
+ (Global *)sharedInstance
{
    static Global *sharedGlobalInstance = nil;
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedGlobalInstance = [[Global alloc] init];
    });
    return sharedGlobalInstance;
}

-(NSManagedObjectContext*)getCurrentManagedObjectContext
{
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    return context;
}
@end
