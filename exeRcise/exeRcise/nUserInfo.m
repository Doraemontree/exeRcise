//
//  nUserInfo.m
//  exeRcise
//
//  Created by hemeng on 17/6/18.
//  Copyright © 2017年 hemeng. All rights reserved.
//

#import "nUserInfo.h"

@implementation nUserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _uid           = @"";
        _password      = @"";
        _name          = @"";
        _height        = 0;
        _weight        = 0;
        _lastLoginTime = 0;
        _sex           = @"";
        _aimC          = 0;
        _aimD          = 0;
        _aimT          = 0;
        
        _runningAr = [NSMutableArray array];
        _cyclingAr = [NSMutableArray array];
        _walkingAr = [NSMutableArray array];
    }
    return self;
}

@end
