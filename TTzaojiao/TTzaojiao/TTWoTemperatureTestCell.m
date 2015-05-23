//
//  TTWoTemperatureTestCell.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoTemperatureTestCell.h"
@interface TTWoTemperatureTestCell()

@end
@implementation TTWoTemperatureTestCell



+ (instancetype)WoTemperatureTestCellWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"TemperatureCell";
    
    TTWoTemperatureTestCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[TTWoTemperatureTestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    return cell;
}

//@property (weak, nonatomic)  UILabel *titleLabel;
//@property (weak, nonatomic)  UILabel *resultLabel;
//
//@property (weak, nonatomic)  UILabel *nameTitleLabel;
//@property (weak, nonatomic)  UILabel *nameLabel;
//
//@property (weak, nonatomic)  UILabel *pingjiaTitleLabel;
//@property (weak, nonatomic)  UILabel *pingjiaLabel;
//
//@property (weak, nonatomic)  UILabel *jianyiTitleLabel;
//@property (weak, nonatomic)  UILabel *jianyiLabel;
#define ktitleHeight 30.0f
#define ksubtitleHeight 15.0f

#define ktitleWidth 100.0f
#define ksubtitleWidth 100.0f
#define kPadding 8.0f
- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat screenwidth = [UIScreen mainScreen].bounds.size.width;
       if (_modelArray == nil) {
        [_titleLabel setFrame:CGRectMake(0, 0, ktitleWidth,ktitleHeight) ];
        [_resultLabel setFrame:CGRectMake(0, 0, 50,50) ];
           [_lineView setFrame:CGRectMake(0, 0, screenwidth, 1)];
           [_nameTitleLabel setFrame:CGRectMake(0, 0, 50,50) ];
           [_nameLabel setFrame:CGRectMake(0, 0, 50,50) ];
           [_pingjiaTitleLabel setFrame:CGRectMake(0, 0, 50,50) ];
           [_pingjiaLabel setFrame:CGRectMake(0, 0, 50,50) ];
           [_jianyiTitleLabel setFrame:CGRectMake(0, 0, 50,50) ];
           [_jianyiLabel setFrame:CGRectMake(0, 0, 50,50) ];
           
        
    }
    else
    {
        [_titleLabel setFrame:CGRectMake(kPadding, 0, ktitleWidth,ktitleHeight) ];
        [_resultLabel setFrame:CGRectMake(screenwidth-ktitleWidth-kPadding, 0, ktitleWidth,ktitleHeight) ];
        [_lineView setFrame:CGRectMake(0, CGRectGetMaxY(_resultLabel.frame), screenwidth, 1)];
        //NSLog(@"%@",NSStringFromCGRect(_lineView.frame));

        [_nameTitleLabel setFrame:CGRectMake(kPadding, CGRectGetMaxY(_lineView.frame)+kPadding, ksubtitleWidth,ksubtitleHeight) ];
        [_nameLabel setFrame:CGRectMake(kPadding,
                                        CGRectGetMaxY(_nameTitleLabel.frame)+kPadding, CGRectFromString(_modelArray[1]).size.width,CGRectFromString(_modelArray[1]).size.height ) ];
     //NSLog(@"%@",NSStringFromCGRect(_nameLabel.frame));
    
    
                [_pingjiaTitleLabel setFrame:CGRectMake(kPadding, CGRectGetMaxY(_nameLabel.frame)+kPadding, ksubtitleWidth,ksubtitleHeight) ];
        [_pingjiaLabel setFrame:CGRectMake(kPadding,
                                           CGRectGetMaxY(_pingjiaTitleLabel.frame)+kPadding, CGRectFromString(_modelArray[2]).size.width,CGRectFromString(_modelArray[2]).size.height ) ];
    //NSLog(@"%@",NSStringFromCGRect(_pingjiaLabel.frame));

        [_jianyiTitleLabel setFrame:CGRectMake(kPadding, CGRectGetMaxY(_pingjiaLabel.frame)+kPadding, ksubtitleWidth,ksubtitleHeight) ];
        [_jianyiLabel setFrame:CGRectMake(kPadding,
                                          CGRectGetMaxY(_jianyiTitleLabel.frame)+kPadding, CGRectFromString(_modelArray[3]).size.width,CGRectFromString(_modelArray[3]).size.height ) ];
     //NSLog(@"%@",NSStringFromCGRect(_jianyiLabel.frame));
    }
    
    
}
#define ktitleFont 14.0f
#define ksubtitleFont 12.0f
#define kcontentFont 12.0f
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
     
        
          //titile
         UILabel *titleLabel  = [[UILabel alloc]init];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        _titleLabel.font = [UIFont systemFontOfSize:ktitleFont];
        //_titleLabel.textAlignment = NSTextAlignmentCenter ;
        
        UILabel *resultLabel= [[UILabel alloc]init];
        [self.contentView addSubview:resultLabel];
        _resultLabel = resultLabel;
        _resultLabel.font = [UIFont systemFontOfSize:ktitleFont];
        _resultLabel.textAlignment = NSTextAlignmentRight ;;
        
        UIView *lineView = [[UIView alloc]init];
        [self.contentView addSubview:lineView];
        _lineView = lineView;
        _lineView.backgroundColor =  [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];


        //name
        UILabel *nameTitleLabel= [[UILabel alloc]init];
        [self.contentView addSubview:nameTitleLabel];
        _nameTitleLabel = nameTitleLabel;
        _nameTitleLabel.font = [UIFont systemFontOfSize:ksubtitleFont];
        _nameTitleLabel.textColor = [UIColor purpleColor];

        UILabel *nameLabel= [[UILabel alloc]init];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        _nameLabel.font = [UIFont systemFontOfSize:kcontentFont];
        _nameLabel.numberOfLines = 0;
        
        
        //pingjia
        UILabel *pingjiaTitleLabel= [[UILabel alloc]init];
        [self.contentView addSubview:pingjiaTitleLabel];
        _pingjiaTitleLabel = pingjiaTitleLabel;
        _pingjiaTitleLabel.font = [UIFont systemFontOfSize:ksubtitleFont];
        _pingjiaTitleLabel.textColor = [UIColor purpleColor];
        
        UILabel *pingjiaLabel= [[UILabel alloc]init];
        [self.contentView addSubview:pingjiaLabel];
        _pingjiaLabel = pingjiaLabel;
        _pingjiaLabel.font = [UIFont systemFontOfSize:kcontentFont];
        _pingjiaLabel.numberOfLines = 0;
        //jianyi
        
        ;
        UILabel *jianyiTitleLabel= [[UILabel alloc]init];
        [self.contentView addSubview:jianyiTitleLabel];
        _jianyiTitleLabel = jianyiTitleLabel;
        _jianyiTitleLabel.font = [UIFont systemFontOfSize:ksubtitleFont];
        _jianyiTitleLabel.textColor = [UIColor purpleColor];
        
        UILabel *jianyiLabel= [[UILabel alloc]init];
        [self.contentView addSubview:jianyiLabel];
        _jianyiLabel = jianyiLabel;
        _jianyiLabel.font = [UIFont systemFontOfSize:kcontentFont];
        _jianyiLabel.numberOfLines = 0;
    }
    
    return self;
}


@end
