//
//  ClientConfigure.h
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#ifndef letsdate_ClientConfigure_h
#define letsdate_ClientConfigure_h
#endif

static NSString *const LD_QUERY_STATUS_SUCCESS = @"1-001";// 成功
static NSString *const LD_QUERY_STATUS_ERROR = @"2-002";// 失败

static NSString *const LD_QUERY_ERROR_DOMAIN = @"com.letsdate.api";// 失败

static NSString *const ACCOUNT_LOGIN = @"/Account/Login";// 登录

static NSString *const ACCOUNT_REGIST = @"/Account/Regist";// 注册

static NSString *const ACCOUNT_UPDATE_PWD = @"/Account/UpdatePwd";// 修改密码

static NSString *const ACCOUNT_UPDATE_USER_MESSAGE = @"/Account/UpdateUserMessage";// 修改个人资料

static NSString *const ACCOUNT_GET_MAIN_LIST = @"/Account/GetMainList";// 获取主页信息

static NSString *const ACCOUNT_GET_ME_MESSAGE = @"/Account/GetMeMessage";// 我的详情

static NSString *const ACCOUNT_IT_MESSAGE = @"/Account/ItMessage";// 他人详情

static NSString *const ACCOUNT_AT_PEO = @"/Account/AtPeo";// 关注别人

static NSString *const ACCOUNT_SAY_HELLO = @"/Account/SayHello";// 打招呼

static NSString *const ACCOUNT_GET_BLACK = @"/Account/GetBlack";// 拉黑

static NSString *const ACCOUNT_GET_BLACK_LIST = @"/Account/GetBlackList";// 拉黑列表

static NSString *const ACCOUNT_GET_SEE_OTHER_LIST = @"/Account/GetSeeOtherList";// 我的最近浏览列表

static NSString *const ACCOUNT_GET_COME_LIST = @"/Account/GetComeList";// 来访列表

static NSString *const ACCOUNT_GET_AT_ME_LIST = @"/Account/GetAtMeList";// 关注我的列表

static NSString *const ACCOUNT_GET_ME_AT_LIST = @"/Account/GetMeAtList";// 我的关注列表

static NSString *const ACCOUNT_GET_CHAT_DETAILS = @"/Account/GetChatDetails";// 聊天详情

static NSString *const ACCOUNT_GET_CHAT_LIST = @"/Account/GetChatList";// 聊天消息列表

static NSString *const ACCOUNT_GET_NO_READ_COUNT = @"/Account/GetNoReadCount";// 未读消息数量

static NSString *const ACCOUNT_SEND_ME_MESSAGE = @"/Account/SendMeMessage";// 聊天发送消息
