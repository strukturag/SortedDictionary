//
//  SortedDictionaryAdditions.m
//  SortedDictionary
//
//  Created by Yuriy Shevchuk on 8/30/13.
//	Copyright (c) 2013 struktur. All rights reserved.
//

#import "SortedDictionaryAdditions.h"

@implementation NSString(SortedDictionaryAdditions)

- (BOOL)isLessThan:(id)otherString
{
	BOOL isLessThan = NO;
	
	NSComparisonResult compResult = [self compare:otherString];
	isLessThan = compResult == NSOrderedAscending;
	
	return isLessThan;
}


- (BOOL)isGreaterThan:(id)otherString
{
	BOOL isGreaterThan = NO;
	
	NSComparisonResult compResult = [self compare:otherString];
	isGreaterThan = compResult == NSOrderedDescending;
	
	return isGreaterThan;
}


- (BOOL)isLessThanOrEqualTo:(id)otherString
{
	BOOL isLessThanOrEqualTo = NO;
	
	NSComparisonResult compResult = [self compare:otherString];
	isLessThanOrEqualTo = (compResult == NSOrderedAscending || compResult == NSOrderedSame);
	
	return isLessThanOrEqualTo;
}


@end


@implementation NSObject (SortedDictionarAdditions)

+ (NSString *)className
{
	return NSStringFromClass([self class]);
}

- (NSString *)className
{
	return NSStringFromClass([self class]);
}


@end

