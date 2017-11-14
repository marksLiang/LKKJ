//
//  LKNotification.swift
//  LKNetworkTest
//
//  Created by Jinjun liang on 2017/11/10.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit

let LKUserDidLoginNotification = "LKUserDidLoginNotification"
let LKUserDidLogoutNotification = "LKUserDidLogoutNotification"

class LKNotification: NSObject {
    
    /// 发送通知
    ///
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: object
    ///   - userInfo: userInfo
    class func post(name: String, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(name), object: object, userInfo: userInfo)
    }
    
    /// 注册通知
    ///
    /// - Parameters:
    ///   - observer: 监听者
    ///   - aSelector: 事件
    ///   - aName: 通知名称
    ///   - anObject: anObject
    class func addObserver(_ observer: Any, selector aSelector: Selector, name aName: String, object anObject: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: NSNotification.Name.init(aName), object: anObject)
    }
    
    /// 注销通知
    ///
    /// - Parameters:
    ///   - observer: 监听者
    ///   - aName: 通知名称
    ///   - anObject: anObject
    class func remove(_ observer: Any, name aName: NSNotification.Name?, object anObject: Any?) {
        NotificationCenter.default.removeObserver(observer, name: aName, object: anObject)
    }
    
    class func remove(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}
