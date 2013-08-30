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


#import <Foundation/Foundation.h>
#import "SortedDictionaryEntry.h"


typedef enum { odLeft = 0, odRight = 1 } ODSide;


@interface Node : NSObject <NSCoding, NSCopying, SortedDictionaryEntry> {
		id		key;
		id		value;
		int		balance;
		Node	*parent;
		Node	*children[2];
	}

	@property (copy, nonatomic)		id		key;
	@property (retain, nonatomic)	id		value;
	@property (assign, nonatomic)	int		balance;
	@property (assign, nonatomic)	Node	*parent;
	@property (assign, nonatomic)	Node	*left;
	@property (assign, nonatomic)	Node	*right;

	- (id) initWithKey: (id) aKey value: (id) aValue andParent: (Node *) aParent;
	- (void) copyContentFromNode: (Node *) aNode;

	- (Node *) childAtSide: (ODSide) aSide;
	- (void) setChild: (Node *) aNode atSide: (ODSide) aSide;

	- (Node *) liveChild;
	- (ODSide) sideOfChild: (Node *) aNode;

	- (int) height;
	- (int) count;

	- (NSString *) description;
	- (NSString *) descriptionWithChildrenAndIndent: (NSInteger) indent;

	// NSCoding
	- (void) encodeWithCoder: (NSCoder *) encoder;
	- (id) initWithCoder: (NSCoder *) decoder;

	// NSCopying
	- (id) copyWithZone: (NSZone *) zone;

@end
