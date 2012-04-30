//
//  ComObscureRichTextRichTextView.m
//  richtext
//
//  Created by Paul Mietz Egli on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComObscureRichTextRichTextView.h"
#import "DTCoreText.h"

@implementation ComObscureRichTextRichTextView

- (void)dealloc {
    RELEASE_TO_NIL(attributedTextView)
    [super dealloc];
}

- (DTAttributedTextView *)attributedTextView {
    if (!attributedTextView) {
        attributedTextView = [[DTAttributedTextView alloc] initWithFrame:[self bounds]];
        attributedTextView.autoresizesSubviews = YES;
        [self addSubview:attributedTextView];
    }
    return attributedTextView;
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds {
    [super frameSizeChanged:frame bounds:bounds];
    DTAttributedTextView * v = [self attributedTextView];
    [v setFrame:bounds];
}

- (void)setBackgroundColor_:(id)color {
    UIColor * c = [[TiUtils colorValue:color] _color];
    UIView * v = [self attributedTextView];
    v.backgroundColor = c;
}

- (void)setText_:(id)text {
    ENSURE_STRING_OR_NIL(text)
    DTAttributedTextView * v = [self attributedTextView];
    v.attributedString = [[NSAttributedString alloc] initWithString:text];
}

- (void)setHtml_:(id)html {
    ENSURE_STRING_OR_NIL(html)
    DTAttributedTextView * v = [self attributedTextView];
    v.attributedString = [[NSAttributedString alloc] initWithHTML:[html dataUsingEncoding:NSUTF8StringEncoding] documentAttributes:nil];
}

@end
