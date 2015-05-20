//
//  LamaTableViewCellContact.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/6.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaTableViewCellContact.h"


#import "LamaTableViewCellModelFrame.h"

#define  kTextFont  [UIFont systemFontOfSize:13]

@implementation LamaTableViewCellContact

+ (instancetype)LamaTableViewCellContactWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"lamaCellContact";
    
    LamaTableViewCellContact *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[LamaTableViewCellContact alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //cell.backgroundColor = [UIColor purpleColor];
    return cell;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    [_companyLabel setFrame:CGRectMake(8, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    [_addresssLabel setFrame:CGRectMake(8, 20, [UIScreen mainScreen].bounds.size.width, 20)];
    [_telLabel setFrame:CGRectMake(8, 40, [UIScreen mainScreen].bounds.size.width, 20)];
    [_telButton setFrame:CGRectMake(8, 60, [UIScreen mainScreen].bounds.size.width-16.f, 47)];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //company
        UILabel *companyLabel  = [[UILabel alloc]init];
        [self.contentView addSubview:companyLabel];
        _companyLabel = companyLabel;
        _companyLabel.font = kTextFont;
        
        //addresss
        UILabel *addresssLabel  = [[UILabel alloc]init];
        [self.contentView addSubview:addresssLabel];
        _addresssLabel = addresssLabel;
        _addresssLabel.font = kTextFont;
        
        //tel
        UILabel *telLabel  = [[UILabel alloc]init];
        [self.contentView addSubview:telLabel];
        _telLabel = telLabel;
        _telLabel.font = kTextFont;
        
        //button
        UIButton *telButton  = [[UIButton alloc]init];
        [self.contentView addSubview:telButton];
        _telButton = telButton;
        [_telButton setImage:[UIImage imageNamed:@"street_call"] forState:UIControlStateNormal];
        [_telButton addTarget:self action:@selector(contactCompanyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}


- (void)setModelFrame:(LamaTableViewCellModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    _addresssLabel.text = [NSString stringWithFormat:@"商家名称：%@",modelFrame.model.i_addresss];
    _companyLabel.text = [NSString stringWithFormat:@"商家地址：%@",modelFrame.model.i_company];
    
    _telLabel.text = [NSString stringWithFormat:@"联系电话：%@",modelFrame.model.i_tel];
    
}

-(void) contactCompanyBtnClick:(UIButton*)button
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"致电商家" message:_telLabel.text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    [alert show];
    return;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        NSString *tel = [NSString stringWithFormat:@"tel://%@",_modelFrame.model.i_tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    }
}
@end
