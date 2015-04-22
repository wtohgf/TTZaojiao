//
//  TTWebServerAPI.h
//  TTzaojiao
//
//  Created by hegf on 15-4-17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#ifndef TTzaojiao_TTWebServerAPI_h
#define TTzaojiao_TTWebServerAPI_h

#define TAG  @"webTag" 
// ±‡¬Î∏Ò Ω£∫UTF-8
#define UTF8  @"UTF-8" 
// ±‡¬Î∏Ò Ω£∫GBK
#define GBK  @"GBK" 
// ªÒµ√À˘”– ° ––≈œ¢
#define LOCATION_INFO  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_ProvinceAndCity"
// ◊¢≤·µ⁄“ª≤Ω
#define REGISTER_FIRST_STEP  @"http://www.ttzaojiao.com/appcode/?act=Get_Reg_1" 
// ◊¢≤·µ⁄∂˛≤Ω
#define REGISTER_SECOND_STEP  @"http://www.ttzaojiao.com/appcode/?act=Get_Reg_2" 
// µ«¬º
#define LOGIN  @"http://www.ttzaojiao.com/appcode/?act=Get_Login" 
// Ω◊Ã›øŒ≥Ã–≈œ¢
#define GET_MY_CLASS  @"http://www.ttzaojiao.com/appcode/?Act=Get_Me_Class" 
// ÕºŒƒøŒ≥Ã
#define LESSON  @"http://www.ttzaojiao.com/appcode/?Act=Get_Me_Class_Text" 
// …œ¥´Õº∆¨µÿ÷∑
#define UPLOAD_IMAGE  @"http://www.ttzaojiao.com/Up.html" 
// ≥…≥§∑¢”˝∆¿≤‚Ω·π˚
#define GROW_TEST_SUBMIT  @"http://www.ttzaojiao.com/appcode/?Act=Get_Test_ChengZhang" 
// ≥…≥§∑¢”˝∆¿≤‚±®∏Ê
#define GROW_TEST_GET_REPORT  @"http://www.ttzaojiao.com/appcode/?Act=Get_Test_ChengZhang_List_View" 
// ≥…≥§∑¢”˝∆¿≤‚¡–±Ì
#define GROW_TEST_LIST  @"http://www.ttzaojiao.com/appcode/?Act=Get_Test_ChengZhang_List" 
// ∆¯÷ «È–˜≤‚∆¿- ◊¥Œ≤‚∆¿&ºÃ–¯≤‚∆¿
#define TEMPERAMENT_TEST  @"http://www.ttzaojiao.com/appcode/?Act=Get_Test_Qizhi" 
// ∆¯÷ «È–˜∆¿≤‚±®∏Ê
#define TEMPERAMENT_REPORT  @"http://www.ttzaojiao.com/appcode/?Act=Get_Test_QiZhi_List_View" 
// ∆¯÷ «È–˜∆¿≤‚¡–±Ì
#define TEMPERAMENT_TEST_LIST  @"http://www.ttzaojiao.com/appcode/?Act=Get_Test_QiZhi_List" 
// ªÒµ√ƒ∏”§≤Ÿ–≈œ¢
#define GYM_INFO  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_Video_Gym" 
// –ﬁ∏ƒÕ∑œÒ
#define UPDATE_ICON  @"http://www.ttzaojiao.com/appcode/?Act=Get_Mod_User_Face" 
// –ﬁ∏ƒ∏ˆ»À∑‚√Ê
#define UPDATE_COVER  @"http://www.ttzaojiao.com/appcode/?Act=Get_Mod_User_Cover" 
// –ﬁ∏ƒ√‹¬Î
#define UPDATE_PASSWORD  @"http://www.ttzaojiao.com/appcode/?Act=Get_Mod_User_Psd" 
// –ﬁ∏ƒ”√ªß–≈œ¢
#define UPDATE_INFO  @"http://www.ttzaojiao.com/appcode/?Act=Get_Mod_User_Info" 
// ∏ΩΩ¸-±¶±¶
#define NEARBY_BABY  @"http://www.ttzaojiao.com/appcode/?Act=Get_Test_User_List_Distance" 
// ≥‰÷µø®Ω”ø⁄
#define PAY_BY_CARD  @"http://www.ttzaojiao.com/appcode/?Act=Get_Pay_Card" 
// VIPº€ŒªΩ”ø⁄
#define VIP_PRICE  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_Alipay_Price&p_1=1&p_2=100" 
// ªÒ»°∏ˆ»À–≈œ¢
#define USER_INFO  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_User_Info" 
// ªÒµ√∂ØÃ¨
#define USER_BLOG  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_User_Blog" 
// ªÒµ√œ‡≤·
#define USER_BLOG_ALBUM  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_User_Blog_Album" 
// ∑¢≤º∂ØÃ¨
#define PUBLISH_STATE  @"http://www.ttzaojiao.com/appcode/?Act=Blog_Add" 
//  «∑Òπÿ◊¢
#define IS_FRIEND  @"http://www.ttzaojiao.com/appcode/?Act=Friend_Yes" 
// πÿ◊¢
#define ADD_ATTENTION  @"http://www.ttzaojiao.com/appcode/?Act=Friend_Add" 
// »°œ˚πÿ◊¢
#define DELETE_ATTENTION  @"http://www.ttzaojiao.com/appcode/?Act=Friend_Del" 
// ªÒµ√±æ÷‹øŒ≥Ãid
#define GET_THIS_WEEK_LESSON_ID  @"http://www.ttzaojiao.com/appcode/?Act=Get_Me_Class_Now" 
// ªÒµ√±æ÷‹øŒ≥Ã–≈œ¢
#define GET_LESSON_INFO  @"http://www.ttzaojiao.com/appcode/?Act=Get_Me_Class_Info" 
// ªÒµ√øŒ≥ÃªÓ∂ØœÍœ∏–≈œ¢
#define GET_LESSON_DETAIL_INFO  @"http://www.ttzaojiao.com/appcode/?Act=Get_Me_ClassPart_Info" 
// ªÒµ√øŒ≥ÃªÓ∂Ø ”∆µµÿ÷∑
#define GET_LESSON_VIDEO_PATH  @"http://www.ttzaojiao.com/appcode/?Act=Get_Me_ClassPart_Study" 
// ªÒµ√øŒ≥Ã÷–ªÓ∂Øµƒ∂ØÃ¨ &i_uid=39315&p_1=1&p_2=15&i_sort=0&id=1
#define GET_LIST_BLOG  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_Blog" 
// µ„‘ﬁ
#define PRAISE  @"http://www.ttzaojiao.com/appcode/?Act=Get_Me_Good" 
// &i_uid=1977&i_psd=e10adc3949ba59abbe56e057f20f883e&id=18
#define PRAISE_NEW  @"http://www.ttzaojiao.com/appcode/?Act=Blog_Zan" 
// ∑¢±Ì∆¿¬€
// &i_uid=1977&i_psd=3e9fe397381d3e595979a716ebf32c21&i_id=1&i_content=00&i_x=0&i_y=0
#define COMMENT  @"http://www.ttzaojiao.com/appcode/?Act=Blog_Add_Replay" 
// ∆¿¬€¡–±Ì
// &i_id=1&p_1=1&p_2=15
#define COMMENT_LIST  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_Blog_Replay" 
// ªÒµ√ÃÂ—È’À∫≈µƒøŒ≥Ãid
// &i_year=2015&i_month=4&i_day=3
#define GET_ME_CLASS_NOW_EXPERIENCE  @"http://www.ttzaojiao.com/appcode/?Act=Get_Me_Class_Now_Experience" 
// ªÒµ√ÃÂ—È’À∫≈µƒøŒ≥Ã–≈œ¢
// &id=1&i_year=2015&i_month=4&i_day=3
#define GET_ME_CLASS_INFO_EXPERIENCE  @"http://www.ttzaojiao.com/appcode/?Act=Get_Me_Class_Info_Experience" 
// ∏¸–¬”√ªß◊¯±Í
// &i_x=xxxxx&i_y=xxxxx&i_uid=1977&i_psd=XXXXX
#define UPDATE_LOCATION  @"http://www.ttzaojiao.com/appcode/?Act=Get_Mod_User_Distance" 
// ªÒµ√∞Ê±æ∫≈∫ÕAPKœ¬‘ÿµÿ÷∑
#define GET_VERSION  @"http://www.ttzaojiao.com/appcode/?Act=Get_Version" 
// TODO ±æµÿƒ£ƒ‚≤‚ ‘µÿ÷∑
// #define GET_VERSION 
// "http://192.168.1.111:8080/NewsWebProject/GetNewestVersionAction?index=18" 
// …æ≥˝∂ØÃ¨
// &i_uid=1977&i_psd=e10adc3949ba59abbe56e057f20f883e&i_id=1
#define DELETE_DYNAMIC_STATE  @"http://www.ttzaojiao.com/appcode/?Act=Blog_Del" 
// ªÒµ√∫√”—¡–±Ì
// &i_uid=1977&i_psd=e10adc3949ba59abbe56e057f20f883e
#define GET_FRIEND  @"http://www.ttzaojiao.com/appcode/?Act=Get_User_Friend" 
// ªÒµ√∑€Àø¡–±Ì
// &i_uid=1977&i_psd=e10adc3949ba59abbe56e057f20f883e
#define GET_FAN  @"http://www.ttzaojiao.com/appcode/?Act=Get_User_Fans" 
// ªÒµ√”√ªß «∑Ò“—«©µΩ
// &i_uid=40195&i_psd=343b1c4a3ea721b2d640fc8700db0f36
#define BLOG_SIGN_YES  @"http://www.ttzaojiao.com/appcode/?Act=Blog_Sign_Yes" 
// «©µΩΩ”ø⁄
// &i_uid=40195&i_psd=343b1c4a3ea721b2d640fc8700db0f36
#define BLOG_SIGN  @"http://www.ttzaojiao.com/appcode/?Act=Blog_Sign" 
// ª˝∑÷∂“ªªøŒ≥Ã
// &i_uid=40195&i_psd=343b1c4a3ea721b2d640fc8700db0f36&i_user=18641166061&i_month=1
#define BLOG_JIFEN_CLASS  @"http://www.ttzaojiao.com/appcode/?Act=Blog_Jifen_Class" 
// ªÒµ√÷∏∂®‘¬¡‰≤„µƒ∂ØÃ¨Ã÷¬€–≈œ¢
// &i_uid=39315&p_1=1&p_2=15&i_sort=1&i_group=1
#define GET_LIST_BLOG_GROUP  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_Blog_Group" 
// ¿±¬ËΩ÷¡–±Ì
// &i_uid=39315&p_1=1&p_2=10&i_city=0
#define GET_LIST_ACTIVE  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_Active" 
// …Í«Î»Î◊§¿±¬ËΩ÷
// &i_uid=40195&i_psd=343b1c4a3ea721b2d640fc8700db0f36&i_company=ddalianxinz&i_name=gk&i_tel=12356
#define ADD_REG_COMPAY  @"http://www.ttzaojiao.com/appcode/?Act=Add_Reg_Compay" 
// ¿±¬ËΩ÷œÍœ∏–≈œ¢
// &i_id=1
#define GET_LIST_ACTIVE_SHOW  @"http://www.ttzaojiao.com/appcode/?Act=Get_List_Active_Show" 

#endif
