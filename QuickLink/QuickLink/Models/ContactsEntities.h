//
//  ContactsEntities.h
//  QuickLink
//
//  Created by Leo on 14-7-20.
//  Copyright (c) 2014年 Cao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ContactsEntities : NSManagedObject

@property (nonatomic, retain) NSString * department;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * number;

@end
