//
//  MasterViewController.m
//  Note
//
//  Created by rannger on 14-3-8.
//  Copyright (c) 2014年 rannger. All rights reserved.
//

#import "MasterViewController.h"
#import "NoteObject.h"
#import "NoteCell.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    BOOL editing;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _objects = [[NSMutableArray alloc] initWithArray:[NoteObject noteObjectsFromDatabase]];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (IsArrayWithAnyObj(_objects)) {
        NoteObject* object=_objects[0];
        if (editing) {
            [object save];
        }
    }
    NoteObject* obj=[[NoteObject alloc] init];
    obj.date=[NSDate date];
    obj.noteText=@"";
    [_objects insertObject:obj atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    editing=YES;
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (IsArrayWithAnyObj(_objects)) {
        NoteObject* object=_objects[0];
        if (editing) {
            [object save];
        }
    }
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    cell.textField.delegate=self;
    NoteObject *object = _objects[indexPath.row];
    cell.textField.text = object.noteText;
    cell.textField.tag=indexPath.row;
    NSDateFormatter* formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.textLabel.text = [formatter stringFromDate:object.date];
    if (editing) {
        if (indexPath.row==0) {
            [cell.textField becomeFirstResponder];
        }
    }

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NoteCell height4Cell];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NoteObject* object=_objects[indexPath.row];
        [object remove];
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    editing=NO;
    NoteObject *object = _objects[textField.tag];
    object.noteText=textField.text;
    [object save];
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    editing=YES;
    return YES;
}

@end
