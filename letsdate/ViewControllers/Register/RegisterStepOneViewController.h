//
//  RegisterStepOneViewController.h
//  letsdate
//
//  Created by LiuX on 15/5/5.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "BaseViewController.h"
#import "LDUserModel.h"

typedef enum {
    RegisterStepOne = 1,
    RegisterStepTwo,
    RegisterStepThree,
    RegisterStepFour
} RegisterStep;

@interface RegisterStepOneViewController : BaseViewController

@property (nonatomic, strong) LDUserModel *registerProfile;

@property (nonatomic, assign) RegisterStep step;

@end
