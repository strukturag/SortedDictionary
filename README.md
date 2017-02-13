#summary Getting started with SortedDictionary

= Introduction =

Writing for OS/X or the iPhone? Using _NSDictionary_ to store and access key-value pairs? Ever tried to enumerate them all only to find they come back in some random order? As _NSDictionary_ uses a hash table to map keys to values, it maintains no sort order whatsoever across its entries.
The _SortedDictionary_ class and its mutable companion, _MutableSortedDictionary_ implement dictionaries that maintain a strong sort order across their keys. _SortedDictionary_ and _MutableSortedDictionary_ deliver high performance using an implementation of a self-balancing binary tree.

= Capabilities =

The _SortedDictionary_ and _MutableSortedDictionary_ classes implement the interfaces of _NSDictionary_ and _NSMutableDictionary_, respectively, and can serve as drop-in replacements. They support the _NSCoding_, _NSCopying_ and _NSMutableCopying_ protocols.
Additionally, the sorted dictionary classes add methods allowing you to enumerate entries in both their forward and reverse key order, without having to sort and without any additional computational cost.

= How to use SortedDictionary in your code =

== Option 1: Using the source code ==

Add the _SortedDictionary_ folder to your project. Add all the files in the _SortedDictionary_ folder, including its _Internal_ and _External_ folders, into your project. When you build your project, the sorted dictionaries classes will be compiled into your application.
To create a sorted dictionary in code, include the appropriate header file:
{{{
 #import "SortedDictionary.h"
 
 - (void) someMethod {
    SortedDictionary *dict = [MutableSortedDictionary dictionary];
 
    [dict setValue: @"red" forKey: @"apple"];
    [dict setValue: @"yellow" forKey: @"banana"];
    [dict setValue: @"orange" forKey: @"orange"];
 
    NSString *color = [dict objectForKey: @"apple"];
 }
}}}
== Option 2: Using the compiled frameworks ==

Add the compiled frameworks to your project:
  # In XCode, open Targets, then right-click (or ctrl-click) your target, and select Add>Existing Frameworks...
  # The Target Info window opens. Click the + button below the Linked Libraries list. Select Add Other...
  # Navigate to the folder that contains the compiled framework, and select SortedDictionary.Framework.
  # Click Add, and close the Target Info window.

= LICENSE =

MIT License
Copyright (c) 2009 Oren Trutner

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.