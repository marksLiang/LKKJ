//
//  MyCollectModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyCollectModel: NSObject {
    var goods_like: [CollectModel]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goods_like":CollectModel.self]
    }
}

class CollectModel: NSObject {
    var likeid = ""
    var addtime = ""
    var goodsinfo:index_goodsList?
}

