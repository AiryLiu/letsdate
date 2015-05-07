//
//  WebViewController.h
//  LiCaiShi
//
//  Created by LCL on 14-3-17.
//  Copyright (c) 2014年 9888. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *postBody;

@property (nonatomic, copy) NSString *method;

@property (nonatomic) UIDataDetectorTypes dataDetectorTypes;

@property (nonatomic, strong) UIViewController *previousViewController;

- (void)reloadRequest;

@end
