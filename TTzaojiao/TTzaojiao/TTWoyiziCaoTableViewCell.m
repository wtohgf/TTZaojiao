//
//  TTWoyiziCaoTableViewCell.m
//  TTzaojiao
//
//  Created by hegf on 15-5-15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoyiziCaoTableViewCell.h"

@implementation TTWoyiziCaoTableViewCell
+(instancetype)woyiziCaoTableViewCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"TTWoyiziCaoTableViewCell";
    TTWoyiziCaoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TTWoyiziCaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
    
}

-(void)awakeFromNib{
    
    [_pic1.layer setCornerRadius:25.f];
    _pic1.layer.masksToBounds = YES;

    [_pic2.layer setCornerRadius:25.f];
    _pic2.layer.masksToBounds = YES;
    
    [_pic3.layer setCornerRadius:25.f];
    _pic3.layer.masksToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

-(void)setTitlePicsDict:(NSDictionary *)titlePicsDict{
    
    if (titlePicsDict == nil) {
        return;
    }
    _titlePicsDict = titlePicsDict;
    
    _title.text = [titlePicsDict objectForKey:@"titile"];
    NSArray* pics = [titlePicsDict objectForKey:@"pics"];
    [_pic1 setImage:[UIImage imageNamed:pics[0]]];
    [_pic2 setImage:[UIImage imageNamed:pics[1]]];
    [_pic3 setImage:[UIImage imageNamed:pics[2]]];
}

@end
