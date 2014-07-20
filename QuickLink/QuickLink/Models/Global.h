//
//  YH_Global.h
//  YH_FRAME
//
//  Created by Leo on 14-5-23.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

@property (nonatomic, assign) BOOL isFirstRun;
+ (Global *)sharedInstance;
-(NSManagedObjectContext*)getCurrentManagedObjectContext;
@end
