//
//  QUELLRestServicePredicateTests.m
//  NSPredicateDictionary
//
//  Created by Dan Zinngrabe on 6/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NSPredicateDictionary/NSPredicateDictionary.h>

@interface QUELLRestServicePredicateTests ()

@end

@implementation QUELLRestServicePredicateTests

- (void)setUp {
    [super setUp];
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    [super tearDown];
}

/**
 *  Tests wether a comparison predicate with equality throws an exception.
 */

- (void)testSimpleRestPredicate
{
    NSPredicate     *predicate      = [QUELLRestServicePredicate predicateForLinksWithTag:@"foo"];
    
    XCTAssertThrows([predicate dictionaryRepresentation], @"Did not throw exception");
}

// Implement additional tests that verify the resulting dictionary contains the expected information, etc.

@end
