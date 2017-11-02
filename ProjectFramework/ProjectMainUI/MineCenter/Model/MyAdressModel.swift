//
//  MyAdressModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/2.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyAdressModel: NSObject {
    var address: [AdressModel]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["address":AdressModel.self]
    }
    
}

class AdressModel: NSObject {
    var accepterid = ""
    var name = ""
    var userid = ""
    var phone = ""
    var address = ""
    var addtime = ""
    var state = ""
}
