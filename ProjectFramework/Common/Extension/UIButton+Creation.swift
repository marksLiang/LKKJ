//
//  UIButton+Creation.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 创建文本按钮
    ///
    /// - Parameters:
    ///   - title: 标题文字
    ///   - fontSize: 字体大小
    ///   - normalColor: 默认字体颜色
    ///   - heightlightedColor: 高亮字体颜色
    /// - Returns: 实例
    class func lk_textButton(title: String, fontSize: CGFloat, normalColor: UIColor, heightlightedColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(heightlightedColor, for: .highlighted)
        return button
    }
    
    /// 创建文本按钮
    ///
    /// - Parameters:
    ///   - title: 标题文字
    ///   - fontSize: 字体大小
    ///   - normalColor: 默认字体颜色
    ///   - heightlightedColor: 高亮字体颜色
    ///   - backgrounImageName: 背景图片
    /// - Returns: 实例
    class func lk_textButton(_ title: String, fontSize: CGFloat, normalColor: UIColor, heightlightedColor: UIColor, backgrounImageName: String) -> UIButton {
        let button = UIButton.lk_textButton(title: title, fontSize: fontSize, normalColor: normalColor, heightlightedColor: heightlightedColor)
        button.setBackgroundImage(UIImage(named: backgrounImageName), for: .normal)
        return button
    }
}

