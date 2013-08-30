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


#import "SortedDictionaryCreationTests.h"
#import "SortedDictionary+Test.h"
#import "MutableSortedDictionary.h"


static NSString *cities[] = { @"New York", @"Los Angeles", @"Chicago", @"Houston", @"Philadelphia", @"Phoenix", @"San Antonio", @"San Diego", @"Dallas", @"San Jose" };
static NSString *states[] = { @"New York", @"California", @"Illinois", @"Texas", @"Pennsylvania", @"Arizona", @"Texas", @"California", @"Texas", @"California" };


@implementation SortedDictionaryCreationTests


- (void) testDictionary {
	SortedDictionary *d = nil;
	
	// create a SortedDictionary, check count and class
	STAssertNoThrow	(d = [SortedDictionary dictionary],				@"Failed to create dictionary");
	STAssertEquals	(0U, [d count],									@"Was expecting zero items when creating a dictionary");
	STAssertTrue	([d isMemberOfClass: [SortedDictionary class]],	@"Was expecting a SortedDictionary");
}


- (void) testDictionaryWithDictionary {
	// create a secondary dictionary to initialize with
	NSDictionary *d1 = [NSDictionary dictionaryWithObjects: states forKeys: cities count: 10];
	STAssertEquals(10U, [d1 count], @"10 items were expected");

	// create and initialize a SortedDictionary, check count and class
	SortedDictionary *d2 = nil;
	STAssertNoThrow(d2 = [SortedDictionary dictionaryWithDictionary: d1],	@"Failed to create dictionary");
	STAssertEquals(10U, [d2 count],											@"10 items were expected");
	STAssertTrue([d2 isMemberOfClass: [SortedDictionary class]],			@"Was expecting a SortedDictionary");
	
	// check content
	for (int i = 0; i < 10; ++i) {
		STAssertEquals(states[i], [d2 objectForKey: cities[i]],				@"Expected %@ for key %@", states[i], cities[i]);
	}
	
	// check that the binary tree the dictionary uses is correctly balanced
	STAssertTrue([d2 balancesAreCorrect], @"The dictionary is not balanced correctly");
}


- (void) testDictionaryWithSortedDictionary {
	// create a secondary dictionary to initialize with
	MutableSortedDictionary *d1 = [SortedDictionary dictionaryWithObjects: states forKeys: cities count: 10];
	STAssertEquals(10U, [d1 count], @"10 items were expected");
	
	// check that the binary tree the dictionary uses is correctly balanced
	STAssertTrue([d1 balancesAreCorrect], @"The dictionary is not balanced correctly");
	
	// create and initialize a SortedDictionary, check count and class
	SortedDictionary *d2 = nil;
	STAssertNoThrow	(d2 = [SortedDictionary dictionaryWithSortedDictionary: d1],	@"Failed to create dictionary");
	STAssertEquals	(10U, [d2 count],												@"10 items were expected");
	STAssertTrue	([d2 isMemberOfClass: [SortedDictionary class]],				@"Was expecting a SortedDictionary");
	
	// check that the binary tree the dictionary uses is correctly balanced
	STAssertTrue([d2 balancesAreCorrect], @"The dictionary is not balanced correctly");
	
	// check content
	for (int i = 0; i < 10; ++i) {
		STAssertEquals(states[i], [d2 objectForKey: cities[i]],						@"Expected %@ for key %@", states[i], cities[i]);
	}
}


- (void) testDictionaryWithObjectForKey {
	SortedDictionary *d = nil;
	
	// create and initialize a SortedDictionary, check count, content and class
	STAssertNoThrow	(
		d = [SortedDictionary dictionaryWithObject: @"New York"
											  forKey: @"City"],		@"Failed to create dictionary");
	STAssertEquals	(1U, [d count],									@"1 item was expected");
	STAssertEquals	(@"New York", [d objectForKey: @"City"],		@"Was expecting \"New York\"");
	STAssertTrue	([d isMemberOfClass: [SortedDictionary class]],	@"Was expecting a SortedDictionary");
	
	// check that the binary tree the dictionary uses is correctly balanced
	STAssertTrue([d balancesAreCorrect], @"The dictionary is not balanced correctly");
}


- (void) testDictionaryWithObjectsForKeys {
	SortedDictionary *d = nil;
	
	// create and initialize a SortedDictionary, check count, content and class
	STAssertNoThrow	(
		(d = [SortedDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"New York", @"Broadway", nil]
											 forKeys: [NSArray arrayWithObjects: @"City", @"Street", nil]]),
																	@"Failed to create dictionary");
	STAssertEquals	(2U, [d count],									@"2 items were expected");
	STAssertEquals	(@"New York", [d objectForKey: @"City"],		@"Was expecting \"New York\"");
	STAssertEquals	(@"Broadway", [d objectForKey: @"Street"],		@"Was expecting \"Broadway\"");
	STAssertTrue	([d isMemberOfClass: [SortedDictionary class]],	@"Was expecting a SortedDictionary");
	
	// check that the binary tree the dictionary uses is correctly balanced
	STAssertTrue([d balancesAreCorrect], @"The dictionary is not balanced correctly");
}


- (void) testDictionaryWithObjectsForKeysCount {
	SortedDictionary *d = nil;
	
	// create and initialize a SortedDictionary, check count and class
	STAssertNoThrow	(
		(d = [SortedDictionary dictionaryWithObjects: states forKeys: cities count: 10]),
																	@"Failed to create dictionary");
	STAssertEquals	(10U, [d count],								@"10 items were expected");
	STAssertTrue	([d isMemberOfClass: [SortedDictionary class]],	@"Was expecting a SortedDictionary");
	
	// check that the binary tree the dictionary uses is correctly balanced
	STAssertTrue([d balancesAreCorrect], @"The dictionary is not balanced correctly");
	
	// check content
	for (int i = 0; i < 10; ++i) {
		STAssertEquals(states[i], [d objectForKey: cities[i]],			@"Expected %@ for key %@", states[i], cities[i]);
	}
}


- (void) testDictionaryWithObjectsAndKeys {
	SortedDictionary *d = nil;
	
	// create and initialize a SortedDictionary, check count, content and class
	STAssertNoThrow	((d = [SortedDictionary dictionaryWithObjectsAndKeys: @"New York", @"New York", @"California", @"San Jose", nil]),
																	@"Failed to create dictionary");
	STAssertEquals	(2U, [d count],									@"2 items were expected");
	STAssertEquals	(@"New York", [d objectForKey: @"New York"],	@"Was expecting \"New York\"");
	STAssertEquals	(@"California", [d objectForKey: @"San Jose"],	@"Was expecting \"California\"");
	STAssertTrue	([d isMemberOfClass: [SortedDictionary class]],	@"Was expecting a SortedDictionary");
	
	// check that the binary tree the dictionary uses is correctly balanced
	STAssertTrue([d balancesAreCorrect], @"The dictionary is not balanced correctly");
}


- (void) testCantMutateImmutableDict {
	SortedDictionary *d = [SortedDictionary dictionary];
	STAssertThrows([((id) d) setObject: @"object" forKey: @"key"], @"Shouldn't be able to modify a SortedDictionary");
}


@end
