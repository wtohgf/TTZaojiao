//
//  BlogModel.m
//  TTzaojiao
//
//  Created by hegf on 15-4-24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "BlogModel.h"

@implementation BlogModel
+(instancetype)blogModeWithDict:(NSDictionary *)dict{
    BlogModel* blog = [[BlogModel alloc]init];
    
    [blog setModeWithDictionary:dict];
    
    return blog;
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
     @property (copy, nonatomic) NSString * id; //
     @property (copy, nonatomic) NSString * i_y; //
     @property (copy, nonatomic) NSString * i_x; //
     @property (copy, nonatomic) NSString * i_distance_time; //
     @property (copy, nonatomic) NSString * i_otime;//
     @property (copy, nonatomic) NSString * i_replay; //
     @property (copy, nonatomic) NSString * i_zan; //
     @property (copy, nonatomic) NSString * i_pic; //
     @property (copy, nonatomic) NSString * i_content; //
     @property (copy, nonatomic) NSString * i_uid; //
     @property (copy, nonatomic) NSString * baby_name; //
     @property (copy, nonatomic) NSString * face; //
     @property (copy, nonatomic) NSString * Birthday; //
     @property (strong, nonatomic) NSArray * replay;
     */
    self.id = [dict objectForKey:@"id"];
    self.i_y = [dict objectForKey:@"i_y"];
    self.i_x = [dict objectForKey:@"i_x"];
    self.i_distance_time = [dict objectForKey:@"i_distance_time"];
    self.i_otime = [dict objectForKey:@"i_otime"];
    self.i_replay = [dict objectForKey:@"i_replay"];
    self.i_zan = [dict objectForKey:@"i_zan"];
    self.i_pic = [dict objectForKey:@"i_pic"];
    self.i_content = [dict objectForKey:@"i_content"];
    self.i_uid = [dict objectForKey:@"i_uid"];
    self.baby_name = [dict objectForKey:@"baby_name"];
    self.face = [dict objectForKey:@"face"];
    self.Birthday = [dict objectForKey:@"Birthday"];
    self.replay = [dict objectForKey:@"replay"];
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
