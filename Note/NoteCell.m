//
//  NoteCell.m
//  Note
//
//  Created by rannger on 14-3-8.
//  Copyright (c) 2014年 rannger. All rights reserved.
//

#import "NoteCell.h"

@implementation NoteCell
@synthesize textField;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (textField==nil) {
        textField=[[UITextField alloc] initWithFrame:CGRectMake(15, 0, 305, 50)];
        textField.font=[UIFont boldSystemFontOfSize:20];
        textField.returnKeyType=UIReturnKeyDone;
        [self.contentView addSubview:textField];
    }

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame=self.textLabel.frame;
    frame.origin.y=50;
    frame.size.height=20;
    self.textLabel.frame=frame;
    self.textLabel.font=[UIFont systemFontOfSize:13];
    self.textLabel.backgroundColor=[UIColor clearColor];
    self.textLabel.textAlignment=NSTextAlignmentRight;
}

+ (CGFloat)height4Cell
{
    return 70;
}



@end
