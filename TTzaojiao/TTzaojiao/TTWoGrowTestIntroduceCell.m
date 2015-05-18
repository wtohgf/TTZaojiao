//
//  TTWoGrowTestIntroduceCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoGrowTestIntroduceCell.h"
#import "NSString+Extension.h"
#import "UIView+NKMoreAttribute.h"

@implementation TTWoGrowTestIntroduceCell
+(instancetype)woGrowTestIntroduceCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"woGrowTestIntrouceCell";
    TTWoGrowTestIntroduceCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[TTWoGrowTestIntroduceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    UILabel* label = [[UILabel alloc]init];
    _title = label;
    label.textColor = [UIColor colorWithRed:174.f/255.f green:68.f/255.f blue:77.f/255.f alpha:1.f];
    [self.contentView addSubview:label];
    
    
    UILabel* content = [[UILabel alloc]init];
    _content = content;
    content.textColor = [UIColor colorWithRed:174.f/255.f green:68.f/255.f blue:77.f/255.f alpha:1.f];
    [self.contentView addSubview:content];
}

-(void)setTitleContent:(NSDictionary *)titleContent{
    _titleContent = titleContent;
    _title.text = [titleContent objectForKey:@"title"];
    _title.font = [UIFont systemFontOfSize:14.f];
    _title.backgroundColor = [UIColor colorWithRed:247.f/255.f green:215.f/255.f blue:226.f/255.f alpha:1.f];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30.f);
    _title.numberOfLines = 0;
    _content.text = [titleContent objectForKey:@"content"];
    _content.font = [UIFont systemFontOfSize:14.f];
    CGRect contentbound = [_content.text boundByFont:[UIFont systemFontOfSize:14.f] andWidth:[UIScreen mainScreen].bounds.size.width];
    _content.frame = CGRectMake(8.f, _title.bottom, [UIScreen mainScreen].bounds.size.width-16.f, contentbound.size.height+30.f);
    _content.numberOfLines = 0;
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30.f + _content.height +30.f);
}

+(CGFloat)cellHeightWith:(NSDictionary *)content{
    CGRect contentbound = [[content objectForKey:@"content"] boundByFont:[UIFont systemFontOfSize:14.f] andWidth:[UIScreen mainScreen].bounds.size.width];
    
    return 30.f+contentbound.size.height+30.f;
}

@end
