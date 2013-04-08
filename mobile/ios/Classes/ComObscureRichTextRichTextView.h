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
#import "DTAttributedTextView.h"
#import "DTLazyImageView.h"

typedef enum {
    kContentTypeText,
    kContentTypeHTML
} ContentType;

@interface ComObscureRichTextRichTextView : TiUIView <DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate> {
    DTAttributedTextContentView * view;
    
    ContentType contentType;
    NSString * content;
    
    NSMutableDictionary * options;
    
    BOOL configSet;
    
    
    NSURL *baseURL;

	NSMutableSet *mediaPlayers;
    
}

@property (nonatomic, strong) NSMutableSet *mediaPlayers;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSURL *baseURL;

@end
