//
//  GoodsCarModel.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/21.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodsCarModel: NSObject {
    var goods_car:[CarModel]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goods_car":CarModel.self]
    }
}

class CarModel: NSObject {
    var carid = ""
    var userid = ""
    var goodsid = ""
    var count = ""
    var goodsinfo:index_goodsList?
    var isSelected = false
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goodsinfo":index_goodsList.self]
    }
}
