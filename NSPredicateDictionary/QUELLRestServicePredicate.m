//
//  QUELLHTTPParametersPredicate.m
//  NSPredicateDictionary
//
//  Created by Dan Zinngrabe on 6/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "QUELLRestServicePredicate.h"
#import "NSPredicate+DictionaryRepresentation.h"

@interface QUELLRestCompoundPredicate : NSCompoundPredicate
- (NSDictionary *) dictionaryRepresentation;
@end

@interface QUELLRestComparisonPredicate : NSComparisonPredicate
- (NSDictionary *) dictionaryRepresentation;
@end

#pragma mark -

@implementation QUELLRestCompoundPredicate

/**
 *  AND is the only logical operator it makes sense to support for a generic HTTP request parameter.
 *  The service you are accessing may understand additional logical operations. 
 *  If that is the case, customize this behavior appropriately.
 *
 */

- (NSDictionary *) dictionaryRepresentation {
	NSDictionary        *result             = @{};
    
    if ([self compoundPredicateType] == NSAndPredicateType){
		result = [NSMutableDictionary dictionary];
		for (NSPredicate *subpredicate in [self subpredicates]){
			[result setValuesForKeysWithDictionary:[subpredicate dictionaryRepresentation]];
		}
	} else {
        // Calling the implementation on the NSComparisonPredicate informal protocol will raise the appropriate exception.
		result = [super dictionaryRepresentation];
	}
    return [result copy];
}

/**
 *  If the service you are accessing supports logical operations, 
 *  implement these methods to return the appropriate values, 
 *  or add them to your localization with the appropriate keys.
 *
 */

- (NSString *) localizedNotDescription {
    return @"";
}

- (NSString *) localizedOrDescription {
    return @"";
}

- (NSString *) localizedAndDescription {
    return @"";
}

@end

@implementation QUELLRestComparisonPredicate

/**
 *  Customize which predicate operators are supported. The default is only equal to, to allow for simple transform of key-value pairs.
 *  Additional functionality can be implemented easily. For example, if the service you are accessing allows for full text search,
 *  add handling of NSContainsPredicateOperatorType.
 *
 */

- (NSDictionary *) dictionaryRepresentation {
	NSDictionary        *result             = @{};
    
	if ([self predicateOperatorType] == NSEqualToPredicateOperatorType){
		result = [NSMutableDictionary dictionary];
		[result setValue:[[self rightExpression] constantValue] forKey:[[self leftExpression] keyPath]];
	} else {
        // Calling the implementation on the NSComparisonPredicate informal protocol will raise the appropriate exception.
        result = [super dictionaryRepresentation];
    }
	
	return [result copy];
}

@end

@implementation QUELLRestServicePredicate

+ (NSPredicate *) predicateForLinksWithTag:(NSString *)name {
    NSPredicate         *result             = nil;
    NSExpression        *leftExpression     = nil;
    NSExpression        *rightExpression    = nil;
    
    leftExpression = [NSExpression expressionForKeyPath:@"tag"];
    rightExpression = [NSExpression expressionForConstantValue:name];
    result = (NSPredicate *)[QUELLRestComparisonPredicate predicateWithLeftExpression:leftExpression rightExpression:rightExpression modifier:NSDirectPredicateModifier type:NSInPredicateOperatorType options:0];
    return result;
}

@end
