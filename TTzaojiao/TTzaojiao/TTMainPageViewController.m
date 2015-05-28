//
//  TTMainPageViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-4-15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTMainPageViewController.h"
#import "CustomDatePicker.h"
#import "TTTabBarController.h"

@interface TTMainPageViewController ()
@property (strong, nonatomic) CustomDatePicker* datePicker;
@property (weak, nonatomic) IBOutlet UIButton *logregButton;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *mouth;
@property (weak, nonatomic) IBOutlet UILabel *day;

//@property (strong, nonatomic) UIViewController *mainViewController;

- (IBAction)startTryTeach:(UIButton *)sender;
- (IBAction)dateChoice:(UIButton *)sender;

@end

@implementation TTMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomDatePicker* cdate = [CustomDatePicker sharedDatePicker:@"给宝宝选择生日" delegate:self];
    
    //[[CustomDatePicker alloc]initWithTitle:@"给宝宝选择生日" delegate:self];
    _datePicker = cdate;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


#pragma mark 开始体验
- (IBAction)startTryTeach:(UIButton *)sender {
    if (_year.text.length == 0 ) {
        [MBProgressHUD TTDelayHudWithMassage:@"选择宝宝生日即可体验" View:self.view];
        return;
    }
    NSString* birthDay = [NSString stringWithFormat:@"%@-%@-%@",_year.text, _mouth.text, _day.text];
    NSDictionary* dict = @{
                           @"id": @"1977",
                           @"name": @"未登录",
                           @"icon": @"/App/Code/TempFace/1.jpg",
                           @"gender": @"1",
                           @"vip": @"0",
                           @"vip_time": @"2010-01-01 01:01:01",
                           @"type": @"0",
                           @"birthday":birthDay,
                           };
    
    UserModel* tryUser = [UserModel userModelWithDict:dict];
    [TTUserModelTool sharedUserModelTool].logonUser = tryUser;
    [TTUserModelTool sharedUserModelTool].password = @"3e9fe397381d3e595979a716ebf32c21";
    [self Trylongon:tryUser];
}

-(void)Trylongon:(UserModel*) user{
    
    //装载tabbar
    TTTabBarController *tabBarController = [[TTTabBarController alloc] init];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithName:@"top_bg.png"] forBarMetrics:UIBarMetricsDefault];
 
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
    
}

#pragma mark 生日选择
- (IBAction)dateChoice:(UIButton *)sender {
    _logregButton.hidden = YES;
//    cdate.frame = CGRectMake(0, self.view.frame.size.height*2/3, self.view.frame.size.width, self.view.frame.size.height*1/3);
   
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    _datePicker.datePicker.minimumDate = [formater dateFromString:@"1970-01-01"];
    _datePicker.datePicker.maximumDate = [NSDate date];

    [_datePicker showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if([actionSheet isKindOfClass:[CustomDatePicker class]]){
        _logregButton.hidden = NO;
        if(buttonIndex == 0) {
            return;
        }else {
            NSDate* date = _datePicker.datePicker.date;
            NSDateFormatter* formater = [[NSDateFormatter alloc]init];
            [formater setDateFormat:@"yyyy-MM-dd"];
            NSString* dateString = [formater stringFromDate:date];
            NSArray* dateArray = [dateString componentsSeparatedByString:@"-"];
            if (dateArray.count == 3) {
                _year.text = dateArray[0];
                _mouth.text = dateArray[1];
                _day.text = dateArray[2];
            }
           
        }
    }
}

-(void)dealloc{
    [_datePicker removeFromSuperview];
    _datePicker = nil;
}
@end
