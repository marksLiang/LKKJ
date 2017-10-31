//
//  ClassModel.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/31.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class ClassModel:NSObject{
    var goodsType:[goodsTypeLsit]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goodsType":goodsTypeLsit.self]
    }
}
//一级分类
class goodsTypeLsit: NSObject{
    var typeid=""
    var typename=""
    var typepic=""
    var second_type:[second_typeList]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["second_type":second_typeList.self]
    }
}
//二级分类
class second_typeList:NSObject {
    var typeid=""
    var typename=""
    var typepic=""
    var third_type:[third_typeList]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["third_type":third_typeList.self]
    }
}
//三级分类
class third_typeList: NSObject {
    var typeid=""
    var typename=""
    var typepic=""
}
