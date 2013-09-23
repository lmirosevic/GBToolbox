//
//  GBTableViewController.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 14/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBTableViewController.h"

#import "GBMacros_Common.h"
#import "GBUtility_iOS.h"
#import "NSArray+GBToolbox.h"

static BOOL const kDefaultClearsSelectionOnViewWillAppear =     YES;
static NSTimeInterval kScrollCheckPeriod =                      1./10.;
static CGFloat kDefaultLastScrollPosition =                     -10e5;//some crazy number so that the check always fires the first time

@interface GBTableViewController ()

@property (assign, nonatomic) UITableViewStyle                  tableViewStyle;
@property (assign, nonatomic) BOOL                              isShowingEmpty;
@property (strong, nonatomic) NSTimer                           *scrollCheckTimer;
@property (assign, nonatomic) CGFloat                           lastScrollPostion;
@property (strong, nonatomic) NSArray                           *lastVisibleIndexPaths;

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
        self.lastScrollPostion = kDefaultLastScrollPosition;
        
        self.tableViewStyle = style;
        self.tableView = [[[self classForTableView] alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //turn on checking for cells that are appearing
    self.scrollCheckTimer = [NSTimer timerWithTimeInterval:kScrollCheckPeriod target:self selector:@selector(_scrollCheck) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.scrollCheckTimer forMode:NSRunLoopCommonModes];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.scrollCheckTimer invalidate];
    [self _allDidEndShowing];
}
#pragma mark - scroll checking

-(void)_scrollCheck {
    //get the list of fully visible cells, first just put all of them in...
    NSMutableArray *currentlyFullyVisibleIndexPaths = [NSMutableArray arrayWithArray:self.tableView.indexPathsForVisibleRows];
    
    //if we haven't scrolled && list hasnt changed -> return
    if (self.lastScrollPostion == self.tableView.contentOffset.y &&
        [self.lastVisibleIndexPaths isEqualToArray:currentlyFullyVisibleIndexPaths]) {
        return;
    }
    
    //remember scroll position
    self.lastScrollPostion = self.tableView.contentOffset.y;
    
    //then remove first cell if partially visible
    if (currentlyFullyVisibleIndexPaths.count > 0 &&
        !IsCellAtIndexPathFullyVisible(currentlyFullyVisibleIndexPaths[0], self.tableView)) {
        [currentlyFullyVisibleIndexPaths removeObjectAtIndex:0];
    }
    
    //and then remove last cell if partially visible
    if (currentlyFullyVisibleIndexPaths.count > 0 &&
        !IsCellAtIndexPathFullyVisible([currentlyFullyVisibleIndexPaths lastObject], self.tableView)) {
        [currentlyFullyVisibleIndexPaths removeLastObject];
    }
    
    //now we have the list of currently fully visible cells, time to find out which are new and which are gone...
    
    //last - current = end
    NSArray *didEndShowing = [self.lastVisibleIndexPaths arrayBySubtractingArray:currentlyFullyVisibleIndexPaths];
    
    //current - last = begin
    NSArray *didBeginShowing = [currentlyFullyVisibleIndexPaths arrayBySubtractingArray:self.lastVisibleIndexPaths];
    
    //remember for next time
    self.lastVisibleIndexPaths = currentlyFullyVisibleIndexPaths;
    
    //notify subclass of guys who left
    for (NSIndexPath *indexPath in didEndShowing) {
        [self tableView:self.tableView didEndFullyDisplayingCellForRowAtIndexPath:indexPath];
    }
    
    //notify subclass of guys who entered
    for (NSIndexPath *indexPath in didBeginShowing) {
        [self tableView:self.tableView didBeginFullyDisplayingCellForRowAtIndexPath:indexPath];
    }
}

-(void)_allDidEndShowing {
    //do a scrollcheck first in case we got moved programatically or something
    [self _scrollCheck];
    
    for (NSIndexPath *indexPath in self.lastVisibleIndexPaths) {
        [self tableView:self.tableView didEndFullyDisplayingCellForRowAtIndexPath:indexPath];
    }
    
    self.lastVisibleIndexPaths = nil;
    self.lastScrollPostion = kDefaultLastScrollPosition;
}

#pragma mark - API

-(void)clearEmpty {
    self.isShowingEmpty = NO;
}

-(void)handleEmpty {
    self.isShowingEmpty = [self _isTableEmpty];
}

#pragma mark - override

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"GBTableViewController warning: Subclass tableView:numberOfRowsInSection: and don't call super.");
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"GBTableViewController warning: Subclass cellForRowAtIndexPath: and don't call super.");
    return nil;
}

#pragma mark - Subclassing

-(Class)classForTableView {
    return UITableView.class;
}

-(void)tableView:(UITableView *)tableView didBeginFullyDisplayingCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //noop
}

-(void)tableView:(UITableView *)tableView didEndFullyDisplayingCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //noop
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
