//
//  WLCHashTagTextView.m
//  WLCHashTagTextViewDemo
//
//  Created by lichunwang on 2017/6/7.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "WLCHashTagTextView.h"
#import "WLCHashTagExtractor.h"

@interface WLCHashTagTextView ()<UITextViewDelegate>

@end

@implementation WLCHashTagTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    self.internalTextView = [[UITextView alloc] initWithFrame:self.bounds];
    self.internalTextView.delegate = self;
    self.internalTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.internalTextView];
}

- (void)hightlightHashTag
{
    UITextRange *markedRange = [self.internalTextView markedTextRange];
    UITextPosition *position = [self.internalTextView positionFromPosition:markedRange.start offset:0];
    if (position) {
        return;
    }
    
    NSString *text = self.internalTextView.text;
    if (text.length == 0) {
        return;
    }
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:self.internalTextView.font}];
    NSRange textViewOrigRange = self.internalTextView.selectedRange;
    
    UIColor *hashTagColor = self.hashTagColor ?: [UIColor blueColor];
    NSArray<NSValue *> *hashTagRanges = [WLCHashTagExtractor extractHashTagsInText:text];
    for (NSValue *hashTagRange in hashTagRanges) {
        NSRange range = hashTagRange.rangeValue;
        [attributedText addAttribute:NSForegroundColorAttributeName value:hashTagColor range:range];
    }
    
    self.internalTextView.attributedText = attributedText;
    self.internalTextView.selectedRange = textViewOrigRange;
}

- (BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    return [self.internalTextView becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    return [self.internalTextView resignFirstResponder];
}

- (BOOL)isFirstResponder
{
    return self.internalTextView.isFirstResponder;
}

- (BOOL)hasText
{
    return [self.internalTextView hasText];
}

- (void)scrollRangeToVisible:(NSRange)range
{
    [self.internalTextView scrollRangeToVisible:range];
}

#pragma mark - UITextView Properties

- (void)setText:(NSString *)text
{
    [self.internalTextView setText:text];
    [self hightlightHashTag];
}

- (NSString *)text
{
    return self.internalTextView.text;
}

- (void)setFont:(UIFont *)font
{
    [self.internalTextView setFont:font];
}

- (UIFont *)font
{
    return self.internalTextView.font;
}

- (void)setTextColor:(UIColor *)textColor
{
    [self.internalTextView setTextColor:textColor];
}

- (UIColor *)textColor
{
    return self.internalTextView.textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [self.internalTextView setTextAlignment:textAlignment];
}

- (NSTextAlignment)textAlignment
{
    return self.internalTextView.textAlignment;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    [self.internalTextView setBackgroundColor:backgroundColor];
}

- (UIColor *)backgroundColor
{
    return self.internalTextView.backgroundColor;
}

- (void)setSelectedRange:(NSRange)selectedRange
{
    [self.internalTextView setSelectedRange:selectedRange];
}

- (NSRange)selectedRange
{
    return self.internalTextView.selectedRange;
}

- (void)setEditable:(BOOL)editable
{
    [self.internalTextView setEditable:editable];
}

- (BOOL)editable
{
    return self.internalTextView.editable;
}

- (void)setSelectable:(BOOL)selectable
{
    [self.internalTextView setSelectable:selectable];
}

- (BOOL)selectable
{
    return self.internalTextView.selectable;
}

- (void)setDataDetectorTypes:(UIDataDetectorTypes)dataDetectorTypes
{
    [self.internalTextView setDataDetectorTypes:dataDetectorTypes];
}

- (UIDataDetectorTypes)dataDetectorTypes
{
    return self.internalTextView.dataDetectorTypes;
}

- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    [self.internalTextView setReturnKeyType:returnKeyType];
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    [self.internalTextView setContentInset:contentInset];
}

- (UIEdgeInsets)contentInset
{
    return self.internalTextView.contentInset;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled
{
    [self.internalTextView setScrollEnabled:scrollEnabled];
}

- (BOOL)scrollEnabled
{
    return self.internalTextView.scrollEnabled;
}

- (void)setEnablesReturnKeyAutomatically:(BOOL)enablesReturnKeyAutomatically
{
    [self.internalTextView setEnablesReturnKeyAutomatically:enablesReturnKeyAutomatically];
}

- (BOOL)enablesReturnKeyAutomatically
{
    return self.internalTextView.enablesReturnKeyAutomatically;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self hightlightHashTag];
    
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:textView];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.delegate textViewShouldBeginEditing:textView];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.delegate textViewShouldEndEditing:textView];
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.delegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.delegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        [self.delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.delegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    if ([self.delegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:interaction:)]) {
        return [self.delegate textView:textView shouldInteractWithURL:URL inRange:characterRange interaction:interaction];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    if ([self.delegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:interaction:)]) {
        return [self.delegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange interaction:interaction];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if ([self.delegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [self.delegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    if ([self.delegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        return [self.delegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    
    return YES;
}


@end
