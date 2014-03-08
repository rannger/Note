//
//  DB.h
//  Note
//
//  Created by rannger on 14-3-8.
//  Copyright (c) 2014年 rannger. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface DB : NSObject
+ (void)createTables;
+ (FMDatabase*)getDB;
@end
