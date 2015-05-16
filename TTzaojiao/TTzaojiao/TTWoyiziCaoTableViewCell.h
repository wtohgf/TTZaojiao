//
//  TTWoyiziCaoTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTWoyiziCaoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pic1;
@property (weak, nonatomic) IBOutlet UIImageView *pic2;
@property (weak, nonatomic) IBOutlet UIImageView *pic3;
@property (weak, nonatomic) IBOutlet UILabel *title;

+(instancetype)woyiziCaoTableViewCellWithTableView:(UITableView*)tableView;


@property (strong, nonatomic) NSDictionary* titlePicsDict;
@end
