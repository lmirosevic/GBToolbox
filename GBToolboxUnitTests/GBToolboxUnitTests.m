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

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

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


@end
