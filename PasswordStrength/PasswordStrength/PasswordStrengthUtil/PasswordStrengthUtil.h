//
//  PasswordStrengthUtil.h
//  Driver-ios
//
//  Created by Edward on 2020/2/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
* 密码强度检测工具类
*/
@interface PasswordStrengthUtil : NSObject
//创建单例
+ (instancetype)sharedInstance;

- (NSInteger)passwordStrengthWith:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
