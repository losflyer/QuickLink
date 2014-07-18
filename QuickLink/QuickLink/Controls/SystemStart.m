//
//  YH_SystemStart.m
//  YH_FRAME
//
//  Created by Leo on 14-5-23.
//  Copyright (c) 2014年 YOHO. All rights reserved.
//

#import "SystemStart.h"

@implementation SystemStart
#pragma mark - Start
//系统启动 (这个方法无特殊情况请不要修改， 如果增加启动函数，
//请在 SystemStartBySync/SystemStartByAsync 中添加
+(BOOL)SystemStart
{
    [SystemStart SystemStartBySync];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [SystemStart SystemStartByAsync];
    });
    return YES;
}

//同步启动
+(BOOL)SystemStartBySync
{
    [SystemStart getContacts];
    return YES;
}
+(void)getContacts
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"csv"];
    NSError * error;
    NSString *contents = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSArray *contentsArray = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSInteger idx;
    for (idx = 0; idx < contentsArray.count; idx++) {
        NSString* currentContent = [contentsArray objectAtIndex:idx];
        NSArray* singleContactArray = [currentContent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
        [SystemStart addDataToDB:singleContactArray];
        
        
    }
}

+(void)addDataToDB:(NSArray*)contactArray
{
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
   
    
    NSManagedObject *contactInfo = [NSEntityDescription insertNewObjectForEntityForName:@"ContactsEntities" inManagedObjectContext:context];
    [contactInfo setValue:contactArray[0] forKey:@"department"];
    [contactInfo setValue:contactArray[1] forKey:@"name"];
    [contactInfo setValue:contactArray[2] forKey:@"number"];
    
    
    
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
}

//异步启动
+(void)SystemStartByAsync
{

}
@end
