//
//  TTWoChengzhangHistoryCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-16.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoChengzhangHistoryCell.h"
#import "NSString+Extension.h"

@implementation TTWoChengzhangHistoryCell
+(instancetype)woChengzangHistoryCellWithTableView:(UITableView *)tableView{
        static NSString* ID = @"ChengZhangTestCell";
        TTWoChengzhangHistoryCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[TTWoChengzhangHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
        
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return self;
}

-(void)awakeFromNib{
     self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/*
 {
 TestDate = "2015-5-16 17:27:41";
 id = 6273;
 "tige_sort" = "\U4e25\U91cd\U504f\U80d6";
 }
 */
-(void)setGrowTestDict:(NSDictionary *)growTestDict{
    _growTestDict = growTestDict;
    NSString* dateString = [NSString getChnYMDWithString:[growTestDict objectForKey:@"TestDate"]];
    
    _date.text = dateString;

    _result.text  = [growTestDict objectForKey:@"tige_sort"];
    if (_result.text == nil) {
        _result.text = [growTestDict objectForKey:@"qizhi_sort"];
    }
    if ([_result.text isEqualToString:@"正常"]) {
        [_point setImage:[UIImage imageNamed:@"point_green"]];
    }else if([_result.text rangeOfString:@"严重"].length != 0){
        [_point setImage:[UIImage imageNamed:@"point_yellow"]];
    }else{
        [_point setImage:[UIImage imageNamed:@"point_gray"]];
    }
    
}

@end
