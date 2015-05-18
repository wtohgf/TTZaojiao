//
//  TTWoMuyingCaoTableViewCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-16.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoMuyingCaoTableViewCell.h"
#import "NSString+Extension.h"
#import "UIView+NKMoreAttribute.h"

@implementation TTWoMuyingCaoTableViewCell

+(instancetype)woMuyingCaoTableViewCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"MuyingCaoCell";
    TTWoMuyingCaoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTWoMuyingCaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString* titletext = @"宝宝做操好处多";
    
    NSString* contenttext = @"    母婴操是促进宝宝动作发展的一个好方法, 婴儿1个月后长期坚持每天做母婴操, 不但可以增强宝宝的生理功能，提高宝宝对外界自然环境的适应能力, 促进宝宝动作发展, 使宝宝的动作变的更加灵敏, 肌肉更发达, 同时可促进宝宝神经心里的发展;\n    长期坚持做母婴操可使宝宝初步的,无意的,无秩序的动作, 逐步形成和发展分化为有目的的协调动作, 为思维能力打下基础; 做操时伴着音乐, 让宝宝接触多维空间, 促进左右脑平衡发展, 从而促进宝宝的智力发展";
    
    UILabel* title = [[UILabel alloc]init];
    _title = title;
    title.text = titletext;
    [self.contentView addSubview:title];
    title.font = [UIFont systemFontOfSize:18.f];
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    CGRect bound = [title.text boundByFont:title.font andWidth:[UIScreen mainScreen].bounds.size.width - 16.f];
    title.frame = CGRectMake(8.f, 0, [UIScreen mainScreen].bounds.size.width, bound.size.height+20.f);

    title.textColor = [UIColor colorWithRed:206.f/255.f green:88.f/255.f blue:113.f/255.f alpha:1.f];
    UILabel* content = [[UILabel alloc]init];
    _content = content;
    content.text = contenttext;
    [self.contentView addSubview:content];
    content.font = [UIFont systemFontOfSize:14.f];
    bound = [content.text boundByFont:content.font andWidth:[UIScreen mainScreen].bounds.size.width-16.f];
    content.numberOfLines = 0;
    content.frame = CGRectMake(8.f, title.bottom, [UIScreen mainScreen].bounds.size.width-16.f, bound.size.height+10.f);
    content.textColor = [UIColor colorWithRed:206.f/255.f green:88.f/255.f blue:113.f/255.f alpha:1.f];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, title.height+content.height + 30.f);
    
}

+(CGFloat)cellHeight{
    NSString* titletext = @"宝宝做操好处多";
    CGRect boundtitle = [titletext boundByFont:[UIFont systemFontOfSize:18.f] andWidth:[UIScreen mainScreen].bounds.size.width-16.f];
    
    NSString* contenttext = @"    母婴操是促进宝宝动作发展的一个好方法, 婴儿1个月后长期坚持每天做母婴操, 不但可以增强宝宝的生理功能，提高宝宝对外界自然环境的适应能力, 促进宝宝动作发展, 使宝宝的动作变的更加灵敏, 肌肉更发达, 同时可促进宝宝神经心里的发展;\\n    长期坚持做母婴操可使宝宝初步的,无意的,无秩序的动作, 逐步形成和发展分化为有目的的协调动作, 为思维能力打下基础; 做操时伴着音乐, 让宝宝接触多维空间, 促进左右脑平衡发展, 从而促进宝宝的智力发展";
    CGRect boundcontent = [contenttext boundByFont:[UIFont systemFontOfSize:14.f] andWidth:[UIScreen mainScreen].bounds.size.width-16.f];
    
    return boundtitle.size.height+boundcontent.size.height + 60.f;
    
}

@end
