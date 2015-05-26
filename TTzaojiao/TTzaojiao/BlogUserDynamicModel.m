//
//  BlogUserDynamicModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-30.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "BlogUserDynamicModel.h"

@implementation BlogUserDynamicModel
+(instancetype)blogUserDynamicModelWithDict:(NSDictionary *)dict{
    if (dict.count == 4) {
        return nil;
    }
    BlogUserDynamicModel* model = [[BlogUserDynamicModel alloc]init];
    if (model) {
        [model setModeWithDictionary:dict];
    }
    return model;
}


-(void)setModeWithDictionary:(NSDictionary*)dict{
    /*
     @property (copy, nonatomic) NSString * msg;
     @property (copy, nonatomic) NSString * msg_word;
     @property (copy, nonatomic) NSString * p_0;
     @property (copy, nonatomic) NSString * p_1;
     @property (copy, nonatomic) NSString * p_2;
     */
    self.msg = [dict objectForKey:@"msg"];
    self.msg_word = [dict objectForKey:@"msg_word"];
    self.p_0 = [dict objectForKey:@"p_0"];
    self.p_1 = [dict objectForKey:@"p_1"];
    self.p_2 = [dict objectForKey:@"p_2"];
    
    /*
     @property (copy, nonatomic) NSString * i_Album;
     @property (copy, nonatomic) NSString * i_Forward;
     @property (copy, nonatomic) NSString * i_Forward_Num;
     @property (copy, nonatomic) NSString * i_class_part;
     @property (copy, nonatomic) NSString * i_content;
     @property (copy, nonatomic) NSString * i_distance_time;
     @property (copy, nonatomic) NSString * i_hidden;
     @property (copy, nonatomic) NSString * i_item;
     @property (copy, nonatomic) NSString * i_master;
     @property (copy, nonatomic) NSString * i_month;
     @property (copy, nonatomic) NSString * i_otime;
     @property (copy, nonatomic) NSString * i_pic;
     @property (copy, nonatomic) NSString * i_replay;
     @property (copy, nonatomic) NSString * i_sort;
     @property (copy, nonatomic) NSString * i_uid;
     @property (copy, nonatomic) NSString * i_x;
     @property (copy, nonatomic) NSString * i_y;
     @property (copy, nonatomic) NSString * i_zan;
     @property (copy, nonatomic) NSString * id;
     */
    
    self.i_Album = [dict objectForKey:@"i_Album"];
    self.i_Forward = [dict objectForKey:@"i_Forward"];
    self.i_Forward_Num = [dict objectForKey:@"i_Forward_Num"];
    self.i_class_part = [dict objectForKey:@"i_class_part"];
    self.i_content = [dict objectForKey:@"i_content"];
    self.i_distance_time = [dict objectForKey:@"i_distance_time"];
    self.i_hidden = [dict objectForKey:@"i_hidden"];
    self.i_item = [dict objectForKey:@"i_item"];
    self.i_master = [dict objectForKey:@"i_master"];
    self.i_month = [dict objectForKey:@"i_month"];
    self.i_otime = [dict objectForKey:@"i_otime"];
    self.i_pic = [dict objectForKey:@"i_pic"];
    self.i_replay = [dict objectForKey:@"i_replay"];
    self.i_sort = [dict objectForKey:@"i_sort"];
    self.i_uid = [dict objectForKey:@"i_uid"];
    self.i_x = [dict objectForKey:@"i_x"];
    self.i_y = [dict objectForKey:@"i_y"];
    self.i_zan = [dict objectForKey:@"i_zan"];
    self.id = [dict objectForKey:@"id"];
    
}


-(NSArray *)photosURLStr{
    
    NSString* picurlstrs = self.i_pic;
    if (self.i_pic.length != 0) {
        NSArray* picurls = [picurlstrs componentsSeparatedByString:@"|"];
        NSMutableArray* tmparray = [picurls mutableCopy];
        
        [picurls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqualToString:@""]) {
                [tmparray removeObject:obj];
            }
        }];
        _photosURLStr = tmparray;
    }else{
        _photosURLStr = nil;
    }
    
    return _photosURLStr;
}
@end
