//
//  DB.m
//  Note
//
//  Created by rannger on 14-3-8.
//  Copyright (c) 2014年 rannger. All rights reserved.
//

#import "DB.h"
#import "NSString+Path.h"
#import "FMDatabase.h"

@interface DB ()

+ (NSString*)databasePath;

@end

@implementation DB

+ (NSString*)databasePath
{
    static NSString* databaseName=@"Database.sqlite";
    return [[NSString documentsDirectory] stringByAppendingPathComponent:databaseName];
}

+ (FMDatabase*)getDB
{
    FMDatabase* db= [FMDatabase databaseWithPath:[[self class] databasePath]];
    [db open];
    return db;
}

+ (void)createTables
{
    static NSString* sql=@"CREATE TABLE IF NOT EXISTS NOTE (ID TEXT NOT NULL PRIMARY KEY,"
	"NOTE TEXT DEFAULT '' NOT NULL,"
	"SAVEDATE TEXT NOT NULL);";
    FMDatabase* db=[DB getDB];
    [db executeUpdate:sql];
    if ([db hadError]) {
        NSLog(@"%@",[db lastError]);
    }
    [db close];
}

@end
