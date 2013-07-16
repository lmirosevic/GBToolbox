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
@property (assign, nonatomic) BOOL                              isShowingEmpty;

@end

@implementation GBTableViewController

#pragma mark - CA

-(void)setEmptyView:(UIView *)emptyView {
    if (_emptyView != emptyView) {
        //if we're already showing one
        if (self.isShowingEmpty) {
            //remove the old one
            [self _removeEmptyView];
            
            //assign it
            _emptyView = emptyView;
            
            //show the new one
            [self _addEmptyView];
        }
        else {
            //assign it
            _emptyView = emptyView;
        }
    }
}

-(void)setIsShowingEmpty:(BOOL)isShowingEmpty {
    if (_isShowingEmpty != isShowingEmpty) {
        _isShowingEmpty = isShowingEmpty;
    
        if (isShowingEmpty) {
            [self _addEmptyView];
        }
        else {
            [self _removeEmptyView];
        }
    }
}

#pragma mark - Life

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

#pragma mark - API

-(void)clearEmpty {
    self.isShowingEmpty = NO;
}

-(void)handleEmpty {
    self.isShowingEmpty = [self _isTableEmpty];
}

#pragma mark - util

-(BOOL)_isTableEmpty {
    NSUInteger sections = [self.tableView numberOfSections];
    for (NSUInteger i=0; i<sections; i++) {
        if ([self.tableView numberOfRowsInSection:i] > 0) {
            return NO;
        }
    }
    
    //if we got here it's empty
    return YES;
}

-(void)_addEmptyView {
    self.emptyView.center = self.view.center;
    [self.view addSubview:self.emptyView];
}

-(void)_removeEmptyView {
    [self.emptyView removeFromSuperview];
}

@end
