//
//  NSPredicate+DictionaryRepresenation.h
//  NSPredicateDictionary
//
//  Created by Dan Zinngrabe on 6/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#ifndef __NSPREDICATE_DICTIONARYREPRESENTATION_H__
#define __NSPREDICATE_DICTIONARYREPRESENTATION_H__

#import <Foundation/Foundation.h>

#if PRAGMA_ONCE
#pragma once
#endif

/**
 *  Informal protocol providing a dictionary representation of the receiver.
 */

@interface NSPredicate (Dictionary)

/**
 *  Returns a representation of the receiver as a dictionary
 *
 *  Thows NSInvalidArgumentException for predicates that cannot be represented as key-value pairs. Supported predicates contain expressions of equality only, such as "foo = bar". While this is limited, it is adequate for a wide range of use cases, such as transforming an NSPredicate into URL parameters for an HTTP request.
 *  @throws NSInvalidArgumentException if the predicate is not supported.
 *  @return Dictionary
 */

- (NSDictionary *)dictionaryRepresentation;

@end
#endif
