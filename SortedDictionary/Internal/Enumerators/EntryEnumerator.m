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


#import "EntryEnumerator.h"
#import "Node.h"


@implementation EntryEnumerator


- (NSArray *) allObjects {
	NSMutableArray *objects = [[[NSMutableArray alloc] init] autorelease];
	
	id object;
	while (object = [self nextObject]) {
		[objects addObject: object];
	}
	
	return objects;
}


- (id) nextObject {
	// always return the node the enumerator is currently pointing at
	if (!node) return nil;
	Node *nodeToReturn = node;
	
	// now move the enumerator's node to the following node...
	
	// ...look for the next larger descendant, if there is one... (or smaller, if going back)
	Node *nextNode = [node performSelector: second];
	if (nextNode) {
		node = nextNode;
		while (nextNode = [node performSelector: first]) { node = nextNode; }
	}
	
	// ...or scan for the next unenumerated parent otherwise.
	else {
		Node *prevNode = node;
		node = [node parent];
		while (node && (prevNode == [node performSelector: second])) {
			prevNode = node;
			node = [node parent];
		}
	}
	
	return nodeToReturn;
}


@end
