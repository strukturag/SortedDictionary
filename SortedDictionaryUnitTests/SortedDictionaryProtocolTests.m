/*
 MIT License
 
 Copyright (c) 2009 Oren Trutner
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */


#import "SortedDictionaryProtocolTests.h"
#import "SortedDictionary+Test.h"
#import "MutableSortedDictionary.h"


@implementation SortedDictionaryProtocolTests


- (void) setUp {
	NSMutableArray *keys	= [NSMutableArray arrayWithCapacity: 1000];
	NSMutableArray *values	= [NSMutableArray arrayWithCapacity: 1000];
	
	for (int i = 0; i < 1000; ++i) {
		NSString *key	= [NSString stringWithFormat: @"%d", i];
		NSString *value = [NSString stringWithFormat: @"%d", i % 10];
		
		[keys	addObject: key];
		[values	addObject: value];
	}
	
	nsd = [[NSDictionary		alloc] initWithObjects: values forKeys: keys];
	srd = [[SortedDictionary	alloc] initWithObjects: values forKeys: keys];
}


- (void) tearDown {
	[srd release];
	[nsd release];
}


- (void) testCopyWithZone {
	// make a copy of the test dictionary
	SortedDictionary *copy = [srd copy];
	
	// check that the copy matches the original
	STAssertEqualObjects([copy className], @"SortedDictionary", @"Expected a SortedDictionary");
	STAssertEquals(1000U, [copy count], @"Expected copy to have same element count");
	STAssertTrue([copy balancesAreCorrect], @"Uh oh, copy has a balance problem");
	STAssertTrue([srd isEqualToSortedDictionary: copy], @"Expected copy to match original");
	
	STAssertNoThrow([copy release], @"expected to have my own copy");
}


- (void) testMutableCopyWithZone {
	// make a mutable copy of the test dictionary
	MutableSortedDictionary *copy = [srd mutableCopyWithZone: NSDefaultMallocZone()];
	
	// check that the copy matches the original
	STAssertEqualObjects([copy className], @"MutableSortedDictionary", @"Expected a MutableSortedDictionary");
	STAssertEquals(1000U, [copy count], @"Expected copy to have same element count");
	STAssertTrue([copy balancesAreCorrect], @"Uh oh, copy has a balance problem");
	STAssertTrue([srd isEqualToSortedDictionary: copy], @"Expected copy to match original");
	
	// modify the copy
	for (int i = 0; i < 1000; i += 5) {
		NSString *key	= [NSString stringWithFormat: @"%d", i];
		STAssertNoThrow([copy removeObjectForKey: key], @"Expected a mutable dictionary");
	}
	
	// check that the copy was modified as expected
	STAssertEquals(800U, [copy count], @"Expected object removal to succeed");
	STAssertTrue([copy balancesAreCorrect], @"Uh oh, copy has a balance problem");
	
	// check that the original remains untouched
	STAssertEquals(1000U, [srd count], @"Expected object removal to not affect the original");	
	STAssertTrue([srd balancesAreCorrect], @"Uh oh, original has a balance problem");
	
	STAssertNoThrow([copy release], @"expected to have my own copy");
}


- (void) testCoding {
	NSMutableData	*data		= [[[NSMutableData alloc] init] autorelease];
	NSKeyedArchiver	*archiver	= [[[NSKeyedArchiver alloc] initForWritingWithMutableData: data] autorelease];
	[srd encodeWithCoder: archiver];
	[archiver finishEncoding];
	
	NSKeyedUnarchiver	*unarchiver	= [[[NSKeyedUnarchiver alloc] initForReadingWithData: data] autorelease];
	SortedDictionary	*copy		= [[[SortedDictionary alloc] initWithCoder: unarchiver] autorelease];
	
	STAssertTrue([srd isEqualToSortedDictionary: copy], @"The decoded dictionary differs from the original");
}


@end
