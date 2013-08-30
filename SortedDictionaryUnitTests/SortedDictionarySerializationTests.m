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


#import "SortedDictionarySerializationTests.h"
#import "SortedDictionary.h"


@implementation SortedDictionarySerializationTests


- (id) createTestDictionaryOfClass: (Class) class {
	return [class dictionaryWithObjectsAndKeys:
		@"Jupiter", @"Zeus",
		@"Minerva", @"Athena",
		[NSNumber numberWithInt: 42], @"the answer",
		[NSNumber numberWithFloat: 3.14], @"pi",
		[NSNumber numberWithBool: YES], @"life's good",
		[NSDate dateWithTimeIntervalSince1970: 1247921114], @"2009-07-18 12:45:14Z",
		[class dictionaryWithObjectsAndKeys: @"yellow", @"banana", @"red", @"apple", nil], @"fruits",
		[NSArray arrayWithObjects: @"tomato", @"cucumber", @"carrot", nil], @"veggies",
		[@"hello" dataUsingEncoding: NSUTF8StringEncoding], @"hello",
		nil];
}


- (void) checkTestDictionary: (id) dict ofClass: (Class) class {
	STAssertTrue([dict isKindOfClass: class], @"Expected a SortedDictionary");

	STAssertEqualObjects(@"Jupiter",											 [dict objectForKey: @"Zeus"], @"");
	STAssertEqualObjects(@"Minerva",											 [dict objectForKey: @"Athena"], @"");
	STAssertEquals		(42,													[[dict objectForKey: @"the answer"] intValue], @"");
	STAssertEqualObjects([NSNumber numberWithFloat: 3.14],						 [dict objectForKey: @"pi"], @"");
	STAssertEquals		(YES,													[[dict objectForKey: @"life's good"] boolValue], @"");
	STAssertEqualObjects([NSDate dateWithTimeIntervalSince1970: 1247921114],	 [dict objectForKey: @"2009-07-18 12:45:14Z"], @"");
	
	STAssertTrue([[dict objectForKey: @"fruits"] isKindOfClass: class], @"Expected a SortedDictionary");
	STAssertEqualObjects(@"yellow",		[[dict objectForKey: @"fruits"] objectForKey: @"banana"], @"");
	STAssertEqualObjects(@"red",		[[dict objectForKey: @"fruits"] objectForKey: @"apple"], @"");
	
	STAssertTrue([[dict objectForKey: @"veggies"] isKindOfClass: [NSArray class]], @"Expected an NSArray");
	STAssertEqualObjects(@"tomato",		[[dict objectForKey: @"veggies"] objectAtIndex: 0], @"");
	STAssertEqualObjects(@"cucumber",	[[dict objectForKey: @"veggies"] objectAtIndex: 1], @"");
	STAssertEqualObjects(@"carrot",		[[dict objectForKey: @"veggies"] objectAtIndex: 2], @"");
	
	STAssertEqualObjects(@"hello", [[NSString alloc] initWithData: [dict objectForKey: @"hello"] encoding: NSASCIIStringEncoding], @"");
}


- (void) testDictionaryWithContentsOfFile {
	// create an NSDictionary to use as a test plist and save it to a file
	NSDictionary *d1 = [self createTestDictionaryOfClass: [NSDictionary class]];
	[self checkTestDictionary: d1 ofClass: [NSDictionary class]];
	NSString *path = [[NSBundle bundleForClass: [self class]] pathForResource: @"test" ofType: @"plist"];
	[d1 writeToFile: path atomically: NO];
	
	// invoke dictionaryWithContentsOfFile: on SortedDictionary and check that the returned object
	// matches the saved plist
	SortedDictionary *d2 = [SortedDictionary dictionaryWithContentsOfFile: path];
	[self checkTestDictionary: d2 ofClass: [SortedDictionary class]];
}


- (void) testInitWithContentsOfFile {
	// create an NSDictionary to use as a test plist and save it to a file
	NSDictionary *d1 = [self createTestDictionaryOfClass: [NSDictionary class]];
	[self checkTestDictionary: d1 ofClass: [NSDictionary class]];
	NSString *path = [[NSBundle bundleForClass: [self class]] pathForResource: @"test" ofType: @"plist"];
	[d1 writeToFile: path atomically: NO];
	
	// invoke dictionaryWithContentsOfFile: on SortedDictionary and check that the returned object
	// matches the saved plist
	SortedDictionary *d2 = [[[SortedDictionary alloc] initWithContentsOfFile: path] autorelease];
	[self checkTestDictionary: d2 ofClass: [SortedDictionary class]];
}


- (void) testWriteToFileAtomically {
	SortedDictionary *d1 = [self createTestDictionaryOfClass: [SortedDictionary class]];
	[self checkTestDictionary: d1 ofClass: [SortedDictionary class]];
	NSString *path = [[NSBundle bundleForClass: [self class]] pathForResource: @"test" ofType: @"plist"];
	[d1 writeToFile: path atomically: NO];
	
	NSDictionary *d2 = [NSDictionary dictionaryWithContentsOfFile: path];
	[self checkTestDictionary: d2 ofClass: [NSDictionary class]];
}


@end
