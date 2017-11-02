//
//  GoodListModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/31.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodListModel: NSObject {
    var goods_list: [index_goodsList]?
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["goods_list":index_goodsList.self]
    }
}

