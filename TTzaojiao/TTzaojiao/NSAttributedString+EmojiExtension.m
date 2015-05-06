//
// Created by zorro on 15/3/7.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+EmojiExtension.h"
#import "EmojiTextAttachment.h"

@implementation NSAttributedString (EmojiExtension)

- (NSString *)getPlainString {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if (value && [value isKindOfClass:[EmojiTextAttachment class]]) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:((EmojiTextAttachment *) value).emojiTag];
                          base += ((EmojiTextAttachment *) value).emojiTag.length - 1;
                      }
                  }];
    return [plainString stringByAppendingString:@" "];
}

+(instancetype)replaceEmojs:(NSString *)plainString{
    
    NSString* string = [plainString stringByReplacingOccurrencesOfString:@"&nbsp" withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@" "];
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSMutableString* tmpString = [plainString mutableCopy];
    NSRange range = [tmpString rangeOfString:@"[expre_"];
    while (range.location != NSNotFound) {
        NSRange numrange;
        numrange.location = range.location+range.length;
        numrange.length  = 2;
        NSString* numString = [tmpString substringWithRange:numrange];
        
        EmojiTextAttachment *emojiTextAttachment = [EmojiTextAttachment new];
        
        //Set emoji size
        emojiTextAttachment.emojiSize = 16.f;
        //Set tag and image
        emojiTextAttachment.emojiTag = [NSString stringWithFormat:@"[expre_%@]", numString];
        NSString* imageStr = [NSString stringWithFormat:@"expression_%@", numString];
        emojiTextAttachment.image = [UIImage imageNamed:imageStr];
        
        NSRange allRange = {range.location, range.length+3};
        [tmpString replaceCharactersInRange:allRange withString:@"t"];
        [attrString deleteCharactersInRange:allRange];
        [attrString insertAttributedString:[NSAttributedString attributedStringWithAttachment:emojiTextAttachment] atIndex:allRange.location];
        range = [tmpString rangeOfString:@"[expre_"];
    }
    
    return attrString;
}

@end