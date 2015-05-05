//
//  TTDynamicSidebarViewController.m
//  TTzaojiao
//
//  Created by Liang Zhang on 15/5/5.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "TTDynamicSidebarViewController.h"

@interface TTDynamicSidebarViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView* menuTableView;

@end

@implementation TTDynamicSidebarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = CGRectMake(self.contentView.bounds.origin.x,
                              self.contentView.bounds.origin.y+[UIApplication sharedApplication].statusBarFrame.size.height,
                              self.contentView.bounds.size.width,
                              self.contentView.bounds.size.height);
    self.menuTableView = [[UITableView alloc] initWithFrame:frame];
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.menuTableView.backgroundColor = [UIColor clearColor];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    [self.contentView addSubview:self.menuTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sidebarMenuCellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebarMenuCellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sidebarMenuCellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    switch (indexPath.row) {
        case 1:
        {
            cell.textLabel.text = @"0-3月龄";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"4-6月龄";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"7-9月龄";
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"10-12月龄";
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"13-15月龄";
        }
            break;
        case 6:
        {
            cell.textLabel.text = @"16-18月龄";
        }
            break;
        case 7:
        {
            cell.textLabel.text = @"19-21月龄";
        }
            break;
        case 8:
        {
            cell.textLabel.text = @"22-24月龄";
        }
            break;
        case 9:
        {
            cell.textLabel.text = @"其他月龄";
        }
            break;
            
        default:
        {
            cell.textLabel.text = @"全部月龄";
        }
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showHideSidebar];
    
}

@end
