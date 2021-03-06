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


/**
 Use the PropertyListWriter class to serialize objects as XML-encoded Property Lists.
 This class supports the implementation of the writeToFile:atomically: and writeToUrl:atomically:
 methods on the SortedDictionary class. The serialized format produced by this class is compatible
 with the PropertyListReader and \c NSPropertyListSerialization classed.
 
 \see SortedDictionary::writeToFile:atomically:
 \see SortedDictionary::writeToUrl:atomically:
 \see SortedDictionary::dictionaryWithContentsOfFile:
 \see SortedDictionary::dictionaryWithContentsOfUrl:
 \see PropertyListReader
 */
@interface PropertyListWriter : NSObject {
		NSDateFormatter	*dateFormatter;		///< used for parsing RFC822 dates in the input
	}

	- (id) init;
	- (NSData *) writePropertyList: (id) plist;

@end
