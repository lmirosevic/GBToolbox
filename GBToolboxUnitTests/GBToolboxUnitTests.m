//
//  GBToolboxUnitTests.m
//  GBToolboxUnitTests
//
//  Created by Luka Mirosevic on 23/11/2012.
//  Copyright (c) 2012 Luka Mirosevic. All rights reserved.
//

#import "GBToolboxUnitTests.h"

#import "GBToolbox.h"

@implementation GBToolboxUnitTests

-(void)setUp {
    [super setUp];
    
    // Set-up code here.
}

-(void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark - NSString category

-(void)testContainsSubstringCaseSensitive {
    STAssertTrue([@"heythereman" containsSubstring:@"THERE" caseSensitive:NO], @"containsSubstring:caseSensitive: test failed");
    STAssertTrue([@"heythereman" containsSubstring:@"there" caseSensitive:YES], @"containsSubstring:caseSensitive: test failed");
    STAssertFalse([@"heythereman" containsSubstring:@"THERE" caseSensitive:YES], @"containsSubstring:caseSensitive: test failed");
    
    STAssertFalse([@"heythereman" containsSubstring:@"buddy" caseSensitive:YES], @"containsSubstring:caseSensitive: test failed");
    STAssertFalse([@"heythereman" containsSubstring:@"buddy" caseSensitive:NO], @"containsSubstring:caseSensitive: test failed");
    
    {
        NSString *bigString = @"<category name=\"meta\"><info name='date'>2001</info><info name='encoded_by'>iTunes v7.5.0.20, QuickTime 7.3.1</info><info name='artist'>Basement Jaxx</info><info name='album'>Chilled: 1991-2008</info><info name='track_number'>5</info><info name='filename'>Romeo</info><info name='Paroles'>crap</info><info name='Auteur'>Ministry Of Sound</info><info name='artwork_url'>file:///Users/lm/Library/Caches/org.videolan.vlc/art/artistalbum/Basement%20Jaxx/Chilled_%201991-2008/art.jpg</info><info name='title'>Romeo</info><info name='genre'>Electronica/Dance</info>    </category><category name='Flux 0'><info name='Type '>Audio</info><info name='Fréquence d&#39;échantillonnage'>44100 Hz</info><info name='Canaux '>Stéréo</info><info name='Codec '>MPEG AAC Audio (mp4a)</info></category>";
        
        NSArray *subStrings = @[
            @"<category name='Flux",
            @"<info name='Type '>",
            @"<info name='Codec '>"
        ];
        
        for (NSString *substring in subStrings) {
            STAssertTrue([bigString containsSubstring:substring caseSensitive:YES], @"containsSubstring:caseSensitive: test failed");
            STAssertTrue([bigString containsSubstring:substring caseSensitive:NO], @"containsSubstring:caseSensitive: test failed");
        }
    }
}

#pragma mark - GBFastArray

-(void)testFastArray {
    GBFastArray *a = [[GBFastArray alloc] initWithTypeSize:sizeof(int) initialCapacity:4 resizingFactor:1.5];
    
    //check that the allocation was proper
    STAssertTrue([a currentAllocationSize] == 4, @"Array size must still be what it was initially allocated as");
    
    //count should be 0
    STAssertTrue(a.count == 0, @"Count should be 0");
    
    //check to see if its empty
    STAssertTrue(a.isEmpty, @"Should be empty");
    
    //put some values in
    for (int i = 0; i<20; i++) {
        int value = i-10;
        [a insertItem:&value atIndex:i];
    }
    
    //try searching for some items
    STAssertTrue(13 == [a binarySearchForIndexWithSearchLambda:^GBSearchResult(void *candidateItem) {
        int targetItem = 3;
        int nativeCandidateItem = *(int *)candidateItem;
        if (nativeCandidateItem == targetItem) {
            return GBSearchResultMatch;
        }
        else if (nativeCandidateItem > targetItem) {
            return GBSearchResultHigh;
        }
        else {
            return GBSearchResultLow;
        }
    }], @"Look for 13");
    STAssertTrue(13 == [a binarySearchForIndexWithLow:10 high:13 searchLambda:^GBSearchResult(void *candidateItem) {
        int targetItem = 3;
        int nativeCandidateItem = *(int *)candidateItem;
        if (nativeCandidateItem == targetItem) {
            return GBSearchResultMatch;
        }
        else if (nativeCandidateItem > targetItem) {
            return GBSearchResultHigh;
        }
        else {
            return GBSearchResultLow;
        }
    }], @"Look for 13");
    STAssertTrue(13 == [a binarySearchForIndexWithLow:13 high:20 searchLambda:^GBSearchResult(void *candidateItem) {
        int targetItem = 3;
        int nativeCandidateItem = *(int *)candidateItem;
        if (nativeCandidateItem == targetItem) {
            return GBSearchResultMatch;
        }
        else if (nativeCandidateItem > targetItem) {
            return GBSearchResultHigh;
        }
        else {
            return GBSearchResultLow;
        }
    }], @"Look for 13");
    STAssertTrue(kGBSearchResultNotFound == [a binarySearchForIndexWithLow:14 high:20 searchLambda:^GBSearchResult(void *candidateItem) {
        int targetItem = 3;
        int nativeCandidateItem = *(int *)candidateItem;
        if (nativeCandidateItem == targetItem) {
            return GBSearchResultMatch;
        }
        else if (nativeCandidateItem > targetItem) {
            return GBSearchResultHigh;
        }
        else {
            return GBSearchResultLow;
        }
    }], @"Look for 13, but don't find it");

    //check to see if its empty
    STAssertTrue(!a.isEmpty, @"Should NOT be empty");
    
    //check that the count is proper
    STAssertTrue(a.count == 20, @"Array count should match what's been put in");
    
    //check that the array has grown properly
    STAssertTrue([a currentAllocationSize] == 28, @"Array size must now have grown according to the resizing factor");
    
    //check that the values made it in safely
    for (int i = 0; i<20; i++) {
        STAssertTrue(*(int *)[a itemAtIndex:i] == i-10, @"What went in must come out");
    }
    
    //resize the array up
    [a reallocToSize:100];
    STAssertTrue([a currentAllocationSize] == 100, @"Array size must now be the new size");
    
    //check again
    for (int i = 0; i<20; i++) {
        STAssertTrue(*(int *)[a itemAtIndex:i] == i-10, @"What went in must still be in");
    }
    
    //shrink
    [a reallocToSize:5];
    STAssertTrue([a currentAllocationSize] == 5, @"Array size must now be the new size");
    
    //check that the count is proper
    STAssertTrue(a.count == 5, @"Array count should match what's been put in");
    
    //check again that first few items are still in
    for (int i = 0; i<5; i++) {
        STAssertTrue(*(int *)[a itemAtIndex:i] == i-10, @"What went in must still be in, again");
    }
}

#pragma mark - Linear algebra

-(void)testLinearAlgebra {
    typedef struct {
        CGFloat origin;
        CGFloat length;
    } Line;
    
    Line outer = {20,60};
    
    Line innerTrue[] = {{21,29}, {15,25}, {60,40}, {4,116}};
    
    STAssertTrue(Lines1DOverlap(outer.origin, outer.length, innerTrue[0].origin, innerTrue[0].length), @"true: one way");
    STAssertTrue(Lines1DOverlap(innerTrue[0].origin, innerTrue[0].length, outer.origin, outer.length), @"true: the other");
    
    STAssertTrue(Lines1DOverlap(outer.origin, outer.length, innerTrue[1].origin, innerTrue[1].length), @"true: one way");
    STAssertTrue(Lines1DOverlap(innerTrue[1].origin, innerTrue[1].length, outer.origin, outer.length), @"true: the other");
    
    STAssertTrue(Lines1DOverlap(outer.origin, outer.length, innerTrue[2].origin, innerTrue[2].length), @"true: one way");
    STAssertTrue(Lines1DOverlap(innerTrue[2].origin, innerTrue[2].length, outer.origin, outer.length), @"true: the other");
    
    STAssertTrue(Lines1DOverlap(outer.origin, outer.length, innerTrue[3].origin, innerTrue[3].length), @"true: one way");
    STAssertTrue(Lines1DOverlap(innerTrue[3].origin, innerTrue[3].length, outer.origin, outer.length), @"true: the other");
    
    Line innerFalse[] = {{10,7}, {18,1.9}, {80.1,20}};
    
    STAssertFalse(Lines1DOverlap(10, 7, 20, 60), @"should not overlap");
    
    STAssertFalse(Lines1DOverlap(outer.origin, outer.length, innerFalse[0].origin, innerFalse[0].length), @"false: one way");
    STAssertFalse(Lines1DOverlap(innerFalse[0].origin, innerFalse[0].length, outer.origin, outer.length), @"false: the other");
    
    STAssertFalse(Lines1DOverlap(outer.origin, outer.length, innerFalse[1].origin, innerFalse[1].length), @"false: one way");
    STAssertFalse(Lines1DOverlap(innerFalse[1].origin, innerFalse[1].length, outer.origin, outer.length), @"false: the other");
    
    STAssertFalse(Lines1DOverlap(outer.origin, outer.length, innerFalse[2].origin, innerFalse[2].length), @"false: one way");
    STAssertFalse(Lines1DOverlap(innerFalse[2].origin, innerFalse[2].length, outer.origin, outer.length), @"false: the other");
}

#pragma mark - Dictionary pruning

-(void)testDictionaryPruning {
    NSDictionary *dict1 = @{@"a": @"1",
                            @"b": [NSNull null],
                            @"c": @"3"};
    
    STAssertTrue(2 == [NSDictionary dictionaryByPruningNullsInDictionary:dict1].count, @"shud match");
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{
        @"dog": @"wilsa",
        @"otherDog": @"jackson",
        @"cat": [NSNull null]
    }];
    
    [dict pruneNulls];
    
    STAssertTrue(dict.count == 2, @"should be equal");
    
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithDictionary: @{
        @"a": @"1",
        @"b": [NSNull null],
        @"c": @{
            @"car": [NSNull null],
            @"limo": @"hummer"
        }
    }];
    
    NSDictionary *prunedResultTarget = @{
        @"a": @"1",
        @"c": @{
            @"limo": @"hummer"
        }
    };
    
    [dict2 pruneNulls];
    
    STAssertTrue([dict2 isEqual:prunedResultTarget], @"dicts shud equal");
}

#pragma mark GBBoolean

-(void)testGBBoolean {
    //or
    STAssertEquals(BNO, GBBooleanOr(BUndefined, BUndefined), @"boolean or test");
    STAssertEquals(BNO, GBBooleanOr(BUndefined, BNO), @"boolean or test");
    STAssertEquals(BYES, GBBooleanOr(BUndefined, BYES), @"boolean or test");
    
    STAssertEquals(BNO, GBBooleanOr(BNO, BUndefined), @"boolean or test");
    STAssertEquals(BNO, GBBooleanOr(BNO, BNO), @"boolean or test");
    STAssertEquals(BYES, GBBooleanOr(BNO, BYES), @"boolean or test");
    
    STAssertEquals(BYES, GBBooleanOr(BYES, BUndefined), @"boolean or test");
    STAssertEquals(BYES, GBBooleanOr(BYES, BNO), @"boolean or test");
    STAssertEquals(BYES, GBBooleanOr(BYES, BYES), @"boolean or test");
    
    //and
    STAssertEquals(BNO, GBBooleanAnd(BUndefined, BUndefined), @"boolean and test");
    STAssertEquals(BNO, GBBooleanAnd(BUndefined, BNO), @"boolean and test");
    STAssertEquals(BNO, GBBooleanAnd(BUndefined, BYES), @"boolean and test");
    
    STAssertEquals(BNO, GBBooleanAnd(BNO, BUndefined), @"boolean and test");
    STAssertEquals(BNO, GBBooleanAnd(BNO, BNO), @"boolean and test");
    STAssertEquals(BNO, GBBooleanAnd(BNO, BYES), @"boolean and test");
    
    STAssertEquals(BNO, GBBooleanAnd(BYES, BUndefined), @"boolean and test");
    STAssertEquals(BNO, GBBooleanAnd(BYES, BNO), @"boolean and test");
    STAssertEquals(BYES, GBBooleanAnd(BYES, BYES), @"boolean and test");
    
    //not
    STAssertEquals(BYES, GBBooleanNot(BUndefined), @"boolean not test");
    STAssertEquals(BYES, GBBooleanNot(BNO), @"boolean not test");
    STAssertEquals(BNO, GBBooleanNot(BYES), @"boolean not test");
    
    //IsTruthy
    STAssertEquals(NO, IsTruthyGBBoolean(BUndefined), @"boolean IsTruthy test");
    STAssertEquals(NO, IsTruthyGBBoolean(BNO), @"boolean IsTruthy test");
    STAssertEquals(YES, IsTruthyGBBoolean(BYES), @"boolean IsTruthy test");
    
    //Bool2GBBoolean
    STAssertEquals(BNO, Bool2GBBoolean(NO), @"boolean Bool2GBBoolean test");
    STAssertEquals(BYES, Bool2GBBoolean(YES), @"boolean Bool2GBBoolean test");
    
    //GBBoolean2Number
    STAssertEqualObjects(nil, GBBoolean2Number(BUndefined), @"boolean Bool2GBBoolean test");
    STAssertEqualObjects(@(NO), GBBoolean2Number(BNO), @"boolean Bool2GBBoolean test");
    STAssertEqualObjects(@(YES), GBBoolean2Number(BYES), @"boolean Bool2GBBoolean test");
}

@end
