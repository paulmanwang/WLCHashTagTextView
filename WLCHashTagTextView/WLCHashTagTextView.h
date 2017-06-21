//
//  WLCHashTagTextView.h
//  WLCHashTagTextViewDemo
//
//  Created by lichunwang on 2017/6/7.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCHashTagTextView : UIView

// real class properties
@property (strong, nonatomic) UITextView *internalTextView;
@property (strong, nonatomic) UIColor *hashTagColor; // hashtag color, default is blueColor

// uitextview properties, need others? use .internalTextView
@property (weak, nonatomic) id<UITextViewDelegate> delegate;
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *textColor;
@property (assign, nonatomic) NSTextAlignment textAlignment;
@property (assign, nonatomic) NSRange selectedRange;
@property (assign, nonatomic) BOOL editable;
@property (assign, nonatomic) BOOL selectable;
@property (assign, nonatomic) UIDataDetectorTypes dataDetectorTypes;
@property (assign, nonatomic) UIReturnKeyType returnKeyType;
@property (assign, nonatomic) UIKeyboardType keyboardType;
@property (assign, nonatomic) UIEdgeInsets contentInset;
@property (assign, nonatomic) BOOL scrollEnabled;
@property (assign, nonatomic) BOOL enablesReturnKeyAutomatically;

// uitextview methods, need others? use .internalTextView
- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
- (BOOL)isFirstResponder;
- (BOOL)hasText;
- (void)scrollRangeToVisible:(NSRange)range;

@end
