//
//  Document.h
//  PraxPrompter
//
//  Created by Prashant Singh Pawar on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
{
    IBOutlet NSTextView *textView;
    NSAttributedString *mString;
}

- (NSAttributedString *) string;

- (void) setString: (NSAttributedString *) value;

@end
