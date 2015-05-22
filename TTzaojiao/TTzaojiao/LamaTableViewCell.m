//
//  LamaTableViewCell.m
//  TTzaojiao
//
//  Created by dalianembeded on 15/4/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "LamaTableViewCell.h"
#import "LamaModel.h"
#import "TTBaseViewController.h"
#import "NSString+Extension.h"

@implementation LamaTableViewCell
+ (instancetype)lamaCellWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"lamaCell";
    
    LamaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[LamaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addSubviews];
    }
    return self;
}


-(void)addSubviews{
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120.f);
    
    UIImageView* imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView];
    _imgView = imageView;
    
    imageView.frame = CGRectMake(8.f, 8.f, 120.f, 104.f);
    
    UILabel* title = [[UILabel alloc]init];
    [self.contentView addSubview:title];
    _descLabel = title;
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:16.f];
    title.textColor = [UIColor blackColor];
    
    UILabel* timetitle = [[UILabel alloc]init];
    [self.contentView addSubview:timetitle];
    _time1Label = timetitle;
    
    timetitle.numberOfLines = 0;
    timetitle.textAlignment = NSTextAlignmentRight;
    timetitle.font = [UIFont systemFontOfSize:16.f];
    timetitle.textColor = [UIColor blackColor];
    
    UILabel* time = [[UILabel alloc]init];
    [self.contentView addSubview:time];
    _time2Label = time;
    time.numberOfLines = 0;
    time.textAlignment = NSTextAlignmentLeft;
    time.font = [UIFont systemFontOfSize:16.f];
    time.textColor = [UIColor purpleColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        //desc
//        UILabel *descLabel  = [[UILabel alloc]init];
//        [self.contentView addSubview:descLabel];
//        _descLabel = descLabel;
//        
//        
//        _descLabel.textAlignment =  NSTextAlignmentCenter ;
//        //_descLabel.font = kTimeFont;
//        
//        //time1
//        UILabel *time1Label  = [[UILabel alloc]init];
//        [self.contentView addSubview:time1Label];
//        _time1Label = time1Label;
//        
//        
//        _time1Label.textAlignment =  NSTextAlignmentCenter ;
//        //_time2Label.font = kTimeFont;
//
//        //time2
//        UILabel *time2Label  = [[UILabel alloc]init];
//        [self.contentView addSubview:time2Label];
//        _time2Label = time2Label;
//        
//        
//        _time2Label.textAlignment =  NSTextAlignmentCenter ;
//        //_time2Label.font = kTimeFont;
//
//        //img
//        UIImageView *imgView = [[UIImageView alloc]init];
//       
//        [self.contentView addSubview:imgView];
//        _imgView = imgView;
//        
//        
//    }
//    
//    return self;
//}
- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];

   // [dateFormatter release];
    
    return destDate;
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    if (_lamaModel!= nil) {
        CGRect titlebound = [_lamaModel.i_name boundByFont:[UIFont systemFontOfSize:16.f] andWidth:[UIScreen mainScreen].bounds.size.width-_imgView.right-8.f];
        
        _descLabel.frame = CGRectMake(_imgView.right+8.f, 8.f, [UIScreen mainScreen].bounds.size.width-_imgView.right-8.f, titlebound.size.height);
        
        CGRect time2titlebound = [_time2Label.text boundByFont:[UIFont systemFontOfSize:16.f] andWidth:([UIScreen mainScreen].bounds.size.width-_imgView.right-8.f)*0.5f];
        _time2Label.frame = CGRectMake(_imgView.right+8.f+([UIScreen mainScreen].bounds.size.width-_imgView.right-8.f)*0.5f, _imgView.bottom- time2titlebound.size.height, ([UIScreen mainScreen].bounds.size.width-_imgView.right-8.f)*0.5f, time2titlebound.size.height);
        
        CGRect timetitlebound = [_time1Label.text boundByFont:[UIFont systemFontOfSize:16.f] andWidth:([UIScreen mainScreen].bounds.size.width-_imgView.right-8.f)*0.5f];
        _time1Label.frame = CGRectMake(_imgView.right+8.f, _time2Label.up, ([UIScreen mainScreen].bounds.size.width-_imgView.right-8.f)*0.5f, timetitlebound.size.height);

    }
}


- (void)setLamaModel:(LamaModel *)lamaModel
{
    _lamaModel = lamaModel;
    _descLabel.text = lamaModel.i_name;
    
    _time1Label.text = @"剩余时间：";

    NSDate *date = [self dateFromString:lamaModel.i_otime_end];
    NSDate *now = [NSDate date];
    
     NSTimeInterval intetval =   [date timeIntervalSinceDate:now
                                                 ];
    int day =(int) (intetval/(60*60*24));
    
    int hour = (int)((intetval - (int )day*(60*60*24))/(60*60));
    
    _time2Label.text =[NSString stringWithFormat:@"%d天%d小时",day,hour];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",TTBASE_URL,_lamaModel.i_pic];
    NSArray * tempArray =  [url componentsSeparatedByString:@"|"];
   
    [_imgView setImageWithURL:[NSURL URLWithString: [tempArray firstObject]]];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120.f);
    //[_imgView setImage:[UIImage imageNamed:_lamaModel.i_pic]];
}


    

@end
