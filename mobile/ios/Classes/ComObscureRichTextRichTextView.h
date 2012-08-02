//
//  ComObscureRichTextRichTextView.h
//  richtext
//
//  Created by Paul Mietz Egli on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiUIView.h"
#import "DTCoreText.h"

typedef enum {
    kContentTypeText,
    kContentTypeHTML
} ContentType;

@interface ComObscureRichTextRichTextView : TiUIView <DTAttributedTextContentViewDelegate> {
    DTAttributedTextContentView * view;
    
    ContentType contentType;
    NSString * content;
    
    NSMutableDictionary * options;
    
    BOOL configSet;
}
@end
