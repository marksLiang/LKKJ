//
//  UIImageView+Extension.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/15.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView{
    
    /// 图片加载
    ///
    /// - Parameters:
    ///   - ImageView: 图片控件 UIImageView
    ///   - PostUrl: 请求网络URL
    func ImageLoad(PostUrl:String){
        /// 解决有的图片加载不出问题
        SDWebImageDownloader.shared().setValue((PostUrl as NSString).userAgent(), forHTTPHeaderField: "User-Agent")
        
        self.sd_setImage(with:URL(string: PostUrl), placeholderImage:  UIImage(named: placeholderImage) ,options:  SDWebImageOptions.retryFailed) { (UIImage, NSError, SDImageCacheType, NSURL) -> Void in
            if(UIImage != nil){
                self.image=UIImage
            }
        }
    }
     
}
