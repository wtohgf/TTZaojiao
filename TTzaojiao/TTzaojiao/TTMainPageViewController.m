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
@property (weak, nonatomic) IBOutlet UIButton *logregButton;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *mouth;
@property (weak, nonatomic) IBOutlet UILabel *day;


@property (strong, nonatomic) UIViewController *mainViewController;

- (IBAction)startTryTeach:(UIButton *)sender;
- (IBAction)dateChoice:(UIButton *)sender;

@end

@implementation TTMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


#pragma mark 开始体验
- (IBAction)startTryTeach:(UIButton *)sender {
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
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_bg"] forBarMetrics:UIBarMetricsDefault];
//
//    [UINavigationBar appearance].hidden = NO;
//    
    self.mainViewController = tabBarController;
    
    [self.navigationController pushViewController:_mainViewController animated:YES];
    
}

#pragma mark 生日选择
- (IBAction)dateChoice:(UIButton *)sender {
    CustomDatePicker* cdate = [[CustomDatePicker alloc]init];
    cdate.frame = CGRectMake(0, self.view.frame.size.height*2/3, self.view.frame.size.width, self.view.frame.size.height*1/3);
    cdate = [cdate initWithTitle:@"给宝宝选择生日" delegate:self];
   
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    cdate.datePicker.minimumDate = [formater dateFromString:@"1970-01-01"];
    cdate.datePicker.maximumDate = [NSDate date];
    
    [cdate showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if([actionSheet isKindOfClass:[CustomDatePicker class]]){
        CustomDatePicker *datePickerView = (CustomDatePicker *)actionSheet;
        
        if(buttonIndex == 0) {
            return;
        }else {
            NSDate* date = datePickerView.datePicker.date;
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

#pragma mark 设置背景图片
- (void) setBackGroundImages{
    NSString* babyPicName;
    int line = 0, row = 0;
    const int linecount = 4;
    CGFloat babyPicWidth = self.view.frame.size.width/linecount;
    CGFloat babyPicHegiht = babyPicWidth;
    int realnum = 0;
    
    for(int i=0; i<100; i++) {
        line = i/linecount;
        row = i%linecount;
        realnum = i%25;
        babyPicName = [NSString stringWithFormat:@"baby_icon%d",realnum+1];
        UIImageView* baby = [[UIImageView alloc]init];
        [baby setImage:[UIImage imageNamed:babyPicName]];
        CGFloat x = row*babyPicWidth;
        CGFloat y = line*babyPicHegiht;
        
        if (y >= self.view.frame.size.height) {
            break;
        }
        baby.frame = CGRectMake(x, y, babyPicWidth, babyPicHegiht);
        
        [self.view insertSubview:baby belowSubview:_logregButton];
    }
}

@end
