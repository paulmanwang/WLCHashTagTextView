//
//  WLCHashTagExtractor.h
//  WLCHashTagTextViewDemo
//
//  Created by lichunwang on 2017/6/7.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCHashTagExtractor : NSObject

+ (NSArray<NSValue *> *)extractHashTagsInText:(NSString *)text;

@end
