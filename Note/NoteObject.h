//
//  NoteObject.h
//  Note
//
//  Created by rannger on 14-3-8.
//  Copyright (c) 2014年 rannger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteObject : NSObject
{
    NSString* primaryId;
    NSString* noteText;
    NSDate* date;
}

@property (nonatomic,copy) NSString* primaryId;
@property (nonatomic,copy) NSString* noteText;
@property (nonatomic,strong) NSDate* date;

- (BOOL)save;
- (BOOL)remove;
+ (NSArray*)noteObjectsFromDatabase;

@end
