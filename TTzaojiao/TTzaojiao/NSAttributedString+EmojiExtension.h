//
// Created by zorro on 15/3/7.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmojiTextAttachment.h"

@interface NSAttributedString (EmojiExtension)
- (NSString *)getPlainString;
+ (instancetype)replaceEmojs:(NSString*)plainString;
@end