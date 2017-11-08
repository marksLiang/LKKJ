//
//  NSString+Verification.h
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verification)

/**
 *  判断字符串是否有效
 */
- (BOOL)isValidString;

/**
 *  判断是否为有效的手机号
 */
- (BOOL)isValidPhoneNumber;

/**
 *  判断字符串是否匹配指定的正则表达式
 *
 *  @param regex 指定的正则表达式
 */
- (BOOL)isMatchRegex:(NSString *)regex;

/**
 *  将字符串进行MD5加密
 */
- (NSString *)makeMD5String;

/**
 *  给URL地址中的特殊字符进行编码
 *
 *  @return 编码后的ULR地址
 */
- (NSString *)stringByEncodingForURL;


@end
