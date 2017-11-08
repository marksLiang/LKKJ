//
//  MyOderModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOderListModel: NSObject {
    var orderlist: [MyOderModel]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["orderlist":MyOderModel.self]
    }
}

class MyOderModel: NSObject {
    var orderid = ""
    var orderlistid = ""
    var ispay = ""
    var totalprice = ""
    var accepterid = ""
    var addtime = ""
    var accepter: MyOderAddressModel?
    var goodsinfo: [GoodsinfoModel]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goodsinfo":GoodsinfoModel.self]
    }
}

class MyOderAddressModel: NSObject {
    var name = ""
    var phone = ""
    var address = ""
}

class GoodsinfoModel: NSObject {
    var count = ""
    var goodsinfo: index_goodsList?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goodsinfo":index_goodsList.self]
    }
}

/// 订单详情
class MyOderDetailsModel: NSObject {
    var orderlist: OderDetailsModel?
}

class OderDetailsModel: NSObject {
    var orderid = ""
    var ispay = ""
    var orderlistid = ""
    var addtime = ""
    var accepterid = ""
    var name = ""
    var phone = ""
    var address = ""
    var totalprice = ""
}
