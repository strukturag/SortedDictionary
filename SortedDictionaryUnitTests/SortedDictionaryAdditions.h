//
//  SortedDictionaryAdditions.h
//  SortedDictionary
//
//  Created by Yuriy Shevchuk on 8/30/13.
//
//

#import <Foundation/Foundation.h>

@interface NSString (SortedDictionarAdditions)

- (BOOL)isLessThan:(id)otherString;
- (BOOL)isGreaterThan:(id)otherString;
- (BOOL)isLessThanOrEqualTo:(id)otherString;

@end


@interface NSObject (SortedDictionarAdditions)

+ (NSString *)className;
- (NSString *)className;

@end
