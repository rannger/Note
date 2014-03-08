//
//  NoteObject.m
//  Note
//
//  Created by rannger on 14-3-8.
//  Copyright (c) 2014年 rannger. All rights reserved.
//

#import "NoteObject.h"
#import "NSString+UUID.h"
#import "DB.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"


@implementation NoteObject
@synthesize primaryId;
@synthesize noteText;
@synthesize date;

- (BOOL)save
{
    return IsStringWithAnyText(primaryId)?[self update]:[self insert];
}

- (BOOL)insert
{
    static NSString* sqlTemplate=@"INSERT INTO NOTE (ID,NOTE,SAVEDATE)"
    "VALUES"
    "('%@','%@','%@')";
    self.primaryId=[NSString GetUUID];
    NSAssert(self.date!=nil, @"");
    NSDateFormatter* formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString=[formatter stringFromDate:self.date];
    NSString* noteString=self.noteText;
    if (!IsStringWithAnyText(noteString)) {
        noteString=@"";
    }
    NSString* sql=[NSString stringWithFormat:sqlTemplate,self.primaryId,noteString,dateString];
    FMDatabase* db=[DB getDB];
    BOOL retval=[db executeUpdate:sql];
    if ([db hadError]) {
        NSLog(@"%@",[db lastError]);
    }
    
    [db close];
    
    return retval;
}

- (BOOL)update
{
    static NSString* sqlTemplate=@"UPDATE NOTE SET NOTE='%@',SAVEDATE='%@' WHERE ID='%@'";
    NSAssert(IsStringWithAnyText(self.primaryId), @"");
    NSDateFormatter* formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString=[formatter stringFromDate:self.date];
    NSString* noteString=self.noteText;
    if (!IsStringWithAnyText(noteString)) {
        noteString=@"";
    }
    NSString* sql=[NSString stringWithFormat:sqlTemplate,noteString,dateString,self.primaryId];
    FMDatabase* db=[DB getDB];
    BOOL retval=[db executeUpdate:sql];
    if ([db hadError]) {
        NSLog(@"%@",[db lastError]);
    }
    
    [db close];
    
    return retval;
}

- (BOOL)remove
{
    static NSString* sqlTemplate=@"DELETE FROM NOTE WHERE ID='%@'";
    BOOL retval=NO;
    if (!IsStringWithAnyText(self.primaryId)) {
        return NO;
    }
    
    NSString* sql=[NSString stringWithFormat:sqlTemplate,self.primaryId];
    FMDatabase* db=[DB getDB];
    retval=[db executeUpdate:sql];
    if ([db hadError]) {
        NSLog(@"%@",[db lastError]);
    }
    
    [db close];

    return retval;
}

+ (NSArray*)noteObjectsFromDatabase
{
    static NSString* sql=@"SELECT ID,NOTE,SAVEDATE FROM NOTE ORDER BY STRFTIME('%Y-%m-%d %H:%M:%S',SAVEDATE) DESC";

    FMDatabase* db=[DB getDB];
    NSUInteger count = [db intForQuery:@"SELECT COUNT(ID) FROM NOTE"];
    if (count==0) {
        [db close];
        return @[];
    }
    NSMutableArray* array=[NSMutableArray arrayWithCapacity:count];
    FMResultSet* result=[db executeQuery:sql];
    while ([result next]) {
        NoteObject* object=[[NoteObject alloc] init];
        object.primaryId=[result stringForColumn:@"ID"];
        object.noteText=[result stringForColumn:@"NOTE"];
        NSDateFormatter* formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        object.date=[formatter dateFromString:[result stringForColumn:@"SAVEDATE"]];
        [array addObject:object];
    }
    [result close];
    [db close];
    return [NSArray arrayWithArray:array];
}

@end
