//
//  UIImage+DAExtension.h
//  DigitalAlbum
//
//  Created by Ningmeng on 2016/12/9.
//  Copyright © 2016年 Zapper. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DA_MAX_UPLOAD_SIZE (100 * 1024) // 最大上传图片文件大小（默认：100KB）
#define DA_MIN_UPLOAD_SIZE (CGSizeMake(1280.0, 720.0)) // 最大上传图片尺寸大小（1280 * 720）

@interface UIImage (DAExtension)

/**
 将图片压缩，返回压缩后的图片数据
 
 @param image 要压缩的图片
 @param ratio 压缩比例（1.0 ~ 0.1）
 @return 缩后的图片数据
 */
+ (NSData *)da_compressImageToData:(UIImage *)image withRatio:(CGFloat)ratio;

/**
 将图片压缩，返回压缩后的图片
 
 @param image 要压缩的图片
 @param ratio 压缩比例（1.0 ~ 0.1）
 @return 缩后的图片
 */
+ (UIImage *)da_compressImage:(UIImage *)image withRatio:(CGFloat)ratio;

@end
