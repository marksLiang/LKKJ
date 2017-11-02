//
//  ShoppingCarViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/1.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ShoppingCarViewModel {
    var model = GoodsCarModel()
    func getGoodsCarList(result:@escaping (_ result: Bool)->()) {
        CommonFunction.Global_Post(entity: GoodsCarModel(), IsListData: false, url: HttpsUrl + "index.php/Car/index", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token]) { (resultModel) in
            if resultModel?.status == 200 {
                self.model = resultModel?.data as! GoodsCarModel
                result(true)
            } else {
                CommonFunction.HUD((resultModel?.msg) ?? "请求错误", type: .error)
                result(false)
            }
        }
    }
}
