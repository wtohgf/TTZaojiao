//
//  TTZaojiaoIntroduceCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-9.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTZaojiaoIntroduceCell.h"

@implementation TTZaojiaoIntroduceCell

+(instancetype)zaojiaoIntroduceCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"IntroduceCell";
    
    TTZaojiaoIntroduceCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTZaojiaoIntroduceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    UILabel * label = [[UILabel alloc]init];
    _introduceText = label;
    [self.contentView addSubview:label];
}

-(void)setLogonUser:(UserModel *)logonUser{
    _logonUser = logonUser;
    NSString* introduce = [NSString stringWithFormat:INTRODUCETEXT,logonUser.name, logonUser.birthday, [NSString getMounthOfDateString:logonUser.birthday]];
    
    NSDictionary* textAttr = @{
                                NSForegroundColorAttributeName:[UIColor colorWithRed:152.0/255.0 green:82.0/255.0 blue:146.0/255.0 alpha:1.0f],
                                NSFontAttributeName:[UIFont systemFontOfSize:14.f]
                                };
    
    NSAttributedString* attrIntr = [[NSAttributedString alloc]initWithString:introduce attributes:textAttr];
 
    [_introduceText setAttributedText:attrIntr];
    
    _introduceText.numberOfLines = 0;
    _introduceText.font = [UIFont systemFontOfSize:14.f];
    
    CGRect bound = [_introduceText.text boundByFont:[UIFont systemFontOfSize:14.f] andWidth:ScreenWidth-2*TTBlogTableBorder];
    
    _introduceText.frame = CGRectMake(TTBlogTableBorder, TTBlogTableBorder*2, bound.size.width, bound.size.height);
    self.frame = CGRectMake(0, 0, ScreenWidth, bound.size.height + 2*TTBlogTableBorder);
}

+(CGFloat)cellHeightWithModel:(UserModel*)logonUser{
    NSString* introduce = [NSString stringWithFormat:INTRODUCETEXT, logonUser.name, logonUser.birthday, [NSString getMounthOfDateString:logonUser.birthday]];
    CGRect bound = [introduce boundByFont:[UIFont systemFontOfSize:14.f] andWidth:ScreenWidth-2*TTBlogTableBorder];
    return bound.size.height + 4*TTBlogTableBorder;
}

@end
