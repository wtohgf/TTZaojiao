//
//  TTWoViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/4/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoViewController.h"
#import "TTTabBarController.h"
#import "TTWoLableTableViewCell.h"
#import "TTWoButtonTableViewCell.h"
#import "TTWoBackTableViewCell.h"
#import "TTUserDongtaiViewController.h"
#import "TTWoIconTableViewCell.h"
#import <CXAlertView.h>
#import "NSString+Extension.h"

#define LogoutAlertTag 19001

@interface TTWoViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) UIImageView *myIconView;
@property (strong, nonatomic) DynamicUserModel* Wo;
@end

@implementation TTWoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    actionSginBlock = ^(id result, id baby_jifen) {
        if ([result isEqualToString:@"isSigned"]) {
            [MBProgressHUD TTDelayHudWithMassage:@"您今天已经签过到了" View:self.view];
        }else if([result isEqualToString:@"neterror"])
        {
            [MBProgressHUD TTDelayHudWithMassage:@"签到未成功" View:self.view];
        }else if([result isEqualToString:@"SingedOK"]){
            //更新我的积分信息
            [MBProgressHUD TTDelayHudWithMassage:@"签到成功" View:self.view];
            _Wo.baby_jifen = baby_jifen;
            [self.tableview reloadData];
        }

    };
    
    actionBackBlock = ^() {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认要退出么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = LogoutAlertTag;
        [alert show];
    };

    if ([TTUserModelTool sharedUserModelTool].logonUser.icon.length == 0) {
        [_myIconView setImage:[UIImage imageNamed:@"baby_icon1"]];
    }else{
        [_myIconView setImageIcon:[TTUserModelTool sharedUserModelTool].logonUser.icon];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //获取我的最新信息
    [TTUserModelTool getUserInfo:[TTUserModelTool sharedUserModelTool].logonUser.ttid Result:^(DynamicUserModel *user) {
        _Wo = user;
        [TTUserModelTool sharedUserModelTool].logonUser.icon = _Wo.icon;
        [self.tableview reloadData];
    }];
}

//-(void)viewDidAppear:(BOOL)animated {
//    [self.tableview reloadData];
//}

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
        TTWoIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
        cell.textLabel.text = [[[TTUserModelTool sharedUserModelTool] logonUser] name];
        [cell.imageView setImageIcon:[[[TTUserModelTool sharedUserModelTool] logonUser] icon]];
        return cell;
    }
    else if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            TTWoLableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LableCell"];
            cell.textLabel.text = @"我的积分";
            cell.imageView.image = [UIImage imageNamed:@"icon_score.png"];
            cell.countLable.text = _Wo.baby_jifen;
            return cell;
        }
        else if (1 == indexPath.row) {
            TTWoButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
            cell.textLabel.text = @"今日签到";
            cell.imageView.image = [UIImage imageNamed:@"icon_sign.png"];
            return cell;
        }
        else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"积分换课程";
            cell.imageView.image = [UIImage imageNamed:@"icon_exchange.png"];
            return cell;
        }
    }
    else if (2 == indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
        cell.textLabel.text = @"我的VIP会员服务";
        cell.imageView.image = [UIImage imageNamed:@"user_info_icon4.png"];
        return cell;
    }
    else if (3 == indexPath.section) {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"亲子母婴操";
            cell.imageView.image = [UIImage imageNamed:@"icon_gym_small.png"];
            return cell;
        }
        else if (1 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"成长发育测评";
            cell.imageView.image = [UIImage imageNamed:@"icon_grow_test_small.png"];
            return cell;
        }
        else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"气质情绪测评";
            cell.imageView.image = [UIImage imageNamed:@"icon_temperament_test_small.png"];
            return cell;
        }
    }
    else if (4 == indexPath.section) {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"我的好友";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon1.png"];
            return cell;
        }
        else if (1 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"我的粉丝";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon2.png"];
            return cell;
        }
        else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"我的动态";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon3.png"];
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
            cell.imageView.image = [UIImage imageNamed:@"icon_weixin_small.png"];
            return cell;
//        }
    }
    else {
        if (0 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"设置个人信息";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon5.png"];
            return cell;
        }
        else if (1 == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            cell.textLabel.text = @"设置登录密码";
            cell.imageView.image = [UIImage imageNamed:@"user_info_icon6.png"];
            return cell;
        }
        else {
            TTWoBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackCell"];
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        [self performSegueWithIdentifier:@"iconSegue" sender:self];
    }
    else if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            [self performSegueWithIdentifier:@"scoreSegue" sender:self];
        }
        else if (1 == indexPath.row) {
        }
        else {
            [self performSegueWithIdentifier:@"TOSCORELESSIOM" sender:self];
        }
    }
    else if (2 == indexPath.section) {
        [self performSegueWithIdentifier:@"vipSegue" sender:self];
    }
    else if (3 == indexPath.section) {
        if (0 == indexPath.row) {
            [self performSegueWithIdentifier:@"TOMUYINGCAO" sender:self];
        }
        else if (1 == indexPath.row) {
            [self performSegueWithIdentifier:@"TOCHENGZHANG" sender:self];
        }
        else {
            [self performSegueWithIdentifier:@"TOTEMPTEST" sender:self];
        }
    }
    else if (4 == indexPath.section) {
        if (0 == indexPath.row) {
            [self performSegueWithIdentifier:@"TOMYFRIEND" sender:self];
        }
        else if (1 == indexPath.row) {
            [self performSegueWithIdentifier:@"TOMYFANS" sender:self];
        }
        else {
            UIStoryboard *storyBoardDongTai=[UIStoryboard storyboardWithName:@"DongTaiStoryboard" bundle:nil];
            TTUserDongtaiViewController *userViewController = (TTUserDongtaiViewController *)[storyBoardDongTai instantiateViewControllerWithIdentifier:@"UserUIM"];
            [userViewController setI_uid:[[[TTUserModelTool sharedUserModelTool] logonUser] ttid]];
            [self.navigationController pushViewController:userViewController animated:YES];
        }
    }
    else if (5 == indexPath.section) {
        UILabel* label = [[UILabel alloc]init];
        label.font = TTBlogSubtitleFont;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithRed:112.f/255.f green:145.f/255.f blue:70.f/255.f alpha:1.f];
        label.text = @"微信公众号: ttzaojiao2013 \n1.vip用户即时跟踪\n2.每周微信抽取获奖关注用户获得1-12个月早教课程\n3.每日发布各月龄系统性早教指导、育儿资讯；\n4.未来平台可以实现同城、同龄早教宝宝互动。";
        CGRect bound = [label.text boundByFont:TTBlogSubtitleFont andWidth:self.view.frame.size.width*0.6];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.frame = CGRectMake(0, 0, bound.size.width, bound.size.height);
    
        CXAlertView* alertView = [[CXAlertView alloc]initWithTitle:@"关注天天早教公众号" contentView:label cancelButtonTitle:@"确定"];

        alertView.viewBackgroundColor = [UIColor colorWithRed:139.f/255.f green:185.f/255.f blue:79.f/255.f alpha:1.f];
        alertView.cancelButtonColor = [UIColor whiteColor];
        
        
        [alertView show];
    }
    else {
        if (0 == indexPath.row) {
            [self performSegueWithIdentifier:@"personalSegue" sender:self];
        }
        else if (1 == indexPath.row) {
            [self performSegueWithIdentifier:@"passwordSegue" sender:self];
        }
        else {
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
            [[TTUIChangeTool sharedTTUIChangeTool]backToLogReg:self];
        }
        else {
            return;
        }
    }
    else {
        return;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[TTWoScoreLessionViewController class]]) {
        TTWoScoreLessionViewController* slvc = (TTWoScoreLessionViewController*)segue.destinationViewController;
        slvc.Wo = _Wo;
    }
}

@end
