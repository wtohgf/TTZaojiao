//
//  TTWoTempTestReportViewController.m
//  TTzaojiao
//
//  Created by hegf on 15-5-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoTempTestReportViewController.h"
#import "TTGrowTemperTestTool.h"
#import "NSString+Extension.h"
#import "TTWoTemperatureTestCell.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.width
#define kpicAll (80+8*50+30+16.0)
#define kLeftRatio 80/kpicAll
#define kCenterRatio 50/kpicAll
#define kPaddingRatio 8/kpicAll
#define kRightRatio 30/kpicAll
@interface TTWoTempTestReportViewController (){
    NSDictionary* _reportDict;
}

@property (weak, nonatomic) UILabel* mounth;
@property (weak, nonatomic) UILabel* date;
@property (weak, nonatomic) UILabel* result;
@property ( nonatomic) CGFloat picHeight;
@property ( nonatomic)  CGFloat centerWidth ;
@property ( nonatomic)  CGFloat centerHeight ;
@property ( nonatomic)  CGFloat centerX ;
@property ( nonatomic)  CGFloat centerY ;

@property ( nonatomic) CGRect value_info_1F;
@property ( nonatomic) CGRect value_info_2F;
@property (nonatomic,copy) NSString *value_info_1;
@property (nonatomic,copy) NSString *value_info_2;

@property (weak, nonatomic) IBOutlet UITableView *tempReportTableView;

@property (nonatomic,strong) NSArray *modelArray;
@end

@implementation TTWoTempTestReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [TTGrowTemperTestTool getTempReportWithResultID: _resultID Result:^(id testlist) {
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        if ([testlist isKindOfClass:[NSDictionary class]]) {
            _reportDict = testlist;
            
            _value_info_1 = testlist[@"i_value_info_1"];
            _value_info_2 = testlist[@"i_value_info_2"];
            _value_info_1F= [testlist[@"i_value_info_1"] boundByFont:[UIFont systemFontOfSize:12.f] andWidth:[UIScreen mainScreen].bounds.size.width - 16.f];
            _value_info_2F= [testlist[@"i_value_info_2"] boundByFont:[UIFont systemFontOfSize:12.f] andWidth:[UIScreen mainScreen].bounds.size.width - 16.f];
            
            NSMutableArray *modelArray = [[NSMutableArray alloc]init];;
            for (int i = 0; i < 9; i++) {
                NSMutableArray *dictArray = [[NSMutableArray alloc]init];;
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                 NSString * name = [NSString stringWithFormat:@"i_part_%d_name",i+1];
                
                NSString * content = [NSString stringWithFormat:@"i_part_%d_content",i+1];
                 NSString * jianyi = [NSString stringWithFormat:@"i_part_%d_jianyi",i+1];
                 NSString * pingjia= [NSString stringWithFormat:@"i_part_%d_pingjia",i+1];
                NSString * fen= [NSString stringWithFormat:@"i_fen_%d",i+1];
                 NSString *qizhi= [NSString stringWithFormat:@"qizhi_%d",i+1] ;
                
                CGRect contentF= [testlist[content] boundByFont:[UIFont systemFontOfSize:12.f] andWidth:[UIScreen mainScreen].bounds.size.width - 16.f];
                CGRect pingjiaF= [testlist[pingjia] boundByFont:[UIFont systemFontOfSize:12.f] andWidth:[UIScreen mainScreen].bounds.size.width - 16.f];
                CGRect jianyiF= [testlist[jianyi] boundByFont:[UIFont systemFontOfSize:12.f] andWidth:[UIScreen mainScreen].bounds.size.width - 16.f];
                
                
                
                [dict setObject:testlist[name] forKey:name];
                [dict setObject:testlist[content] forKey:content];
                [dict setObject:testlist[jianyi] forKey:jianyi];
                [dict setObject:testlist[pingjia] forKey:pingjia];
                [dict setObject:testlist[fen] forKey:fen];
                [dict setObject:testlist[qizhi] forKey:qizhi];
              
                //dictArray数组有四个元素 计算完毕变化的文字的长度
                [dictArray addObject:dict];
                [dictArray addObject:NSStringFromCGRect(contentF)];
                [dictArray addObject:NSStringFromCGRect(pingjiaF)];
                [dictArray addObject:NSStringFromCGRect(jianyiF)];
                
                [modelArray addObject:dictArray];
            }
            
            _modelArray = modelArray;
            
            //[self drawPic];
            //caculata height of section 1
            UIImageView * leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_left.gif"]];
            CGFloat picW = CGImageGetWidth(leftView.image.CGImage);
            CGFloat picH = CGImageGetHeight(leftView.image.CGImage);
            
            CGFloat leftWidth = screenWidth*kLeftRatio;
            CGFloat leftHeight = (CGFloat)((leftWidth * picH)/picW) ;
            
            
            UIImageView * bottomView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_bottom.gif"]];
            CGFloat bottomW = CGImageGetWidth(bottomView.image.CGImage);
            CGFloat bottomH = CGImageGetHeight(bottomView.image.CGImage);
            
            CGFloat bottomWidth = screenWidth*(kRightRatio+8*kCenterRatio+kLeftRatio);
            CGFloat bottomHeight = (CGFloat)((bottomWidth * bottomH)/bottomW) ;
            
            _picHeight = leftHeight + bottomHeight;
            
            [_tempReportTableView reloadData];
        }else{
            if ([testlist isKindOfClass:[NSString class]]) {
                if ([testlist isEqualToString:@"neterror"]) {
                    [MBProgressHUD TTDelayHudWithMassage:@"网络连接错误 请检查网络" View:self.navigationController.view];
                }else{
                    [MBProgressHUD TTDelayHudWithMassage:@"测试历史获取失败" View:self.navigationController.view];
                }
            }
        }
    }];
}
//
//@property (weak, nonatomic)  UILabel *nameTitleLabel;
//@property (weak, nonatomic)  UILabel *nameLabel;
//
//@property (weak, nonatomic)  UILabel *pingjiaTitleLabel;
//@property (weak, nonatomic)  UILabel *pingjiaLabel;
//
//@property (weak, nonatomic)  UILabel *jianyiTitleLabel;
//@property (weak, nonatomic)  UILabel *jianyiLabel;

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        return NO;
//    }
//    else return YES;
//    
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_modelArray == nil){
        return [[UITableViewCell alloc]init];
    }
    
    if ((indexPath.section == 0)) {
      UITableViewCell *cell =   [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140.f)];
        
        UIView *headerView = [[UIView alloc]init];
        [cell.contentView addSubview:headerView];//////jiany
        headerView.backgroundColor = [UIColor colorWithRed:239.f/255.f green:239.f/255.f blue:244.f/255.f alpha:1.f];
        
        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 140.f);
        
        UIView* subHeaderView = [[UIView alloc]init];
        [headerView addSubview:subHeaderView];
        subHeaderView.frame = CGRectMake(0, 20.f, self.view.frame.size.width, 100.f);
        subHeaderView.backgroundColor = [UIColor whiteColor];
        
        UILabel* mountTitle = [[UILabel alloc]init];
        [subHeaderView addSubview:mountTitle];
        mountTitle.text = @"宝宝月龄:";
        mountTitle.font = [UIFont systemFontOfSize:16.f];
        mountTitle.textAlignment = NSTextAlignmentRight;
        mountTitle.frame = CGRectMake(0, 5, self.view.frame.size.width*0.5, 30.f);
        
        UILabel* dateTitle = [[UILabel alloc]init];
        [subHeaderView addSubview:dateTitle];
        dateTitle.text = @"测评日期:";
        dateTitle.font = [UIFont systemFontOfSize:16.f];
        dateTitle.textAlignment = NSTextAlignmentRight;
        dateTitle.frame = CGRectMake(0, mountTitle.bottom, self.view.frame.size.width*0.5, 30.f);
        
        UILabel* resultTitle = [[UILabel alloc]init];
        [subHeaderView addSubview:resultTitle];
        resultTitle.text = @"测评结果:";
        resultTitle.font = [UIFont systemFontOfSize:16.f];
        resultTitle.textAlignment = NSTextAlignmentRight;
        resultTitle.frame = CGRectMake(0, dateTitle.bottom, self.view.frame.size.width*0.5, 30.f);
        
        UILabel* mounth = [[UILabel alloc]init];
        _mounth = mounth;
        [subHeaderView addSubview:mounth];
        mounth.font = [UIFont systemFontOfSize:16.f];
        mounth.textAlignment = NSTextAlignmentLeft;
        mounth.frame = CGRectMake(self.view.frame.size.width*0.5 +10.f, mountTitle.up, self.view.frame.size.width*0.5-10.f, 30.f);
        
        UILabel* date = [[UILabel alloc]init];
        _date = date;
        [subHeaderView addSubview:date];
        date.font = [UIFont systemFontOfSize:16.f];
        date.textAlignment = NSTextAlignmentLeft;
        date.frame = CGRectMake(self.view.frame.size.width*0.5+10.f, dateTitle.up, self.view.frame.size.width*0.5-10.f, 30.f);
        
        UILabel* result = [[UILabel alloc]init];
        _result = result;
        [subHeaderView addSubview:result];
        result.font = [UIFont systemFontOfSize:16.f];
        result.textAlignment = NSTextAlignmentLeft;
        result.frame = CGRectMake(self.view.frame.size.width*0.5+10.f, resultTitle.up, self.view.frame.size.width*0.5-10.f, 30.f);
        [self updateHeader];
        return cell;
    }
    //气质情绪综合分析
    else if(indexPath.section == 1)
    {
         UITableViewCell *cell =   [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, screenWidth, _picHeight+30+8.0f+8.0f+_value_info_1F.size.height+_value_info_2F.size.height)];
        //NSLog(@"%@",NSStringFromCGRect(cell.frame));
        ////////////////////////////标题/////////////////////////////////////
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
        [cell.contentView addSubview:titleLabel];
        titleLabel.text = @"气质情绪综合分析";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        ///////////////////////图////////////////////////////////////////
        UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), screenWidth, _picHeight)];
        [cell.contentView addSubview:imageView1];
        
        UIImageView * leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_left.gif"]];
        CGFloat picW = CGImageGetWidth(leftView.image.CGImage);
        CGFloat picH = CGImageGetHeight(leftView.image.CGImage);
        
        CGFloat leftWidth = screenWidth*kLeftRatio;
        CGFloat leftHeight = (CGFloat)((leftWidth * picH)/picW) ;
        CGFloat leftX = screenWidth*kPaddingRatio;
        CGFloat leftY = 0;
        leftView.frame = CGRectMake(leftX, leftY, leftWidth, leftHeight);
        [imageView1 addSubview:leftView];
        
        
        UIImageView * centerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_center.jpg"]];
        CGFloat centerW = CGImageGetWidth(centerView.image.CGImage);
        CGFloat centerH = CGImageGetHeight(centerView.image.CGImage);
        
        CGFloat centerWidth = screenWidth*kCenterRatio;
        CGFloat centerHeight = (CGFloat)((centerWidth * centerH)/centerW) ;
        CGFloat centerX = CGRectGetMaxX(leftView.frame);
        CGFloat centerY = 0;
        _centerHeight = centerHeight;
        _centerWidth =      centerWidth;
        _centerX= centerX;
        _centerY = centerY;
        for (int i = 0; i < 8; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(centerX+i*(centerWidth), centerY, centerWidth, centerHeight)];
            [img setImage:[UIImage imageNamed:@"temp_report_center.jpg"]];
            [imageView1 addSubview:img];
            
        }
        
        
        
        UIImageView * rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_right.gif"]];
        CGFloat rightW = CGImageGetWidth(rightView.image.CGImage);
        CGFloat rightH = CGImageGetHeight(rightView.image.CGImage);
        
        CGFloat rightWidth = screenWidth*kRightRatio;
        CGFloat rightHeight = (CGFloat)((rightWidth * rightH)/rightW) ;
        CGFloat rightX = screenWidth*(kPaddingRatio+8*kCenterRatio+kLeftRatio);
        CGFloat rightY = 0;
        rightView.frame = CGRectMake(rightX, rightY, rightWidth, rightHeight);
        [imageView1 addSubview:rightView];
        
        UIImageView * bottomView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_bottom.gif"]];
        CGFloat bottomW = CGImageGetWidth(bottomView.image.CGImage);
        CGFloat bottomH = CGImageGetHeight(bottomView.image.CGImage);
        
        CGFloat bottomWidth = screenWidth*(kRightRatio+8*kCenterRatio+kLeftRatio);
        CGFloat bottomHeight = (CGFloat)((bottomWidth * bottomH)/bottomW) ;
        CGFloat bottomX = screenWidth*(kPaddingRatio);
        CGFloat bottomY = CGRectGetMaxY(leftView.frame);
        bottomView.frame = CGRectMake(bottomX, bottomY, bottomWidth, bottomHeight);
        [imageView1 addSubview:bottomView];
        ///////////////////////////////画点///////////////////////////////////////
        for (int i = 0; i < 8; i++) {
            NSString * str = [NSString stringWithFormat:@"qizhi_%d",i+1];
             NSString * str2 = [NSString stringWithFormat:@"qizhi_%d",i+2];
            ;
            CGPoint P1 = CGPointMake(centerX+centerWidth*i, centerHeight/18.0*(19-2*[_reportDict[str] intValue]));
            CGPoint P2 = CGPointMake(centerX+centerWidth*(i+1), (centerHeight/18.0)*(19-2*[_reportDict[str2] intValue]) );
            
        
        
        
        ///////////////////////////////////////////////////////////////////////////
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:imageView1.frame];
        [cell.contentView addSubview:imageView];
        
        
        
        UIGraphicsBeginImageContext(imageView.frame.size);
//        NSLog(@"%@",NSStringFromCGRect(imageView.frame));
//        NSLog(@"%@",NSStringFromCGRect(imageView1.frame));
        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);  //线宽
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);  //颜色
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), P1.x, P1.y);  //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), P2.x, P2.y);   //终点坐标
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        imageView.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        }
        /////////////////////////////评价///////////////////////////////
        UILabel * info1Label = [[UILabel alloc]initWithFrame:CGRectMake(8.0f, CGRectGetMaxY(imageView1.frame)+8.0f, screenWidth-16.0f, _value_info_1F.size.height)];
        [cell.contentView addSubview:info1Label];
        info1Label.text =_value_info_1;
        info1Label.numberOfLines = 0;
        info1Label.font = [UIFont systemFontOfSize:12.f];
        info1Label.textColor = [UIColor redColor];
        
        UILabel * info2Label = [[UILabel alloc]initWithFrame:CGRectMake(8.0f, CGRectGetMaxY(info1Label.frame)+8.0f, screenWidth-16.0f, _value_info_2F.size.height)];
        [cell.contentView addSubview:info2Label];
        info2Label.text =_value_info_2;
        info2Label.numberOfLines = 0;
        info2Label.font = [UIFont systemFontOfSize:12.f];
       
        return cell;
    }
    
    NSArray* resultArray = [NSArray arrayWithObjects:@"测评结果：低",@"测评结果：中",@"测评结果：高" ,nil];
    TTWoTemperatureTestCell * cell = [TTWoTemperatureTestCell WoTemperatureTestCellWithTabelView:tableView];
    NSArray * modelArray = _modelArray[indexPath.section-2];
    cell.modelArray = modelArray;
    cell.titleLabel.text = [(NSDictionary*)modelArray[0]  valueForKey:[NSString stringWithFormat:@"i_part_%ld_name",indexPath.section-1]];
     cell.resultLabel.text = resultArray[[[(NSDictionary*)modelArray[0]  valueForKey:[NSString stringWithFormat:@"i_fen_%ld",indexPath.section-1]] intValue] -1];
    
    cell.nameTitleLabel.text = [NSString stringWithFormat:@"什么是%@?",[(NSDictionary*)modelArray[0]  valueForKey:[NSString stringWithFormat:@"i_part_%ld_name",indexPath.section-1]]];
    
    cell.nameLabel.text =[(NSDictionary*)modelArray[0]  valueForKey:[NSString stringWithFormat:@"i_part_%ld_content",indexPath.section-1]]; ;
    
    
    cell.pingjiaTitleLabel.text = [NSString stringWithFormat:@"%@评价",[(NSDictionary*)modelArray[0]  valueForKey:[NSString stringWithFormat:@"i_part_%ld_name",indexPath.section-1]]];
    cell.pingjiaLabel.text = [(NSDictionary*)modelArray[0]  valueForKey:[NSString stringWithFormat:@"i_part_%ld_pingjia",indexPath.section-1]];

    cell.jianyiTitleLabel.text = @"教养建议";
    cell.jianyiLabel.text = [(NSDictionary*)modelArray[0]  valueForKey:[NSString stringWithFormat:@"i_part_%ld_jianyi",indexPath.section-1]];
        return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 11;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#define ktitleHeight 30.0f
#define ksubtitleHeight 15.0f
#define kpadding 8.0f
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_modelArray == nil) return 10.f;
    if (indexPath.section == 0) {
        return 140.0f;
    }
    if (indexPath.section == 1) {
        return _picHeight+30.0+8.0f+8.0f+_value_info_2F.size.height+_value_info_1F.size.height;
    }
   NSArray *dictArray =  _modelArray[indexPath.section-2];
    //dictArray[0];
    CGRect nameF =    CGRectFromString((NSString*)dictArray[1]);
    CGRect pingjiaF =    CGRectFromString((NSString*)dictArray[2]);
    CGRect jianyiF =    CGRectFromString((NSString*)dictArray[3]);
    
    return ktitleHeight + 3*ksubtitleHeight + nameF.size.height + pingjiaF.size.height +jianyiF.size.height+ 6*kpadding +1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01f;
    }

    return 10.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_modelArray == nil) return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10.0f)];
    headerView.backgroundColor =  [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    return headerView;
    
}


/*
 {
 "i_fen_1" = 2;
 "i_fen_2" = 2;
 "i_fen_3" = 2;
 "i_fen_4" = 2;
 "i_fen_5" = 2;
 "i_fen_6" = 2;
 "i_fen_7" = 2;
 "i_fen_8" = 2;
 "i_fen_9" = 2;
 "i_part_1_content" = "\U6307\U996e\U98df\U3001\U5927\U4fbf\U3001\U7761\U7720\U7b49\U751f\U7269\U529f\U80fd\U7684\U89c4\U5f8b\U6027\U3002
 \n";
 "i_part_1_jianyi" = "\U5728\U5a74\U513f\U65f6\U671f\Uff0c\U987a\U5e94\U5b69\U5b50\U7684\U7279\U70b9\Uff0c\U5982\U679c\U56e0\U4e3a\U51fa\U5916\U5bfc\U81f4\U751f\U6d3b\U65e0\U89c4\U5f8b\Uff0c\U5219\U5bb6\U957f\U8981\U505a\U597d\U51c6\U5907\Uff0c\U4f8b\U5982\U51c6\U5907\U597d\U725b\U5976\U3001\U5c3f\U5e03\U3001\U8863\U670d\U7b49\Uff0c\U5728\U5927\U5b69\U5b50\Uff0c\U5f53\U53ef\U80fd\U51fa\U73b0\U7279\U70b9\U7684\U751f\U6d3b\U5b89\U6392\U65f6\Uff0c\U8981\U9884\U5148\U6253\U62db\U547c\U6216\U505a\U76f8\U5e94\U51c6\U5907\U3002";
 "i_part_1_name" = "\U89c4\U5f8b\U6027";
 "i_part_1_pingjia" = "\U5b9d\U5b9d\U662f\U4e2a\U89c4\U5f8b\U6027\U9002\U4e2d\U7684\U5b69\U5b50\Uff0c\U80fd\U591f\U5f62\U6210\U89c4\U5f8b\Uff0c\U53c8\U4e0d\U523b\U677f\U3002";
 "i_part_2_content" = "\U6307\U5b69\U5b50\U5e73\U65f6\U4e3b\U8981\U5f97\U60c5\U7eea\U8868\U73b0\Uff0c\U662f\U79ef\U6781\Uff08\U6109\U5feb\U53cb\U597d\Uff09\U8fd8\U662f\U6d88\U6781\Uff08\U4e0d\U6109\U5feb\Uff0c\U4e0d\U53cb\U597d\Uff09\U3002
 \n";
 "i_part_2_jianyi" = "\U9f13\U52b1\U5b69\U5b50\U79ef\U6781\U548c\U53cb\U5584\U7684\U60c5\U7eea\U53cd\U5e94\Uff0c\U4f46\U8981\U6ce8\U610f\U6709\U65f6\U5728\U5b69\U5b50\U6109\U5feb\U60c5\U7eea\U7684\U5916\U8868\U4e0b\U53ef\U80fd\U5b58\U5728\U7684\U538b\U6291\U5fc3\U5883\Uff0c\U4f8b\U5982\U8eab\U4f53\U75bc\U75db\Uff0c\U5bf9\U5b69\U5b50\U4e0e\U964c\U751f\U4eba\U7684\U53cb\U597d\U8981\U53cd\U590d\U63d0\U9192\U3002";
 "i_part_2_name" = "\U60c5\U7eea\U672c\U8d28";
 "i_part_2_pingjia" = "\U5b9d\U5b9d\U662f\U4e2a\U60c5\U7eea\U9002\U4e2d\U7684\U5b69\U5b50\Uff0c\U80fd\U6b63\U786e\U53cd\U6620\U81ea\U5df1\U7684\U60c5\U7eea\Uff0c\U65e0\U8bba\U60c5\U7eea\U597d\U574f\Uff0c\U90fd\U6bd4\U8f83\U5bb9\U6613\U89c2\U5bdf\U7684\U5b69\U5b50\Uff0c\U4e00\U822c\U7684\U5fc3\U5883\U662f\U5f88\U6b63\U5e38\U7684\U73b0\U8c61\U3002";
 "i_part_3_content" = "\U6307\U505a\U4e8b\U60c5\U7684\U575a\U6301\U7a0b\U5ea6\Uff08\U5305\U62ec\U514b\U670d\U969c\U788d\U6216\U6392\U9664\U5e72\U6270\U575a\U6301\U6d3b\U52a8\Uff09\U3002
 \n";
 "i_part_3_jianyi" = "\U5982\U679c\U8981\U4e2d\U65ad\U5b69\U5b50\U6b63\U5728\U8fdb\U884c\U7684\U6d3b\U52a8\U8981\U6ce8\U610f\U4e8b\U5148\U6253\U62db\U547c\U6216\U6162\U6162\U6765\Uff0c\U5982\U679c\U6709\U9700\U8981\U53ef\U4ee5\U5e2e\U52a9\U5b69\U5b50\U5c06\U957f\U7684\U529f\U8bfe\U5206\U6210\U51e0\U4e2a\U90e8\U5206\Uff0c\U6bcf\U90e8\U5206\U4e4b\U95f4\U5bb9\U8bb8\U4f11\U606f\Uff0c\U5982\U679c\U5b69\U5b50\U575a\U6301\U5b8c\U6210\U4e86\U529f\U8bfe\Uff0c\U4e00\U5b9a\U8981\U7ed9\U4e88\U8868\U626c\U6216\U5956\U52b1\U3002";
 "i_part_3_name" = "\U6301\U4e45\U6027";
 "i_part_3_pingjia" = "\U5b9d\U5b9d\U662f\U4e2a\U6301\U4e45\U6027\U9002\U4e2d\U7684\U5b69\U5b50\Uff0c\U6ce8\U610f\U529b\U548c\U6301\U4e45\U6027\U5728\U5e38\U6001\U8303\U56f4\U5185\Uff0c\U8fd9\U7c7b\U5b69\U5b50\U5bf9\U4e8b\U7269\U7684\U6001\U5ea6\U8868\U73b0\U5e73\U548c\Uff0c\U80fd\U6839\U636e\U5174\U8da3\U4f53\U73b0\U51fa\U81ea\U5df1\U7684\U4e13\U6ce8\U5ea6\U3002";
 "i_part_4_content" = "\U6307\U5b69\U5b50\U662f\U5426\U5bb9\U6613\U9002\U5e94\U65b0\U73af\U5883\Uff08\U5305\U62ec\U4eba\U6216\U4e8b\U7269\Uff09\U3002
 \n";
 "i_part_4_jianyi" = "\U826f\U597d\U7684\U9002\U5e94\U6027\U662f\U5b69\U5b50\U7684\U4f18\U70b9\Uff0c\U4f46\U8981\U6ce8\U610f\U5e2e\U52a9\U6216\U5f15\U5bfc\U5b69\U5b50\U9009\U62e9\U670b\U53cb\U6216\U5224\U65ad\U662f\U975e\U3002\U4f46\U6709\U65f6\U5b69\U5b50\U6216\U8bb8\U4e5f\U4f1a\U8868\U73b0\U51fa\U9002\U5e94\U4e0d\U826f\Uff0c\U8fd9\U65f6\U8981\U6ce8\U610f\U63d0\U4f9b\U673a\U4f1a\U7ed9\U5b69\U5b50\U6709\U4e00\U4e2a\U9010\U6b65\U9002\U5e94\U7684\U8fc7\U7a0b\Uff08\U5982\U4e0a\U5b66\U53ef\U5e26\U5b69\U5b50\U4e8b\U5148\U53c2\U89c2\U51e0\U6b21\Uff09\U3002";
 "i_part_4_name" = "\U9002\U5e94\U6027";
 "i_part_4_pingjia" = "\U5b9d\U5b9d\U662f\U4e2a\U4e2d\U5ea6\U7684\U9002\U5e94\U6027\U7684\U5b69\U5b50\Uff0c\U8fd9\U662f\U9002\U5e94\U884c\U4e3a\U7684\U4e00\U822c\U72b6\U6001\Uff0c\U9002\U5e94\U6240\U6709\U7684\U73af\U5883\U90fd\U4e0d\U4f1a\U5f88\U5feb\U6216\U5f88\U8d39\U65f6\U95f4\U3002";
 "i_part_5_content" = "\U6307\U60c5\U7eea\U3001\U523a\U6fc0\U53cd\U5e94\U7684\U5f3a\U5ea6\U5927\U5c0f\U3002";
 "i_part_5_jianyi" = "\U5c3d\U53ef\U80fd\U4e86\U89e3\U5b69\U5b50\U7684\U771f\U5b9e\U9700\U6c42\Uff0c\U8ba4\U771f\U5bf9\U5f85\U5b69\U5b50\U7684\U4e0d\U9002\U8bc9\U8bf4\U3002\U5f53\U5b69\U5b50\U60c5\U7eea\U5f3a\U70c8\U65f6\Uff0c\U4ee5\U5e73\U9759\U7684\U5fc3\U60c5\U548c\U65b9\U5f0f\U6765\U5bf9\U5f85\U5b69\U5b50\U7684\U53cd\U5e94\Uff0c\U4e0d\U53ef\U4ee5\U4e3a\U4e86\U5b89\U9759\U800c\U5bf9\U5b69\U5b50\U7684\U4e0d\U5408\U7406\U9700\U6c42\U59a5\U534f\U3002";
 "i_part_5_name" = "\U53cd\U5e94\U5f3a\U5ea6";
 "i_part_5_pingjia" = "\U5b69\U5b50\U662f\U4e2d\U7b49\U7684\U53cd\U6620\U5f3a\U5ea6\U7684\U5b69\U5b50\Uff0c\U662f\U9002\U5b9c\U7684\Uff0c\U65e2\U4e0d\U6fc0\U70c8\Uff0c\U4e5f\U4e0d\U4f1a\U8868\U73b0\U4e3a\U201c\U6ca1\U6709\U53cd\U5e94\U201d\Uff0c\U53cd\U6620\U6bd4\U8f83\U6e29\U548c\U3002";
 "i_part_6_content" = "\U901a\U4fd7\U7684\U8bb2\U5c31\U662f\Uff0c\U662f\U5426\U654f\U611f\Uff0c\U53ef\U4ee5\U8868\U73b0\U4e3a\U5bf9\U58f0\U3001\U5149\U3001\U6e29\U5ea6\U3001\U6c14\U5473\U7b49\U751f\U7406\U611f\U77e5\U7684\U654f\U611f\U6027\Uff0c\U4e5f\U53ef\U8868\U73b0\U4e3a\U5bf9\U4ed6\U4eba\U6001\U5ea6\U53d8\U5316\U7b49\U5fc3\U7406\U611f\U77e5\U7684\U654f\U611f\U6027\U3002
 \n";
 "i_part_6_jianyi" = "\U5bf9\U5916\U754c\U58f0\U97f3\U3001\U6c14\U5473\U3001\U5149\U7ebf\U3001\U6216\U5185\U90e8\U7684\U611f\U89c9\U53cd\U5e94\U6b63\U5e38\U7684\U5b9d\U5b9d\Uff0c\U4e0d\U5bb9\U6613\U6536\U5230\U73af\U5883\U523a\U6fc0\U7684\U5e72\U6270\Uff0c\U540c\U65f6\U4e5f\U5bf9\U5916\U754c\U7684\U523a\U6fc0\U4fdd\U6301\U4e00\U5b9a\U7684\U654f\U611f\U6027\U3002";
 "i_part_6_name" = "\U654f\U611f\U6027";
 "i_part_6_pingjia" = "\U5b9d\U5b9d\U662f\U4e2a\U654f\U611f\U6027\U9002\U4e2d\U7684\U5b69\U5b50\Uff0c\U80fd\U6bd4\U8f83\U51c6\U786e\U5730\U611f\U53d7\U5468\U56f4\U7684\U53d8\U5316\U548c\U81ea\U8eab\U7684\U8eab\U4f53\U72b6\U6001\Uff0c\U65e2\U4e0d\U8fc7\U654f\Uff0c\U53c8\U4e0d\U8fdf\U949d\Uff0c\U8fd9\U662f\U4e00\U79cd\U6b63\U5e38\U7684\U611f\U77e5\U72b6\U6001\U3002";
 "i_part_7_content" = "\U6307\U5b69\U5b50\U9762\U5bf9\U964c\U751f\U4eba\U6216\U65b0\U4e8b\U7269\Uff0c\U5176\U6700\U521d\U7684\U53cd\U5e94\U662f\U63a5\U8fd1\U8fd8\U662f\U9000\U7f29\U3002
 \n";
 "i_part_7_jianyi" = "\U5bb6\U957f\U8981\U77e5\U9053\U5b69\U5b50\U4e00\U5f00\U59cb\U62d2\U7edd\U53c2\U52a0\U7684\U6d3b\U52a8\U5176\U5b9e\U53ef\U80fd\U662f\U5b69\U5b50\U559c\U6b22\U7684\Uff0c\U5bb6\U957f\U8981\U5c3d\U53ef\U80fd\U4e86\U89e3\U5b69\U5b50\U7684\U5174\U8da3\Uff0c\U5f53\U8fdb\U884c\U67d0\U9879\U6d3b\U52a8\U65f6\Uff0c\U8981\U63d0\U4f9b\U5145\U5206\U7684\U65f6\U95f4\U7ed9\U5b69\U5b50\U3002
 \n\U5982\U679c\U5b69\U5b50\U7684\U8fd9\U79cd\U53cd\U5e94\U662f\U6070\U5f53\U7684\U53ef\U7ed9\U4e88\U9f13\U52b1\Uff0c\U4f46\U8981\U6ce8\U610f\U5b69\U5b50\U5bf9\U67d0\U4e00\U6d3b\U52a8\U5174\U8da3\U53ef\U80fd\U662f\U77ed\U6682\U7684\U3002";
 "i_part_7_name" = "\U8d8b\U907f\U6027";
 "i_part_7_pingjia" = "\U5b9d\U5b9d\U662f\U4e2a\U521d\U59cb\U53cd\U5e94\U9002\U5ea6\U7684\U5b69\U5b50\Uff0c\U65e2\U975e\U9000\U7f29\Uff0c\U53c8\U4e0d\U201c\U81ea\U6765\U719f\U201d\Uff0c\U5bf9\U5f85\U65b0\U9c9c\U7684\U4e8b\U7269\Uff0c\U6001\U5ea6\U53cd\U6620\U5e73\U548c\U3002";
 "i_part_8_content" = "\U6307\U5b69\U5b50\U5728\U65e5\U5e38\U751f\U6d3b\U4e2d\U7684\U8fd0\U52a8\U91cf\U3002";
 "i_part_8_jianyi" = "\U6839\U636e\U5b69\U5b50\U7684\U6d3b\U52a8\U7279\U70b9\U5b89\U6392\U9002\U91cf\U7684\U6d3b\U52a8\Uff0c\U4f46\U6ce8\U610f\U65f6\U95f4\U4e0d\U5b9c\U8fc7\U957f\Uff0c\U7c7b\U4f3c\U6d3b\U52a8\U4e5f\U4e0d\U5b9c\U8fc7\U591a\U3002";
 "i_part_8_name" = "\U6d3b\U52a8\U6027";
 "i_part_8_pingjia" = "\U5b9d\U5b9d\U662f\U4e2a\U6d3b\U52a8\U6027\U9002\U4e2d\U7684\U5b69\U5b50\Uff0c\U6d3b\U52a8\U91cf\U3001\U6d3b\U52a8\U7684\U9891\U7387\U548c\U901f\U5ea6\U9002\U4e2d\Uff0c\U65e2\U4e0d\U4f1a\U88ab\U8ba4\U4e3a\U662f\U591a\U52a8\Uff0c\U4e5f\U4e0d\U4f1a\U88ab\U8ba4\U4e3a\U662f\U4e0d\U79ef\U6781\U3002";
 "i_part_9_content" = "\U6307\U6ce8\U610f\U6613\U5206\U6563\U7684\U5b69\U5b50\U80fd\U8f83\U5feb\U7684\U6ce8\U610f\U5230\U5468\U56f4\U7684\U4e8b\U60c5\Uff0c\U5728\U5a74\U5e7c\U513f\U671f\U663e\U5f97\U5bb9\U6613\U629a\U6170\Uff0c\U4f46\U5b66\U4e60\U540e\U4f1a\U5f71\U54cd\U5b66\U4e60\U6210\U7ee9\U3002";
 "i_part_9_jianyi" = "\U5bf9\U4e8e\U5927\U5b69\U5b50\Uff0c\U6ce8\U610f\U51cf\U5c11\U73af\U5883\U4e2d\U7684\U5e72\U6270\U56e0\U7d20\Uff0c\U5728\U6709\U5e72\U6270\U65f6\Uff0c\U5e2e\U52a9\U5b69\U5b50\U56de\U5230\U624b\U5934\U4e0a\U7684\U5de5\U4f5c\U53bb\Uff0c\U52a0\U5f3a\U5b69\U5b50\U7684\U8d23\U4efb\U5fc3\Uff0c\U5bf9\U514b\U670d\U5206\U5fc3\U5b8c\U6210\U529f\U8bfe\U4e88\U4ee5\U8868\U626c\U548c\U9f13\U52b1\U3002";
 "i_part_9_name" = "\U6ce8\U610f\U5206\U6563\U5ea6";
 "i_part_9_pingjia" = "\U5b9d\U5b9d\U662f\U4e2a\U4e13\U6ce8\U9002\U4e2d\U7684\U5b69\U5b50\Uff0c\U4e0d\U50cf\U597d\U5206\U5fc3\U7684\U5b69\U5b50\U90a3\U4e48\U5bb9\U6613\U53d7\U5e72\U6270\Uff0c\U4e5f\U4e0d\U50cf\U201c\U4e13\U6ce8\U201d\U7684\U5b69\U5b50\U5fc5\U987b\U63d0\U9192\U624d\U80fd\U8f6c\U79fb\U6ce8\U610f\U3002";
 "i_time" = "63\U5929\U524d";
 "i_value" = "\U4e2d\U95f4\U578b";
 "i_value_info_1" = "\U5b69\U5b50\U4e2a\U6027\U7279\U5f81\U4e0d\U660e\U663e\Uff0c\U5176\U884c\U4e3a\U8868\U73b0\U90fd\U5747\U5728\U4e2d\U95f4\U8303\U56f4\U5185\Uff0c\U5c5e\U4e8e\U4e2d\U95f4\U578b\U6c14\U8d28\U3002";
 "i_value_info_2" = "\U5e7c\U513f\U7684\U65e5\U5e38\U6d3b\U52a8\U91cf\U9002\U4e2d\Uff0c\U6d3b\U52a8\U6c34\U5e73\U4e0e\U5176\U4ed6\U5e7c\U513f\U65e0\U5dee\U5f02\U3002\U751f\U7406\U8282\U5f8b\U6027\U6d3b\U52a8\U6709\U4e00\U5b9a\U7684\U89c4\U5f8b\Uff0c\U5bf9\U6765\U81ea\U4f53\U5185\U5916\U7684\U523a\U6fc0\U53cd\U5e94\U9002\U4e2d\U3002\U5728\U517b
 
 \n\U80b2\U6216\U5e26\U9886\U8fc7\U7a0b\U4e2d\U4e0d\U4f1a\U663e\U5f97\U975e\U5e38\U56f0\U96be\U3002
 \n";
 "i_yueling" = 0;
 "qizhi_1" = 6;
 "qizhi_2" = 5;
 "qizhi_3" = 6;
 "qizhi_4" = 6;
 "qizhi_5" = 6;
 "qizhi_6" = 5;
 "qizhi_7" = 5;
 "qizhi_8" = 4;
 "qizhi_9" = 6;
 } */
-(void)updateHeader{
    
    [_mounth setText:[_reportDict objectForKey:@"i_yueling"]];
    
    _date.text = [_reportDict objectForKey:@"i_time"];
    
    _result.text = [_reportDict objectForKey:@"i_value"];
}



-(void) drawPic
{
    
    UIImageView *imageView1=[[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:imageView1];
    
    UIImageView * leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_left.gif"]];
    CGFloat picW = CGImageGetWidth(leftView.image.CGImage);
    CGFloat picH = CGImageGetHeight(leftView.image.CGImage);
    
    CGFloat leftWidth = screenWidth*kLeftRatio;
    CGFloat leftHeight = (CGFloat)((leftWidth * picH)/picW) ;
    CGFloat leftX = screenWidth*kPaddingRatio;
    CGFloat leftY = 0;
    leftView.frame = CGRectMake(leftX, leftY, leftWidth, leftHeight);
    [imageView1 addSubview:leftView];
    
    
    UIImageView * centerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_center.jpg"]];
    CGFloat centerW = CGImageGetWidth(centerView.image.CGImage);
    CGFloat centerH = CGImageGetHeight(centerView.image.CGImage);
    
    CGFloat centerWidth = screenWidth*kCenterRatio;
    CGFloat centerHeight = (CGFloat)((centerWidth * centerH)/centerW) ;
    CGFloat centerX = CGRectGetMaxX(leftView.frame);
    CGFloat centerY = 0;
    _centerHeight = centerHeight;
    _centerWidth =      centerWidth;
    _centerX= centerX;
    _centerY = centerY;
    for (int i = 0; i < 8; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(centerX+i*(centerWidth), centerY, centerWidth, centerHeight)];
        [img setImage:[UIImage imageNamed:@"temp_report_center.jpg"]];
        [imageView1 addSubview:img];
        
    }
    
    
    
    UIImageView * rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_right.gif"]];
    CGFloat rightW = CGImageGetWidth(rightView.image.CGImage);
    CGFloat rightH = CGImageGetHeight(rightView.image.CGImage);
    
    CGFloat rightWidth = screenWidth*kRightRatio;
    CGFloat rightHeight = (CGFloat)((rightWidth * rightH)/rightW) ;
    CGFloat rightX = screenWidth*(kPaddingRatio+8*kCenterRatio+kLeftRatio);
    CGFloat rightY = 0;
    rightView.frame = CGRectMake(rightX, rightY, rightWidth, rightHeight);
    [imageView1 addSubview:rightView];
    
    UIImageView * bottomView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"temp_report_bottom.gif"]];
    CGFloat bottomW = CGImageGetWidth(bottomView.image.CGImage);
    CGFloat bottomH = CGImageGetHeight(bottomView.image.CGImage);
    
    CGFloat bottomWidth = screenWidth*(kRightRatio+8*kCenterRatio+kLeftRatio);
    CGFloat bottomHeight = (CGFloat)((bottomWidth * bottomH)/bottomW) ;
    CGFloat bottomX = screenWidth*(kPaddingRatio);
    CGFloat bottomY = CGRectGetMaxY(leftView.frame);
    bottomView.frame = CGRectMake(bottomX, bottomY, bottomWidth, bottomHeight);
    [imageView1 addSubview:bottomView];
    //_picHeight = CGRectGetMaxY(bottomView.frame);
    
   
}
-(void) drawLineWithBegin:(CGPoint) begin withEnd:(CGPoint)end withRange:(CGRect)range
{
    
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:range];
    [self.view addSubview:imageView];
    
    
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), begin.x, begin.y);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), end.x, end.y);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
}
@end
