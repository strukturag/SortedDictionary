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


#import "SortedDictionary+Private.h"
#import "AvlTree.h"
#import "EntryEnumerator.h"


@implementation SortedDictionary (Private)


- initWithTree: (AvlTree *) newTree {
	if (self = [super init]) {
		tree = [newTree retain];
	}
	return self;
}


- (void) addEntriesFromDictionary: (NSDictionary *) otherDictionary copyItems: (BOOL) flag {
	for (id key in [otherDictionary keyEnumerator]) {
		id value = [otherDictionary objectForKey: key];
		[tree setObject: (flag ? [[value copy] autorelease] : value) forKey: key];
	}
}


- (void) addEntriesFromSortedDictionary: (SortedDictionary *) otherDictionary copyItems: (BOOL) flag {
	for	(NSObject<SortedDictionaryEntry> *entry in [otherDictionary entryEnumerator]) {
		[tree setObject: (flag ? [[[entry value] copy] autorelease] : [entry value]) forKey: [entry key]];
	}
}


@end
