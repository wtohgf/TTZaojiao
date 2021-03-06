//
//  WUEmoticonsKeyboard.m
//  WeicoUI
//
//  Created by YuAo on 1/24/13.
//  Copyright (c) 2013 微酷奥(北京)科技有限公司. All rights reserved.
//

#import "WUEmoticonsKeyboard.h"
#import "UIResponder+WriteableInputView.h"
#import "WUEmoticonsKeyboardToolsView.h"
#import "WUEmoticonsKeyboardKeyItemGroupView.h"

#import "EmojiTextAttachment.h"

#define kFontSize 16.f

NSString * const WUEmoticonsKeyboardDidSwitchToDefaultKeyboardNotification = @"WUEmoticonsKeyboardDidSwitchToDefaultKeyboardNotification";

CGSize  const WUEmoticonsKeyboardDefaultSize            = (CGSize){320,216};
CGFloat const WUEmoticonsKeyboardToolsViewDefaultHeight = 45;


@interface WUEmoticonsKeyboard () <UIInputViewAudioFeedback>
@property (nonatomic,weak,readwrite) UIResponder<UITextInput>     *textInput;
@property (nonatomic,weak)           WUEmoticonsKeyboardToolsView *toolsView;
@property (nonatomic,weak)           UIImageView                  *backgroundImageView;
@property (nonatomic,strong)         NSArray                      *keyItemGroupViews;
@property (nonatomic,readonly)       CGRect                        keyItemGroupViewFrame;
@end

@implementation WUEmoticonsKeyboard

#pragma mark - TextInput

- (void)setInputViewToView:(UIView *)view {
    self.textInput.inputView = view;
    [self.textInput reloadInputViews];
}

- (void)attachToTextInput:(UIResponder<UITextInput> *)textInput {
    self.textInput = textInput;
    [self setInputViewToView:self];
}

- (void)switchToDefaultKeyboard {
    [self setInputViewToView:nil];
    self.textInput = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:WUEmoticonsKeyboardDidSwitchToDefaultKeyboardNotification object:self];
}

#pragma mark - Text Input

- (BOOL)textInputShouldReplaceTextInRange:(UITextRange *)range replacementText:(NSString *)replacementText {
    
    BOOL shouldChange = YES;
    
    NSInteger startOffset = [self.textInput offsetFromPosition:self.textInput.beginningOfDocument toPosition:range.start];
    NSInteger endOffset = [self.textInput offsetFromPosition:self.textInput.beginningOfDocument toPosition:range.end];
    NSRange replacementRange = NSMakeRange(startOffset, endOffset - startOffset);

    if ([self.textInput isKindOfClass:UITextView.class]) {
        UITextView *textView = (UITextView *)self.textInput;
        if ([textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]){
            shouldChange = [textView.delegate textView:textView shouldChangeTextInRange:replacementRange replacementText:replacementText];
        }
    }
    
    if ([self.textInput isKindOfClass:UITextField.class]) {
        UITextField *textField = (UITextField *)self.textInput;
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            shouldChange = [textField.delegate textField:textField shouldChangeCharactersInRange:replacementRange replacementString:replacementText];
        }
    }
    
    return shouldChange;
}

- (void)replaceTextInRange:(UITextRange *)range withText:(NSString *)text {
    if (range && [self textInputShouldReplaceTextInRange:range replacementText:text]) {
        [self.textInput replaceRange:range withText:text];
    }
}


- (void)resetTextStyle {
    //After changing text selection, should reset style.
    if ([_textInput isKindOfClass:[UITextView class]]) {
        UITextView* textView = (UITextView*)_textInput;
        NSRange wholeRange = NSMakeRange(0, textView.textStorage.length);
        
        [textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
        
        [textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontSize] range:wholeRange];
    }

}

#pragma mark - Action

- (void)insertEmoji:(WUEmoticonsKeyboardKeyItem *)keyItem{
    if ([_textInput isKindOfClass:[UITextView class]]) {
    UITextView* textView = (UITextView*)_textInput;
    //Create emoji attachment
    EmojiTextAttachment *emojiTextAttachment = [EmojiTextAttachment new];
    
    //Set tag and image
    emojiTextAttachment.emojiTag = keyItem.textToInput;
    emojiTextAttachment.image = keyItem.image;
    
    //Set emoji size
    emojiTextAttachment.emojiSize = kFontSize;
    
    //Insert emoji image
    [textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:emojiTextAttachment]
                                          atIndex:textView.selectedRange.location];
    
    //Move selection location
    textView.selectedRange = NSMakeRange(textView.selectedRange.location + 1, textView.selectedRange.length);
    
    //Reset text style
    [self resetTextStyle];
    }
}

- (void)inputText:(NSString *)text {
    [self replaceTextInRange:self.textInput.selectedTextRange withText:text];
}

- (void)inputkeyItem:(WUEmoticonsKeyboardKeyItem *)keyItem {
    [self insertEmoji:keyItem];
}

- (void)backspace {
    if (self.textInput.selectedTextRange.empty) {
        //Find the last thing we may input and delete it. And RETURN
        NSString *text = [self.textInput textInRange:[self.textInput textRangeFromPosition:self.textInput.beginningOfDocument toPosition:self.textInput.selectedTextRange.start]];
        for (WUEmoticonsKeyboardKeyItemGroup *group in self.keyItemGroups) {
            for (WUEmoticonsKeyboardKeyItem *item in group.keyItems) {
                if ([text hasSuffix:item.textToInput]) {
                    __block NSUInteger composedCharacterLength = 0;
                    [item.textToInput enumerateSubstringsInRange:NSMakeRange(0, item.textToInput.length)
                                                         options:NSStringEnumerationByComposedCharacterSequences
                                                      usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                                                          composedCharacterLength++;
                                                      }];
                    UITextRange *rangeToDelete = [self.textInput textRangeFromPosition:[self.textInput positionFromPosition:self.textInput.selectedTextRange.start offset:-composedCharacterLength] toPosition:self.textInput.selectedTextRange.start];
                    if (rangeToDelete) {
                        [self replaceTextInRange:rangeToDelete withText:@""];
                        return;
                    }
                }
            }
        }
        
        //If we cannot find the text. Do a delete backward.
        UITextRange *rangeToDelete = [self.textInput textRangeFromPosition:self.textInput.selectedTextRange.start toPosition:[self.textInput positionFromPosition:self.textInput.selectedTextRange.start offset:-1]];
        [self replaceTextInRange:rangeToDelete withText:@""];
    } else {
        [self replaceTextInRange:self.textInput.selectedTextRange withText:@""];
    }
}

#pragma mark - create & init

- (id)init {
    return [self initWithFrame:(CGRect){CGPointZero,WUEmoticonsKeyboardDefaultSize}];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupEmoticonsKeyboard];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupEmoticonsKeyboard];
}

- (void)setupEmoticonsKeyboard {
    self.backgroundColor = [UIColor blackColor];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    
    WUEmoticonsKeyboard *__weak weakSelf = self;
    
    self.toolsViewHeight = WUEmoticonsKeyboardToolsViewDefaultHeight;
    
    WUEmoticonsKeyboardToolsView *toolsView = [[WUEmoticonsKeyboardToolsView alloc] initWithFrame:self.toolsViewFrame];
    toolsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [toolsView setKeyboardSwitchButtonTappedBlock:^{
        [weakSelf switchToDefaultKeyboard];
    }];
    
    [toolsView setBackspaceButtonTappedBlock:^{
        [weakSelf backspace];
    }];
    
    [toolsView setSpaceButtonTappedBlock:^{
        [weakSelf inputText:@" "];
    }];
    
    [toolsView setKeyItemGroupSelectedBlock:^(WUEmoticonsKeyboardKeyItemGroup *keyItemGroup) {
        [weakSelf switchToKeyItemGroup:keyItemGroup];
    }];
    
    [self addSubview:toolsView];
    self.toolsView = toolsView;
}

+ (instancetype)keyboard {
    WUEmoticonsKeyboard *keyboard = [[WUEmoticonsKeyboard alloc] init];
    return keyboard;
}

#pragma mark - Layout

- (void)setToolsViewHeight:(CGFloat)toolsViewHeight {
    _toolsViewHeight = toolsViewHeight;
    [self setNeedsLayout];
}

- (CGRect)toolsViewFrame {
    return CGRectMake(0, CGRectGetHeight(self.bounds) - self.toolsViewHeight, CGRectGetWidth(self.bounds), self.toolsViewHeight);
}

- (CGRect)keyItemGroupViewFrame {
    return CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetMinY(self.toolsView.frame));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.toolsView.frame = self.toolsViewFrame;
    [self.keyItemGroupViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        view.frame = self.keyItemGroupViewFrame;
    }];
}

#pragma mark - KeyItems

- (void)setKeyItemGroups:(NSArray *)keyItemGroups {
    _keyItemGroups = [keyItemGroups copy];
    [self reloadKeyItemGroupViews];
    self.toolsView.keyItemGroups = keyItemGroups;
}

- (void)reloadKeyItemGroupViews {
    [self.keyItemGroupViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    __weak __typeof(&*self)weakSelf = self;
    self.keyItemGroupViews = nil;
    NSMutableArray *keyItemGroupViews = [NSMutableArray array];
    [self.keyItemGroups enumerateObjectsUsingBlock:^(WUEmoticonsKeyboardKeyItemGroup *obj, NSUInteger idx, BOOL *stop) {
        WUEmoticonsKeyboardKeyItemGroupView *keyItemGroupView = [[WUEmoticonsKeyboardKeyItemGroupView alloc] initWithFrame:weakSelf.keyItemGroupViewFrame];
        keyItemGroupView.keyItemGroup = obj;
        [keyItemGroupView setKeyItemTappedBlock:^(WUEmoticonsKeyboardKeyItem *keyItem) {
            [weakSelf keyItemTapped:keyItem];
        }];
        [keyItemGroupView setPressedKeyItemCellChangedBlock:^(WUEmoticonsKeyboardKeyCell *fromCell, WUEmoticonsKeyboardKeyCell *toCell) {
            if (weakSelf.keyItemGroupPressedKeyCellChangedBlock) {
                weakSelf.keyItemGroupPressedKeyCellChangedBlock(obj,fromCell,toCell);
            }
        }];
        [keyItemGroupViews addObject:keyItemGroupView];
    }];
    self.keyItemGroupViews = [keyItemGroupViews copy];
}

- (void)switchToKeyItemGroup:(WUEmoticonsKeyboardKeyItemGroup *)keyItemGroup {
    [self.keyItemGroupViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.keyItemGroupViews enumerateObjectsUsingBlock:^(WUEmoticonsKeyboardKeyItemGroupView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.keyItemGroup isEqual:keyItemGroup]) {
            obj.frame = self.keyItemGroupViewFrame;
            obj.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self addSubview:obj];
            *stop = YES;
        }
    }];
}

- (void)keyItemTapped:(WUEmoticonsKeyboardKeyItem *)keyItem {
    //[self inputText:keyItem.textToInput];
    [self inputkeyItem:keyItem];
    [UIDevice.currentDevice playInputClick];
}

#pragma mark - UIInputViewAudioFeedback

- (BOOL) enableInputClicksWhenVisible {
    return self.enableStandardSystemKeyboardClickSound;
}

#pragma mark - Apperance

- (UIButton *)emoticonsKeyboardButtonOfType:(WUEmoticonsKeyboardButton)type {
    switch (type) {
        case WUEmoticonsKeyboardButtonKeyboardSwitch:
            return self.toolsView.keyboardSwitchButton;
        case WUEmoticonsKeyboardButtonBackspace:
            return self.toolsView.backspaceButton;
        case WUEmoticonsKeyboardButtonSpace:
            return self.toolsView.spaceButton;
        default:
            return nil;
    }
}

- (void)setImage:(UIImage *)image forButton:(WUEmoticonsKeyboardButton)button state:(UIControlState)state {
    [[self emoticonsKeyboardButtonOfType:button] setImage:image forState:state];
    [self setNeedsLayout];
}

- (UIImage *)imageForButton:(WUEmoticonsKeyboardButton)button state:(UIControlState)state {
    return [[self emoticonsKeyboardButtonOfType:button] imageForState:state];
}

- (void)setBackgroundImage:(UIImage *)image forButton:(WUEmoticonsKeyboardButton)button state:(UIControlState)state {
    [[self emoticonsKeyboardButtonOfType:button] setBackgroundImage:image forState:state];
    [self setNeedsLayout];
}

- (UIImage *)backgroundImageForButton:(WUEmoticonsKeyboardButton)button state:(UIControlState)state {
    return [[self emoticonsKeyboardButtonOfType:button] backgroundImageForState:state];
}

- (void)setAttributedTitle:(NSAttributedString *)title forButton:(WUEmoticonsKeyboardButton)button state:(UIControlState)state {
    [[self emoticonsKeyboardButtonOfType:button] setAttributedTitle:title forState:state];
    [self setNeedsLayout];
}

- (NSAttributedString *)attributedTitleForButton:(WUEmoticonsKeyboardButton)button state:(UIControlState)state {
    return [[self emoticonsKeyboardButtonOfType:button] attributedTitleForState:state];
}

- (void)setBackgroundImage:(UIImage *)image {
    [self.backgroundImageView setImage:image];
}

- (void)setBackgroundImage:(UIImage *)image forKeyItemGroup:(WUEmoticonsKeyboardKeyItemGroup *)keyItemGroup {
    [self.keyItemGroupViews enumerateObjectsUsingBlock:^(WUEmoticonsKeyboardKeyItemGroupView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.keyItemGroup isEqual:keyItemGroup]) {
            obj.backgroundImageView.image = image;
        }
    }];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forKeyItemGroup:(WUEmoticonsKeyboardKeyItemGroup *)keyItemGroup {
    [self.keyItemGroupViews enumerateObjectsUsingBlock:^(WUEmoticonsKeyboardKeyItemGroupView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.keyItemGroup isEqual:keyItemGroup]) {
            obj.backgroundImageView.backgroundColor = backgroundColor;
        }
    }];
}

@end

@implementation UIResponder (WUEmoticonsKeyboard)

- (WUEmoticonsKeyboard *)emoticonsKeyboard {
    if ([self.inputView isKindOfClass:[WUEmoticonsKeyboard class]]) {
        return (WUEmoticonsKeyboard *)self.inputView;
    }
    return nil;
}

- (void)switchToDefaultKeyboard {
    [self.emoticonsKeyboard switchToDefaultKeyboard];
}

- (void)switchToEmoticonsKeyboard:(WUEmoticonsKeyboard *)keyboard {
    if ([self conformsToProtocol:@protocol(UITextInput)] && [self respondsToSelector:@selector(setInputView:)]) {
        [keyboard attachToTextInput:(UIResponder<UITextInput> *)self];
    }
}

@end
