//
//  TTWoScoreViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/8.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTWoScoreViewController.h"
#import <RDVTabBarController.h>
#import "TTWoScoreIntroduceCell.h"

@interface TTWoScoreViewController (){
    NSArray* _scoreIntroList;
}
@property (weak, nonatomic) IBOutlet UITableView *scoreIntroTableView;

@end

@implementation TTWoScoreViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars
        = NO;
        self.modalPresentationCapturesStatusBarAppearance
        = NO;
    }
    NSString* path = [[NSBundle mainBundle]pathForResource:@"ScoreIntroduce.plist" ofType:nil];
    _scoreIntroList = [NSArray arrayWithContentsOfFile:path];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* sectionList = _scoreIntroList[indexPath.section];
    UITableViewCell* tmpcell;
    if (indexPath.row == 0) {
        if (indexPath.section == 0) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"meiriCell"];
            tmpcell = cell;
        }
        if (indexPath.section == 1) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"leijiCell"];
            tmpcell = cell;
        }
        if (indexPath.section == 2) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"jiefenCell"];
            tmpcell = cell;
        }

    }else{
        NSDictionary* dict = sectionList[indexPath.row - 1];
        TTWoScoreIntroduceCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SCOREINTRO"];
        cell.title.text = [dict objectForKey:@"title"];
        cell.score.text = [dict objectForKey:@"score"];
        cell.introduce.text = [dict objectForKey:@"introduce"];
        tmpcell = cell;
    }
    tmpcell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/17 - 64.f);
    
    return tmpcell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _scoreIntroList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else if(section == 1){
        return 5;
    }else{
        return 7;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30.f;
}

@end
