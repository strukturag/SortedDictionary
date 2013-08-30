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


#import "NSString+Indent.h"


@implementation NSString (Indent)


/**
 \brief Returns a string containing \a count copies of the \a copyMe string.
 
 \return A string containing \a count concatenated copies of the \a copyMe string.
 
 \param count The number of times to copy \a copyMe.
 \param copyMe The string to copy and concatenate. For indentation, this is often a string of
	one or more whitespaces or tab characters.
 */
+ (NSString *) stringWith: (NSInteger) count copiesOfString: (NSString *) copyMe {
	NSMutableString *result = [[NSMutableString alloc] initWithCapacity: count * [copyMe length]];
	
	for (int i = 0; i < count; ++i) {
		[result appendString: copyMe];
	}
	
	return result;
}


@end
