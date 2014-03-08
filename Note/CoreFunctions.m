//
//  CoreFunctions.c
//  Note
//
//  Created by rannger on 14-3-8.
//  Copyright (c) 2014年 rannger. All rights reserved.
//

#import "CoreFunctions.h"

BOOL IsStringWithAnyText(NSString* string)
{
    return [string isKindOfClass:[NSString class]]&&[string length]>0;
}

BOOL IsArrayWithAnyObj(NSArray* list)
{
    return [list isKindOfClass:[NSArray class]]&&[list count]>0;
}
