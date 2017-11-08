//
//  NSString+Verification.m
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

#import "NSString+Verification.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Verification)

/**
 *  判断字符串是否有效
 */
- (BOOL)isValidString
{
    if (!self || ![self isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return ![string isEqualToString:@""];
}

/**
 *  判断是否为有效的手机号
 */
- (BOOL)isValidPhoneNumber
{
    NSString *regex = @"^1\\d{10}$"; // 暂定（以1开头的11位数字）
    return [self isMatchRegex:regex];
}

/**
 *  判断字符串是否匹配指定的正则表达式
 *
 *  @param regex 指定的正则表达式
 */
- (BOOL)isMatchRegex:(NSString *)regex
{
    if (self.length == 0) {
        return NO;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

/**
 *  将字符串进行MD5加密
 */
- (NSString *)makeMD5String
{
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [NSMutableString string];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i ++){
        [outputString appendFormat:@"%02x", outputBuffer[i]];
    }
    return [NSString stringWithString:outputString];
}

/**
 *  给URL地址中的特殊字符进行编码
 *
 *  @return 编码后的ULR地址
 */
- (NSString *)stringByEncodingForURL
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
