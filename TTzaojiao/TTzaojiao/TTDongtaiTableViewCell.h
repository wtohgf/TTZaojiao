//
//  TTDongtaiTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-4-23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTDongtaiCommentTableViewCell.h"
#import "BlogModel.h"
#import <UIImageView+AFNetworking.h>
#import "TTWebServerAPI.h"

typedef enum {
    DongtaiCellTypeNoPic = 0,
    DongtaiCellTypePic1To3,
    DongtaiCellTypePic4To6,
    DongtaiCellTypePic7To9
}DongtaiType;

@interface TTDongtaiTableViewCell : UITableViewCell

@property (strong, nonatomic) BlogModel* blogModel;

@property (weak, nonatomic) IBOutlet UILabel *blogTime;
@property (weak, nonatomic) IBOutlet UILabel *babyName;
@property (weak, nonatomic) IBOutlet UIImageView *babyIcon;
@property (weak, nonatomic) IBOutlet UILabel *dongtai;

//@property (strong, nonatomic) NSArray* picsNameArray; //保存多张图片名字
//@property (strong, nonatomic) NSMutableArray* picsArray; //九宫格imageView数组

+(instancetype)dongtaiTableViewCellWithTableView:(UITableView*)tableView;

@end
