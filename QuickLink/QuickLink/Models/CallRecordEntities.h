//
//  CallRecordEntities.h
//  QuickLink
//
//  Created by Tiger on 14-7-22.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CallRecordEntities : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * time;

@end
