//
//  NSPredicate+DictionaryRepresenation.m
//  NSPredicateDictionary
//
//  Created by Dan Zinngrabe on 6/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "NSPredicate+DictionaryRepresentation.h"

@implementation NSExpression (StringValue)

- (NSString *)quell_stringValue {
	NSString	*result	= nil;
	switch([self expressionType]){
		case NSConstantValueExpressionType:
			result = [[self constantValue] description];
			break;
		case NSEvaluatedObjectExpressionType:
			break;
		case NSVariableExpressionType:
			result = [self variable];
			break;
		case NSKeyPathExpressionType:
			result = [self keyPath];
			break;
		case NSFunctionExpressionType:
			break;
		default:
			break;
	}
	return result;
}

@end

/**
 *  NSPredicate itself is only the face of the class cluster. NSComparisonPredicate and NSCompoundPredicate are the concrete classes.
 *  The categories on those classes provide implementations that return non-empty data.
 */

@implementation NSPredicate (Dictionary)

- (NSDictionary *)quell_dictionaryRepresentation {
	NSDictionary	*result	= @{};
	return result;
}

@end

@implementation NSComparisonPredicate (Dictionary)

/**
 *  Returns a dictionary representation of the receiver.
 *  NSComparisonPredicates can describe
 *
 *  @return NSDictionary
 */

- (NSDictionary *)quell_dictionaryRepresentation __attribute__((ns_returns_autoreleased)) {
    NSMutableDictionary *result             = nil;
    
    switch ([self predicateOperatorType]){
        case NSLessThanPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSLessThanPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSLessThanOrEqualToPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSLessThanOrEqualToPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSGreaterThanPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSGreaterThanPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSGreaterThanOrEqualToPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSGreaterThanOrEqualToPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSEqualToPredicateOperatorType:
            //result = @{[[self leftExpression]stringValue] : [[self rightExpression] stringValue]};
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSEqualToPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSNotEqualToPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSNotEqualToPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSMatchesPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSMatchesPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSLikePredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSLikePredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSBeginsWithPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSBeginsWithPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSEndsWithPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSEndsWithPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSInPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSInPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
			break;
        case NSCustomSelectorPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSCustomSelectorPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSContainsPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSContainsPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
        case NSBetweenPredicateOperatorType:
			[NSException raise:NSInvalidArgumentException format:@"[%@ %@]: NSBetweenPredicateOperatorType is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"[%@ %@]: Predicate is not yet implemented", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
    }
    return result;
}

@end

@implementation NSCompoundPredicate (Dictionary)

- (NSDictionary *)quell_dictionaryRepresentation __attribute__((ns_returns_autoreleased)) {
	NSMutableDictionary	*result	= nil;

    result = [[NSMutableDictionary alloc] init];
    switch ([self compoundPredicateType]){
        case NSNotPredicateType:
            for (id predicate in [self subpredicates]){
                [result setValue:[predicate quell_dictionaryRepresentation] forKey:[self quell_localizedNotDescription]];
            }
            break;
        case NSAndPredicateType:
            for (id predicate in [self subpredicates]){
                [result setValue:[predicate quell_dictionaryRepresentation] forKey:[self localizedAndDescription]];
            }
            break;
        case NSOrPredicateType:
            for (id predicate in [self subpredicates]){
                [result setValue:[predicate quell_dictionaryRepresentation] forKey:[self localizedOrDescription]];
            }
            break;
        default:
            [NSException raise:NSInvalidArgumentException format:@"[%@ %@]: Unsupported predicate type", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
            break;
    }
#if !__has_feature(objc_arc)
    [result autorelease]
#endif
	return result;
}


- (NSString *) quell_localizedNotDescription {
    return NSLocalizedString(@"localizedNOTDescription", @"NOT");
}

- (NSString *) localizedOrDescription {
    return NSLocalizedString(@"localizedORDescription",@"OR");
}

- (NSString *) localizedAndDescription {
    return NSLocalizedString(@"localizedANDDescription",@"AND");
}

@end
