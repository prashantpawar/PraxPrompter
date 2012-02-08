//
//  Document.m
//  PraxPrompter
//
//  Created by Prashant Singh Pawar on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Document.h"

@implementation Document

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        // If an error occurs here, return nil.
        if(mString == nil){
            mString = [[NSAttributedString alloc] initWithString:@""];
        }
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSAttributedString *) string { return [[mString retain] autorelease]; }

- (void) setString: (NSAttributedString *) newValue {
    if(mString != newValue){
        if(mString) [mString release];
        mString = [newValue copy];
    }
}

- (void) textDidChange: (NSNotification *) notification
{
    [self setString: [textView textStorage]];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    BOOL readSuccess = NO;
    NSAttributedString *fileContents = [[NSAttributedString alloc]
                                        initWithData:data options:NULL documentAttributes:NULL error:outError];
    
    if(fileContents) {
        readSuccess = YES;
        [self setString:fileContents];
        [fileContents release];
    }
                                        
    return readSuccess;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    NSData *data;
    [self setString:[textView textStorage]];
    NSMutableDictionary *dict = [NSDictionary dictionaryWithObject:NSRTFTextDocumentType forKey:NSDocumentTypeDocumentAttribute];
    [textView breakUndoCoalescing];
    data = [[self string] dataFromRange:NSMakeRange(0, [[self string] length]) documentAttributes:dict error:outError];
    
    return data;
}

- (IBAction)playTeleprompter:(id)sender {
    [[NSAlert alertWithMessageText:@"Important message" defaultButton:@"Ok" alternateButton:@"Cancel" otherButton:@"Other" informativeTextWithFormat:[textView ]] runModal];
}
@end
