//
//  ComObscureRichTextRichTextView.m
//  richtext
//
//  Created by Paul Mietz Egli on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComObscureRichTextRichTextView.h"
#import "TiViewProxy.h"

// as per http://www.cocoanetics.com/2011/08/nsattributedstringhtml-qa/
#define kDefaultFontSize 12.0 

@interface ComObscureRichTextRichTextView (PrivateMethods)
- (void)setAttributedTextViewContent;
@end

@implementation ComObscureRichTextRichTextView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        options = [[NSMutableDictionary dictionary] retain];
        configSet = NO;

        view = [[DTAttributedTextContentView alloc] initWithFrame:[self bounds]];
        view.autoresizesSubviews = YES;
        view.backgroundColor = [UIColor clearColor];
        view.delegate = self;
        [self addSubview:view];
    }
    return self;
}

- (void)dealloc {
    RELEASE_TO_NIL(view)
    RELEASE_TO_NIL(content)
    RELEASE_TO_NIL(options)
    [super dealloc];
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds {
    [super frameSizeChanged:frame bounds:bounds];
    [view setFrame:bounds];
}

#pragma mark -
#pragma mark TiUIView

- (void)configurationSet {
    [super configurationSet];
    configSet = YES;
    [self setAttributedTextViewContent];
}

-(CGFloat)contentHeightForWidth:(CGFloat)value {
    return [view suggestedFrameSizeToFitEntireStringConstraintedToWidth:value].height;
}

- (CGFloat)verifyHeight:(CGFloat)suggestedHeight {
    CGFloat width = view.frame.size.width;
    return [view suggestedFrameSizeToFitEntireStringConstraintedToWidth:width].height;
}

- (void)setBackgroundColor_:(id)val {
    UIColor * color = [TiUtils colorValue:val].color;
    view.backgroundColor = color;
}

- (void)setColor_:(id)val {
    UIColor * color = [TiUtils colorValue:val].color;
    [options setValue:color forKey:DTDefaultTextColor];
    [options setValue:color forKey:DTDefaultLinkColor];
    [self setAttributedTextViewContent];
}

- (void)setFont_:(id)val {
    WebFont * font = [TiUtils fontValue:val];
    [options setValue:font.font.familyName forKey:DTDefaultFontFamily];
    [options setValue:[NSNumber numberWithFloat:(font.size / kDefaultFontSize)] forKey:NSTextSizeMultiplierDocumentOption];
    [self setAttributedTextViewContent];
}


#pragma mark -
#pragma mark DTAttributedTextView

- (void)setAttributedTextViewContent {
    if (!configSet) return; // lazy init
    
    NSAttributedString * str = nil;

    switch (contentType) {
        case kContentTypeHTML:
            str = [[NSAttributedString alloc] initWithHTML:[content dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:nil];
            break;
        default:
            str = [[NSAttributedString alloc] initWithString:content];
            break;
    }

    if (str) {
        view.attributedString = str;
        [(TiViewProxy *)[self proxy] contentsWillChange];
    }
}

- (void)setText_:(id)text {
    ENSURE_STRING_OR_NIL(text)
    RELEASE_TO_NIL(content)
    contentType = kContentTypeText;
    content = [text retain];
    [self setAttributedTextViewContent];
}

- (void)setHtml_:(id)html {
    ENSURE_STRING_OR_NIL(html)
    RELEASE_TO_NIL(content)
    contentType = kContentTypeHTML;
    content = [html retain];
    [self setAttributedTextViewContent];
}

// TODO setMarkdown_ ?

#pragma mark -
#pragma mark DTAttributedTextContentViewDelegate

- (void)linkPushed:(DTLinkButton *)button {
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           button.GUID, @"link_id",
                           [button.URL absoluteString], @"url",
                           nil];
    [self.proxy fireEvent:@"click" withObject:dict];
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForLink:(NSURL *)url identifier:(NSString *)identifier frame:(CGRect)frame {
    
	DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
	button.URL = url;
	button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
	button.GUID = identifier;
    
	// use normal push action for opening URL
	[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
    
	return button;
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame {
    if (attachment.contentType == DTTextAttachmentTypeImage) {
        DTLazyImageView * imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;
        if (attachment.contents) {
            imageView.image = attachment.contents;
        }
        imageView.url = attachment.contentURL;
        // TODO linked image?
        return imageView;
    }
    
    return nil;
}

#pragma mark DTLazyImageViewDelegate

- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
	NSURL *url = lazyImageView.url;
	CGSize imageSize = size;
	
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
	
	// update all attachments that matchin this URL (possibly multiple images with same size)
	for (DTTextAttachment *oneAttachment in [view.layoutFrame textAttachmentsWithPredicate:pred]) {
		oneAttachment.originalSize = imageSize;
		
		if (!CGSizeEqualToSize(imageSize, oneAttachment.displaySize)) {
			oneAttachment.displaySize = imageSize;
		}
	}
	
	// redo layout
	// here we're layouting the entire string, might be more efficient to only relayout the paragraphs that contain these attachments
    [(TiViewProxy *)[self proxy] contentsWillChange];
	[view relayoutText];
}

@end
