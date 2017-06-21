//
//  WLCHashTagExtractor.m
//  WLCHashTagTextViewDemo
//
//  Created by lichunwang on 2017/6/7.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "WLCHashTagExtractor.h"

#define TWHashtagAlpha                          @"[\\p{L}\\p{M}\\p{Nd}]"
#define TWHashtagSpecialChars                    @"_\\u200c\\u200d\\ua67e\\u309b\\u309c\\u30a0\\u30fb"
#define TWUHashtagAlphanumeric                  @"[\\p{L}\\p{M}\\p{Nd}" TWHashtagSpecialChars @"]"
#define TWUHashtagBoundaryInvalidChars          @"&\\p{L}\\p{M}\\p{Nd}" TWHashtagSpecialChars

#define TWUValidHashtag \
@"(?:)([#＃](?!\ufe0f|\u20e3)" TWUHashtagAlphanumeric @"*" TWHashtagAlpha TWUHashtagAlphanumeric @"*)"

@implementation WLCHashTagExtractor

+ (NSRegularExpression *)validHashtagRegexp
{
    static NSRegularExpression *regexp;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regexp = [[NSRegularExpression alloc] initWithPattern:TWUValidHashtag options:NSRegularExpressionCaseInsensitive error:NULL];
    });
    return regexp;
}

+ (NSArray<NSValue *> *)extractHashTagsInText:(NSString *)text
{
    if (!text.length) {
        return @[];
    }
    
    NSMutableArray<NSValue *> *results = [NSMutableArray<NSValue *> array];
    NSUInteger len = text.length;
    NSUInteger position = 0;
    
    while (1) {
        NSTextCheckingResult *matchResult = [[self validHashtagRegexp] firstMatchInString:text options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(position, len - position)];
        if (!matchResult || matchResult.numberOfRanges < 2) {
            break;
        }
        
        NSRange hashtagRange = [matchResult rangeAtIndex:1];
        [results addObject:[NSValue valueWithRange:hashtagRange]];
        
        position = NSMaxRange(matchResult.range);
    }
    
    return results;
}

@end
