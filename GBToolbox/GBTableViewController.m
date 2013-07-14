//
//  GBTableViewController.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 14/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBTableViewController.h"

#import "GBMacros_Common.h"

static BOOL const kDefaultClearsSelectionOnViewWillAppear =     YES;

@interface GBTableViewController ()

@property (assign, nonatomic) UITableViewStyle                  tableViewStyle;

@end

@implementation GBTableViewController

-(id)initWithStyle:(UITableViewStyle)style {
    if (self = [super init]) {
        self.tableViewStyle = style;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.clearsSelectionOnViewWillAppear = kDefaultClearsSelectionOnViewWillAppear;
    }
    
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //tableview
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (self.clearsSelectionOnViewWillAppear) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
}

@end
