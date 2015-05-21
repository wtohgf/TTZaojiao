//
//  TTWoGrowTestReportNianlingCellTableViewCell.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/5/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoGrowTestReportTizhongCellTableViewCell.h"
#import "TTUserModelTool.h"

@implementation TTWoGrowTestReportTizhongCellTableViewCell



+ (instancetype)WoGrowTestReportTizhongCellWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"tigeCell";
    
    TTWoGrowTestReportTizhongCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[TTWoGrowTestReportTizhongCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    return cell;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    [_titleLabel setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    [_picView setFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, _modelFrame.nianlingPicHeight)];
    if (_modelFrame == nil) {
        [_descLabel setFrame:CGRectMake(8, 130, 50,50) ];
        
        
    }
    else
    {
        [_descLabel setFrame:CGRectMake(8, _modelFrame.nianlingPicHeight+30, _modelFrame.tizhongnianlingFrame.size.width,_modelFrame.tizhongnianlingFrame.size.height) ];
    }
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //titile
        UILabel *companyLabel  = [[UILabel alloc]init];
        [self.contentView addSubview:companyLabel];
        _titleLabel = companyLabel;
        //_titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter ;
        
        //pic
        UIView *pic  = [[UIView alloc]init];
        [self.contentView addSubview:pic];
        _picView = pic;
        
        
        //desc
        UILabel *desc  = [[UILabel alloc]init];
        [self.contentView addSubview:desc];
        _descLabel = desc;
        _descLabel.font = [UIFont systemFontOfSize:14.0f];
        _descLabel.numberOfLines = 0;
    }
    
    return self;
}

- (void)setModelFrame:(TTWoGrowTestReportFrame *)modelFrame
{
    _modelFrame = modelFrame;
    _titleLabel.text = @"体重发育曲线图";
    //_picView
#pragma warning
    //需要男女，身高，体重
    
    NSString * gender = [TTUserModelTool sharedUserModelTool].logonUser.gender;
    if ([gender isEqualToString:@"1"] ) {
       [self test:@"tizhong_nianling_male.png" andLeftImg:@"tizhong_v.png" andBottomImg:@"nianling_h.png" andpicType:3];
        
    }
    else
    {
       [self test:@"tizhong_nianling_female.png" andLeftImg:@"tizhong_v.png" andBottomImg:@"nianling_h.png" andpicType:3];
    }

    
    _descLabel.text = modelFrame.model.tige_tizhong_content;
}



#define ktizhongShengaoAll (15.0+30+489+15.0)
#define ktizhongShengaoLeftRatio 30/ktizhongShengaoAll
#define ktizhongShengaoPicRatio 489/ktizhongShengaoAll
#define ktizhongShengaoPaddingRatio 15/ktizhongShengaoAll

#define knianlingShengaoAll (15.0+30+503+15.0)
#define knianlingShengaoLeftRatio 30/(15.0+30+503+15.0)
#define knianlingShengaoPicRatio 503/(15.0+30+503+15.0)
#define knianlingShengaoPaddingRatio 15/(15.0+30+503+15.0)

- (void) test:(NSString*)centerimg andLeftImg:(NSString*)leftimg andBottomImg:(NSString*)bottomimg andpicType:(int)type
{
    //容器view
    // UIView * picView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 100)];
    //[self.view addSubview:picView];
    
    //中间图
    UIImageView *tempView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:centerimg]];
    CGFloat picW = CGImageGetWidth(tempView.image.CGImage);
    CGFloat picH = CGImageGetHeight(tempView.image.CGImage);
    CGFloat picWidth;
    if (type == 1) {
        picWidth = [UIScreen mainScreen].bounds.size.width*ktizhongShengaoPicRatio;
    }
    else
    {
        picWidth = [UIScreen mainScreen].bounds.size.width*knianlingShengaoPicRatio;
    }
    
    CGFloat picHeight = (CGFloat)((picWidth * picH)/picW) ;
    CGFloat picX;
    if (type == 1) {
        picX = [UIScreen mainScreen].bounds.size.width*(ktizhongShengaoPaddingRatio+ktizhongShengaoLeftRatio);
    }
    else
    {
        picX = [UIScreen mainScreen].bounds.size.width*(knianlingShengaoPaddingRatio+knianlingShengaoLeftRatio);
    }
    CGFloat picY = 0;
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(picX, picY, picWidth, picHeight)];
    UIImageView *centerImgView = [[UIImageView alloc]initWithFrame:centerView.bounds];
    [centerImgView setImage:[UIImage imageNamed:centerimg]];
    [centerView addSubview:centerImgView];
    [_picView addSubview:centerView];
    
    //底部图
    UIImageView *tempView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:bottomimg]];
    CGFloat bottomW = CGImageGetWidth(tempView3.image.CGImage);
    CGFloat bottomH = CGImageGetHeight(tempView3.image.CGImage);
    CGFloat bottomWidth = picWidth;
    CGFloat bottomHeight = (CGFloat)((bottomWidth * bottomH)/bottomW) ;
    CGFloat bottomX = picX;
    CGFloat bottomY = picHeight;
    
    UIImageView *bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(bottomX, bottomY, bottomWidth, bottomHeight)];
    [bottomView setImage:[UIImage imageNamed:bottomimg]];
    [_picView addSubview:bottomView];
    
    //左边图
    UIImageView *tempView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:leftimg]];
    CGFloat leftW = CGImageGetWidth(tempView2.image.CGImage);
    CGFloat leftH = CGImageGetHeight(tempView2.image.CGImage);
    
    //CGFloat leftHeight = (bottomHeight+ picHeight)  ;
    CGFloat leftWidth  ;
    if (type == 1) {
        leftWidth = [UIScreen mainScreen].bounds.size.width*ktizhongShengaoLeftRatio;
    }
    else
    {
        leftWidth = [UIScreen mainScreen].bounds.size.width*knianlingShengaoLeftRatio;
    }
    
    //CGFloat leftWidth = [UIScreen mainScreen].bounds.size.width*ktizhongShengaoLeftRatio;
    CGFloat leftHeight = (CGFloat)((leftWidth * leftH)/leftW) ;
    CGFloat leftX = picX-leftWidth;
    CGFloat leftY = 0;
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(leftX, leftY, leftWidth, leftHeight)];
    [leftView setImage:[UIImage imageNamed:leftimg]];
    [_picView addSubview:leftView];
#pragma warning
    //画点 临时数据测试
    float tizhong = [_modelFrame.model.Weight floatValue];
    float shengao = [_modelFrame.model.Height floatValue];
    float nianling = [_modelFrame.model.yueling floatValue];
    CGFloat pointX = picWidth/(14*5) * (shengao-50);
    CGFloat pointY;
    if (type == 1) {
        pointX = picWidth/(14*5) * (shengao-50);
        pointY = picHeight- picHeight
        /(18)*tizhong/2;
        
    }
    else if(type == 2)
    {
        pointX = picWidth/(7*6) * nianling /2;
        pointY = picHeight- picHeight
        /(23)*((shengao-35)/5);
        
        
    }
    else
    {
        pointX = picWidth/(7*6) * nianling /2;
        pointY = picHeight- picHeight
        /(18)*tizhong/2;
    }
    UIView *point = [[UIView alloc]initWithFrame:CGRectMake(pointX , pointY, 6, 6)];
    point.center = CGPointMake(pointX, pointY);
    //[picView addSubview:point];
    [point setBackgroundColor:[UIColor redColor]];
    point.layer.borderWidth = 1;
    point.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:0.710 green:0.251 blue:0.357 alpha:1.000]);
    point.layer.cornerRadius = 3.f;
    
    [centerView addSubview:point];
    
    
    
    
    
}


@end
