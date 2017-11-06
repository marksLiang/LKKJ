//
//  MyOderViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOderViewModel {
    
    class func submitOder(accepterid: String, goodsArr: String) {
        
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Buy/orderlist_add", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "accepterid": accepterid, "goodsArr": goodsArr]) { (result) in
            if result?.status == 200 {
                MBProgressHUD.lk_showSuccess(status: "订单添加成功")
            } else {
                MBProgressHUD.lk_showSuccess(status: result?.msg ?? "订单添加失败")
            }
        }
    }
    var oderListModel = MyOderListModel()
    
    func fetchOderList(result: @escaping (Bool) -> ()) {
        CommonFunction.Global_Post(entity: MyOderListModel(), IsListData: false, url: HttpsUrl + "index.php/Buy/index", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token]) { (resultModel) in
            if resultModel?.status == 200 {
               self.oderListModel = resultModel?.data as! MyOderListModel
                result(true)
            } else {
                result(false)
            }
        }
    }
}
