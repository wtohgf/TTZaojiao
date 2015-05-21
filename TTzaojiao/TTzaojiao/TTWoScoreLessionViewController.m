//
//  TTWoScoreLessionViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoScoreLessionViewController.h"
#import "TTUserDongtaiViewController.h"
#import "TTUserModelTool.h"
#import <CXAlertView.h>

@interface TTWoScoreLessionViewController ()
@property (weak, nonatomic) UIButton* oldselButton;
@property (weak, nonatomic) IBOutlet UIButton *scorePayButton;
@property (copy, nonatomic) NSString* playLessionType;
@end

@implementation TTWoScoreLessionViewController


- (IBAction)scorePayLession:(UIButton *)sender {
    [_lessionAccount resignFirstResponder];
    [_scoreCount resignFirstResponder];
    
    NSDictionary* scoreLessionDict = @{
                                       @"1":@"300",
                                       @"2":@"800",
                                       @"3":@"1200",
                                       @"4":@"2000",
                                       @"5":@"3500"
                                       };
    NSDictionary* lessionMounthDict = @{
                                       @"1":@"1",
                                       @"2":@"3",
                                       @"3":@"6",
                                       @"4":@"12",
                                       @"5":@"24"
                                       };
    if ([_Wo.baby_jifen integerValue] < [[scoreLessionDict objectForKey:_playLessionType] integerValue]) {
        [MBProgressHUD TTDelayHudWithMassage:@"对不起 您的积分不足" View:self.navigationController.view];
        return;
    }
    
    if (_lessionAccount.text.length == 0) {
        [MBProgressHUD TTDelayHudWithMassage:@"上课账号不能为空" View:self.navigationController.view];
        return;
    }
    
    [TTUserModelTool ScorePayLessionWithMouth:[lessionMounthDict objectForKey:_playLessionType] UserAccount:_lessionAccount.text Result:^(id isSucsses) {
        if ([isSucsses isEqualToString:@"YES"]) {
            [MBProgressHUD TTDelayHudWithMassage:@"恭喜您！课程兑换成功" View:self.navigationController.view];
            _scoreCount.text = [NSString stringWithFormat:@"%ld", [_scoreCount.text integerValue] - [[scoreLessionDict objectForKey:_playLessionType] integerValue]];
        }else{
            [MBProgressHUD TTDelayHudWithMassage:@"对不起！兑换未成功 请稍后重试" View:self.navigationController.view];
        }
    }];
}

- (IBAction)scorePayLessionTypeSelect:(UITapGestureRecognizer *)sender {
    
    NSUInteger count = 5;
    UIView* mainView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth*0.5, 5*30.f)];
    
    NSArray* mouth = @[@"1", @"3", @"6", @"12", @"24"];
    NSArray* socre = @[@"300", @"800", @"1200", @"2000", @"3500"];
    for (int i = 0; i<count; i++) {
        UIButton* btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(0.f, i*30.f, ScreenWidth*0.5, 30.f);
        [mainView addSubview:btn];
        btn.tag = i;
        NSString* title = [NSString stringWithFormat:@"开通%@个月早教服务[需%@积分]", mouth[i], socre[i]];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(scorePayLessionChoice:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    }

    CXAlertView* alertView = [[CXAlertView alloc]initWithTitle:@"兑换列表:" contentView:mainView cancelButtonTitle:@"确定"];
    alertView.userInteractionEnabled = YES;
    [alertView show];
    
//    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"兑换列表:" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    
//    ac.view.backgroundColor = [UIColor whiteColor];
//    
//    UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"开用1个月早教服务[需300积分]" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        _playLessionType = @"1";
//        _scoreLessionType.text = action.title;
//    }];
//
//    [ac addAction:action1];
//    UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"开用3个月早教服务[需800积分]" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        ;
//        _playLessionType = @"2";
//        _scoreLessionType.text = action.title;
//    }];
//    [ac addAction:action2];
//    UIAlertAction* action3 = [UIAlertAction actionWithTitle:@"开用6个月早教服务[需1200积分]" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        ;
//        _playLessionType = @"3";
//        _scoreLessionType.text = action.title;
//    }];
//    [ac addAction:action3];
//    UIAlertAction* action4 = [UIAlertAction actionWithTitle:@"开用12个月早教服务[需2000积分]" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        ;
//        _playLessionType = @"4";
//        _scoreLessionType.text = action.title;
//    }];
//    [ac addAction:action4];
//    UIAlertAction* action5 = [UIAlertAction actionWithTitle:@"开用24个月早教服务[需3500积分]" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        ;
//        _playLessionType = @"5";
//        _scoreLessionType.text = action.title;
//    }];
//    [ac addAction:action5];
//    
//    [self presentViewController:ac animated:YES completion:nil];

}

-(void)scorePayLessionChoice:(UIButton*)sender{
    _oldselButton.selected = NO;
    sender.selected = !sender.selected;
    _oldselButton = sender;
    _playLessionType = [NSString stringWithFormat:@"%ld", sender.tag];
    _scoreLessionType.text = sender.titleLabel.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scorePayButton.layer.borderWidth = 1;
    _scorePayButton.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:0.710 green:0.251 blue:0.357 alpha:1.000]);
    _scorePayButton.layer.cornerRadius = 20.f;
    
    _scoreCount.text = _Wo.baby_jifen;
    
    //默认开通一个月 300积分
    _playLessionType = @"1";
    
}
- (IBAction)endEdit:(UITextField *)sender {
    [sender resignFirstResponder];
}

@end
