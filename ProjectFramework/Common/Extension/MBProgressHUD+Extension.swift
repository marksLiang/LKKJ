//
//  MBProgressHUD+Extension.swift
//  LKFunction
//
//  Created by Jinjun liang on 2017/11/3.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit

fileprivate let lk_hud_autoHideTimeInterval = 1.0

/**
 must be use MBProgressHUD 0.9.1
 */

// MARK: - Create HUD
extension MBProgressHUD {
    
    /// 获取应用Window
    ///
    /// - Returns: UIWindow实例
    fileprivate class func lk_hud_keyWindow() -> UIWindow {
        let app = UIApplication.shared
        var window = UIApplication.shared.keyWindow
        if window != nil {
            return window!
        }
        let delegate = app.delegate
        let selector = #selector(getter: UIApplicationDelegate.window)
        if (delegate?.responds(to: selector))! {
            window = (delegate?.window)!
        }
        return window!
    }
    
    /// 自定义HUD
    ///
    /// - Parameter view: 父视图
    /// - Returns: MBProgressHUD实例
    fileprivate class func lk_hudForView(view: UIView) -> MBProgressHUD {
        let hud = MBProgressHUD.init(view: view)
//        hud?.minSize = CGSize(width: 100.0, height: 100.0 * 0.5)
        hud?.color = UIColor(white: 0.0, alpha: 0.9)
        hud?.cornerRadius = 10.0
        hud?.removeFromSuperViewOnHide = true
        hud?.labelFont = UIFont.preferredFont(forTextStyle: .subheadline)
        view.addSubview(hud!)
        return hud!
    }
}

// MARK: - Success HUD & Error HUD
extension MBProgressHUD {
    class func lk_showSuccess(status: String, toView: UIView? = nil) {
        MBProgressHUD.lk_hud(status: status, icon: "lk_hud_success", toView: toView)
    }
    
    class func lk_showError(status: String, toView: UIView? = nil) {
        MBProgressHUD.lk_hud(status: status, icon: "lk_hud_error", toView: toView)
    }
    
    private class func lk_hud(status: String, icon: String, toView: UIView? = nil) {
        var hud: MBProgressHUD?
        if toView == nil {
            hud = MBProgressHUD.lk_hudForView(view: lk_hud_keyWindow())
        } else {
            hud = MBProgressHUD.showAdded(to: toView, animated: true)
        }
        hud?.lk_customView(icon: icon, status: status)
        hud?.mode = .customView
        hud?.lk_setStatus(status: status)
        hud?.removeFromSuperViewOnHide = true
        hud?.show(true)
        hud?.hide(true, afterDelay: lk_hud_autoHideTimeInterval)
    }
    
    private func lk_customView(icon: String, status: String) {
        let customView = UIImageView(image: UIImage(named: icon))
        self.customView = customView
    }
}

// MARK: - Text HUD
extension MBProgressHUD {
    /// 设置状态提示文本
    ///
    /// - Parameter status: 提示文本
    fileprivate func lk_setStatus(status: String) {
        self.labelFont = UIFont.systemFont(ofSize: 13.0)
        self.labelText = status
    }
    
    /// 显示一个文字提示HUD，显示完成后自动隐藏
    ///
    /// - Parameter status: 提示文本
    class func lk_showStatus(status: String) {
        let hud = MBProgressHUD.lk_hudForView(view: MBProgressHUD.lk_hud_keyWindow())
        hud.mode = .text
        hud.lk_setStatus(status: status)
        hud.show(true)
        hud.hide(true, afterDelay: lk_hud_autoHideTimeInterval)
    }
}

// MARK: - Loading HUD
extension UIViewController {
    
    /// 显示一个等待HUD
    ///
    /// - Parameters:
    ///   - status: 提示文本，默认为nil表示不显示提示文本
    ///   - autoHide: 是否自动隐藏，默认为false表示不自动隐藏
    func lk_showLoadingIndicator(status: String? = nil, autoHide: Bool = false) {
        let hud = MBProgressHUD.lk_hudForView(view: self.view)
        hud.mode = .indeterminate
        if status != nil {
            hud.lk_setStatus(status: status!)
        }
        hud.show(true)
        if autoHide {
            hud.hide(true, afterDelay: lk_hud_autoHideTimeInterval)
        }
        
    }
    
    /// 隐藏等待 HUD
    func lk_hideLoadingIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
