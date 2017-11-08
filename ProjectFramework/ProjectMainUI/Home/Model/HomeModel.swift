//
//  HomeModel.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/27.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HomeModel: NSObject {
    var index_adv:[index_advList]?
    var index_type:[index_typeList]?
    var index_goods:[index_goodsList]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["index_adv":index_advList.self,"index_type":index_typeList.self,"index_goods":index_goodsList.self]
    }
}
//首页轮播
class index_advList: NSObject {
    var advid = ""
    var advpic=""
    var shouye=""
    var guanggaoye=""
    var addtime=""
    var adminid=""
    var state=""
}
//菜单
class index_typeList: NSObject {
    var typeid=""
    var typename=""
    var second=""
    var third=""
    var state=""
    var typepic=""
}
//商品
class index_goodsList: NSObject {
    var goodsid = ""
    var title = ""
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
