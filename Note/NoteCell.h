//
//  NoteCell.h
//  Note
//
//  Created by rannger on 14-3-8.
//  Copyright (c) 2014年 rannger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteCell : UITableViewCell
{
    UITextField* textField;
}
@property (nonatomic,strong) UITextField* textField;

+ (CGFloat)height4Cell;
@end
