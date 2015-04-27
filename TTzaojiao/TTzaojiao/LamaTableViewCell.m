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
@implementation LamaTableViewCell
+ (instancetype)lamaCellWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"lamaCell";
    
    LamaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (nil == cell) {
        cell = [[LamaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
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
    
    //[_imgView setImage:[UIImage imageNamed:_lamaModel.i_pic]];
}


    

@end
