//
//  NSPredicateDictionaryTests.m
//  NSPredicateDictionaryTests
//
//  Created by Dan Zinngrabe on 6/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NSPredicateDictionary/NSPredicateDictionary.h>

@interface NSPredicateDictionaryTests : XCTestCase

@end

@implementation NSPredicateDictionaryTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark -

- (void)testCompoundPredicateNotNil
{
    NSCompoundPredicate *orMatchPredicates = (NSCompoundPredicate *)[NSCompoundPredicate orPredicateWithSubpredicates:nil];
    XCTAssertNotNil([orMatchPredicates dictionaryRepresentation], @"Compound predicate has no result");
}

/**
 *  Tests wether a simple comparison predicate throws an exception.
 */

- (void)testComparisonPredicateNotNil
{
    NSExpression    *lhs    = [NSExpression expressionForConstantValue:@"foo"];
    NSExpression    *rhs    = [NSExpression expressionForConstantValue:@"bar"];
    NSComparisonPredicate *comparisonPredicate = (NSComparisonPredicate *)[NSComparisonPredicate predicateWithLeftExpression:lhs rightExpression:rhs modifier:NSDirectPredicateModifier
                                                                                                                        type:NSContainsPredicateOperatorType
                                                                                                                     options:NSCaseInsensitivePredicateOption];
    //XCTAssertNotNil([comparisonPredicate dictionaryRepresentation], @"Comparison predicate has no result");
    XCTAssertThrows([comparisonPredicate dictionaryRepresentation], @"Should throw exception");
}

/**
 *  Tests wether an unsupportable predicate throws an exception.
 */

- (void)testUnsupportablePredicate
{
    NSExpression    *lhs    = [NSExpression expressionForConstantValue:@"foo"];
    NSExpression    *rhs    = [NSExpression expressionForFunction:@"sum:" arguments:nil];
    NSComparisonPredicate *comparisonPredicate = (NSComparisonPredicate *)[NSComparisonPredicate predicateWithLeftExpression:lhs rightExpression:rhs modifier:NSDirectPredicateModifier
                                                                                                                        type:NSContainsPredicateOperatorType
                                                                                                                     options:NSCaseInsensitivePredicateOption];
    // Test an example of a predicate that SHOULD throw an exception, one we could not support
    // such as one with a function or block, predicates using MATCHES, etc.
    XCTAssertThrows([comparisonPredicate dictionaryRepresentation], @"Should not be able to construct this expression");
}

/**
 *  Tests wether an empty NSPredicate abstract class returns a non-nil dictionary representation.
 */

- (void)testBasePredicateNotNil
{
    NSPredicate *predicate = [[NSPredicate alloc] init];
    // Test an example of a predicate that SHOULD throw an exception, one we could not support
    // such as one with a function or block, predicates using MATCHES, etc.
    XCTAssertNotNil([predicate dictionaryRepresentation], @"Should be non nil, but empty");
}

/**
 *  Tests wether an empty NSPredicate abstract class returns an empty dictionary representation.
 */

- (void)testBasePredicateEmpty
{
    NSPredicate *predicate = [[NSPredicate alloc] init];
    XCTAssertTrue([[predicate dictionaryRepresentation] count] == 0, @"Should be non nil, but empty");
}

/**
 *  Tests wether a simple comparison predicate with equality throws an exception.
 */

- (void)testSimpleComparisonPredicate
{
    NSPredicate     *predicate      = [NSPredicate predicateWithFormat:@"foo=bar"];
    //NSDictionary    *expectation    = @{@"foo": @"bar"};
    //NSDictionary    *result         = nil;
    
    // Does the generated predicate dictionary equal the expected result?
    //result = [predicate dictionaryRepresentation];
    //XCTAssertTrue([result isEqual:expectation], @"Did not get expected result. Expected:%@ Got:%@", expectation, result);
    XCTAssertThrows([predicate dictionaryRepresentation], @"Should throw exception");
}

/**
 *  Tests wether a simple compound predicate throws an exception.
 */

- (void)testSimpleCompoundPredicate
{
    NSPredicate     *predicate      = [NSPredicate predicateWithFormat:@"foo != nil AND bar != nil"];
    
    XCTAssertThrows([predicate dictionaryRepresentation], @"Did not throw exception");
}

/**
 *  Tests wether a compound predicate with AND throws an exception.
 */

- (void)testCompoundAndPredicate
{
    NSPredicate     *predicate      = [NSPredicate predicateWithFormat:@"foo != nil AND bar != nil"];
    
    XCTAssertThrows([predicate dictionaryRepresentation], @"Did not throw exception");
}

/**
 *  Tests wether a compound predicate with OR throws an exception.
 */

- (void)testCompoundOrPredicate
{
    NSPredicate     *predicate      = [NSPredicate predicateWithFormat:@"foo != nil OR bar != nil"];
    
    XCTAssertThrows([predicate dictionaryRepresentation], @"Did not throw exception");
}

/**
 *  Tests wether a compound predicate with NOT throws an exception.
 */

- (void)testCompoundNotPredicate
{
    NSPredicate     *predicate      = [NSPredicate predicateWithFormat:@"foo != nil AND NOT bar != nil"];
    
    XCTAssertThrows([predicate dictionaryRepresentation], @"Did not throw exception");
}

/**
 *  Tests wether a comparison predicate with a CONTAINS throws an exception.
 */

- (void)testComparisonContainsPredicate
{
    NSPredicate     *predicate      = [NSPredicate predicateWithFormat:@"foo CONTAINS 'bar'"];
    
    XCTAssertThrows([predicate dictionaryRepresentation], @"Did not throw exception");
}

/**
 *  Tests wether a comparison predicate with equality throws an exception.
 */

- (void)testComparisonEqualityPredicate
{
    NSPredicate     *predicate      = [NSPredicate predicateWithFormat:@"foo == bar"];
    
    XCTAssertThrows([predicate dictionaryRepresentation], @"Did not throw exception");
}

/**
 *  Tests wether a comparison predicate with inequality throws an exception.
 */

- (void)testComparisonUnEqualityPredicate
{
    NSPredicate     *predicate      = [NSPredicate predicateWithFormat:@"foo != bar"];
    
    XCTAssertThrows([predicate dictionaryRepresentation], @"Did not throw exception");
}

@end
