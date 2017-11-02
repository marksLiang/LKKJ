//
//  UIImage+DAExtension.m
//  DigitalAlbum
//
//  Created by Ningmeng on 2016/12/9.
//  Copyright © 2016年 Zapper. All rights reserved.
//

#import "UIImage+DAExtension.h"

@implementation UIImage (DAExtension)

/**
 将图片压缩，返回压缩后的图片数据
 
 @param image 要压缩的图片
 @param ratio 压缩比例（1.0 ~ 0.1）
 @return 缩后的图片数据
 */
+ (NSData *)da_compressImageToData:(UIImage *)image withRatio:(CGFloat)ratio
{
    ratio = MIN(1.0, ratio);
    return [UIImage da_compressImageToData:image compressRatio:ratio maxCompressRatio:0.1];
}

/**
 将图片压缩，返回压缩后的图片
 
 @param image 要压缩的图片
 @param ratio 压缩比例（1.0 ~ 0.1）
 @return 缩后的图片
 */
+ (UIImage *)da_compressImage:(UIImage *)image withRatio:(CGFloat)ratio
{
    NSData *data = [UIImage da_compressImageToData:image withRatio:ratio];
    return [[UIImage alloc] initWithData:data];
}

#pragma mark - Private

+ (NSData *)da_compressImageToData:(UIImage *)image compressRatio:(CGFloat)ratio maxCompressRatio:(CGFloat)maxRatio
{
    //We first shrink the image a little bit in order to compress it a little bit more
    CGSize originalSize = image.size;
    CGSize targetSize = CGSizeZero;
    if (originalSize.width <= DA_MIN_UPLOAD_SIZE.width && originalSize.height <= DA_MIN_UPLOAD_SIZE.height) {
        targetSize = originalSize;
    }
    else {
        float originalFactor = originalSize.width / originalSize.height;
        float standardFactor = DA_MIN_UPLOAD_SIZE.width / DA_MIN_UPLOAD_SIZE.height;
        if (originalFactor > standardFactor) {
            targetSize.width = DA_MIN_UPLOAD_SIZE.width;
            targetSize.height = targetSize.width / originalFactor;
        }
        else {
            targetSize.height = DA_MIN_UPLOAD_SIZE.height;
            targetSize.width = targetSize.height * originalFactor;
        }
    }
    
    if (!CGSizeEqualToSize(originalSize, targetSize)) {
        image = [self da_scaleDown:image withSize:targetSize];
    }
    
    //We define the max size to compress to
    int MAX_UPLOAD_SIZE = DA_MAX_UPLOAD_SIZE;
    
    //Compression settings
    CGFloat compression = ratio;
    CGFloat maxCompression = maxRatio;
    
    //We loop into the image data to compress accordingly to the compression ratio
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > MAX_UPLOAD_SIZE && compression > maxCompression) {
        compression -= 0.10;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    //Retuns the compressed image data
    return imageData;
}

+ (UIImage*)da_scaleDown:(UIImage*)image withSize:(CGSize)newSize
{
    CGFloat scale = [UIScreen mainScreen].scale;
    newSize.width = newSize.width / scale;
    newSize.height = newSize.height / scale;
    
    //We prepare a bitmap with the new size
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
    
    //Draws a rect for the image
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    //We set the scaled image from the context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
