//
//  TTNearBybabyTableViewCell.h
//  TTzaojiao
//
//  Created by hegf on 15-5-8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTNearBybabyInfoView.h"
//
//@protocol TTNearBybabyTableViewCellDelegate<NSObject>
//-(void)didIconTaped:(NSString*)uid;
//@end

@interface TTNearBybabyTableViewCell : UITableViewCell
@property (weak, nonatomic) TTNearBybabyInfoView* babyInfoView;
+(instancetype)nearBybabyCellWithTableView:(UITableView *)tableView;

//@property (weak, nonatomic) id<TTNearBybabyTableViewCellDelegate> delegate;
@property (strong, nonatomic) NearByBabyModel* nearByBaby;
@end
