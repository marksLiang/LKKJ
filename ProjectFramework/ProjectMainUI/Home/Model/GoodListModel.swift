//
//  GoodListModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/31.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodListModel: NSObject {
    var goods_list: [GoodsModel]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goods_list":GoodsModel.self]
    }
}

class GoodsModel: NSObject {
    var goodsid = ""
    var tilte = ""
    var goodspic = ""
    var infopic = ""
    var content = ""
    var goodstype = ""
    var cashtype = ""
    var old_price = ""
    var price = ""
    var sold_out = ""
    var inventory = ""
    var credit = ""
}
