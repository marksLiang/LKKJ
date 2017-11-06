//
//  GoodsDetailViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/31.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

enum GooodsCollection {
    case add
    case delete
    case status
}

class GoodsDetailViewModel: NSObject {
    
    /// 收藏相关
    ///
    /// - Parameters:
    ///   - collet: 是否已收藏、添加收藏、取消收藏
    ///   - goodsid: 商品id
    ///   - reslut: 回调
    class func collet(collet: GooodsCollection, goodsid: String, reslut: @escaping (_ reslut: Bool)->()) {
        var urlPath = ""
        let params = ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "goodsid": goodsid]
        switch collet {
            case .status:
                urlPath = "index.php/Goods/detail"
            case .add:
                urlPath = "index.php/Personal/addlike"
            case .delete:
                urlPath = "index.php/Personal/deletelike"
        }
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + urlPath, isHUD: false, isHUDMake: false, parameters: params as NSDictionary) { (resultModel) in
            if resultModel?.status == 200 {
                reslut(true)
            } else {
                reslut(false)
            }
        }
    }
    
    /// 添加购物车
    ///
    /// - Parameters:
    ///   - goodsid: 商品id
    ///   - count: 数量
    class func addGoodsCar(goodsid: String, count: Int) {
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Car/add", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "goodsid": goodsid, "count": count]) { (resultModel) in
            if resultModel?.status == 200 {
                MBProgressHUD.lk_showSuccess(status: resultModel?.msg ?? "添加到购物车成功")
                CommonFunction.Instance.isNeedRefreshShoppingCar = true
            } else {
                MBProgressHUD.lk_showError(status: resultModel?.msg ?? "收藏失败")
            }
        }
    }
    
}
