//
//  GBTableViewController.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 14/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView       *tableView;
@property (assign, nonatomic) BOOL              clearsSelectionOnViewWillAppear;// defaults to YES. If YES, any selection is cleared in viewWillAppear:
@property (strong, nonatomic) UIView            *emptyView;

-(id)initWithStyle:(UITableViewStyle)style;

-(void)clearEmpty;//don't show the empty (e.g. if you have an error condition and you want to show an error message instead)
-(void)handleEmpty;

//for subclasses to override
-(Class)classForTableView;
-(void)tableView:(UITableView *)tableView didBeginFullyDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView didEndFullyDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
