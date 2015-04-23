//
//  TTWoViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoViewController.h"
#import "TTWoLableTableViewCell.h"
#import "TTWoButtonTableViewCell.h"
#import "TTWoBackTableViewCell.h"

#define LogoutAlertTag 19001

@interface TTWoViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIButton *rightButtonItem;

@end

@implementation TTWoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    actionSginBlock = ^() {
#ifdef DEBUG
        NSLog(@"Sign");
#endif
    };
    actionBackBlock = ^() {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认要退出么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = LogoutAlertTag;
        [alert show];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rightButtonItem:(id)sender {
#ifdef DEBUG
    NSLog(@"right button item action");
#endif
}

- (IBAction)rightButtonItemAction:(UIButton *)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;

        case 2:
            return 1;
            break;

        case 3:
            return 3;
            break;

        case 4:
            return 3;
            break;

        case 5:
            return 1;
            break;
            
        default:
            return 3;
            break;
    }
}

#pragma UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 65.f;
    }
    else if (6 == indexPath.section) {
        return 60.f;
    }
    else {
        return 44.f;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
        return cell;
    }
    else if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            TTWoLableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LableCell"];
            cell.textLabel.text = @"我的积分";
            cell.imageView.image = [UIImage imageNamed:@"icon_score"];
            return cell;
        }
        else if (1 == indexPath.row) {
            TTWoButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
            cell.textLabel.text = @"今日签到";
            cell.imageView.image = [UIImage imageNamed:@"icon_sign"];
            return cell;
        }
        else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"积分换课程";
            cell.imageView.image = [UIImage imageNamed:@"icon_exchange"];
            return cell;
        }
    }
    else if (2 == indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
        cell.textLabel.text = @"我的VIP会员服务";
        cell.imageView.image = [UIImage imageNamed:@"user_info_icon4"];
        return cell;
    }
    else if (3 == indexPath.section) {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"亲子母婴操";
            cell.imageView.image = [UIImage imageNamed:@"icon_gym_small"];
            return cell;
        }
        else if (1 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"成长发育测评";
            cell.imageView.image = [UIImage imageNamed:@"icon_grow_test_small"];
            return cell;
        }
        else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"气质情绪测评";
            cell.imageView.image = [UIImage imageNamed:@"icon_temperament_test_small"];
            return cell;
        }
    }
    else if (4 == indexPath.section) {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"我的好友";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon1"];
            return cell;
        }
        else if (1 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"我的粉丝";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon2"];
            return cell;
        }
        else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"我的动态";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon3"];
            return cell;
        }
    }
    else if (5 == indexPath.section) {
//        if (0 == indexPath.row) {
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
//            cell.imageView.image = [UIImage imageNamed:@"icon_check_version"];
//            return cell;
//        }
//        else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"微信公众平台";
            cell.imageView.image = [UIImage imageNamed:@"icon_weixin"];
            return cell;
//        }
    }
    else {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"设置个人信息";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon5"];
            return cell;
        }
        else if (1 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"设置登录密码";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon6"];
            return cell;
        }
        else {
            TTWoBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackCell"];
            return cell;
        }
    }
}

#pragma UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (LogoutAlertTag == alertView.tag) {
        if (0 == buttonIndex) {
            return;
        }
        else if (1 == buttonIndex) {
#ifdef DEBUG
            NSLog(@"Logout!!!");
#endif
        }
        else {
            return;
        }
    }
    else {
        return;
    }
}

@end
