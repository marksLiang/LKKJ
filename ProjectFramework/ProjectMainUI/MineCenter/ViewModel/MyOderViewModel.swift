//
//  MyOderViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOderViewModel {
    var oderDetailsModel = MyOderDetailsModel()
    func submitOder(accepterid: String, goodsArr: String, reslut:@escaping ((Bool) -> Void)) {
        CommonFunction.Global_Post(entity: MyOderDetailsModel(), IsListData: false, url: HttpsUrl + "index.php/Buy/orderlist_add", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "accepterid": accepterid, "goodsArr": goodsArr]) { (resultModel) in
            if resultModel?.status == 200 {
                self.oderDetailsModel = resultModel?.data as! MyOderDetailsModel
                MBProgressHUD.lk_showSuccess(status: "订单添加成功")
                reslut(true)
            } else {
                MBProgressHUD.lk_showSuccess(status: resultModel?.msg ?? "订单添加失败")
                reslut(false)
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
