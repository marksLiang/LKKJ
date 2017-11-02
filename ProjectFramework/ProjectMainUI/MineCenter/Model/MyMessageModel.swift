//
//  MyMessageModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/2.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyMessageModel: NSObject {
    var message: [MessageModel]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["message":MessageModel.self]
    }
}

class MessageModel: NSObject {
    var noticeid = ""
    var userid = ""
    var title = ""
    var content = ""
    var addtime = ""
    var ischeck = ""
    var state = ""
}
