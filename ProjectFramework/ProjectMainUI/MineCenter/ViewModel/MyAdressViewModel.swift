//
//  MyAdressViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/2.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyAdressViewModel: NSObject {
    var model = MyAdressModel()
    
    /// 获取收货地址
    ///
    /// - Parameter result: 成功/失败回调
    func getMyAdress(result: @escaping (_ result: Bool)->()) {
        CommonFunction.Global_Post(entity: MyAdressModel(), IsListData: false, url: HttpsUrl + "index.php/Personal/address", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token]) { (resultModel) in
            if resultModel?.status == 200 {
                self.model = resultModel?.data as! MyAdressModel
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    /// 添加收货地址
    class func addAddress(_ name: String, _ phone: String, _ address: String, _ state: String, result: @escaping (_ result: Bool)->()) {
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Personal/add_save", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "name": name, "phone": phone, "address": address, "state": state]) { (resultModel) in
            if resultModel?.status == 200 {
                MBProgressHUD.lk_showSuccess(status: resultModel?.msg ?? "添加成功")
                result(true)
            } else {
                MBProgressHUD.lk_showError(status: resultModel?.msg ?? "添加失败")
                result(false)
            }
        }
    }
    
    /// 修改收货地址
    class func changeAddress(_ accepterid: String, _ name: String, _ phone: String, _ address: String, _ state: String = "0") {
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Personal/update_save", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "name": name, "accepterid": accepterid, "phone": phone, "address": address, "state": state]) { (resultModel) in
            if resultModel?.status == 200 {
                CommonFunction.HUD(resultModel?.msg ?? "修改成功", type: .success)
            } else {
                CommonFunction.HUD(resultModel?.msg ?? "修改失败", type: .error)
            }
        }
    }
    
    /// 删除收货地址
    class func deleteAddress(_ accepterid: String, result: @escaping (_ result: Bool)->()) {
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Personal/delete", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token,"accepterid": accepterid]) { (resultModel) in
            if resultModel?.status == 200 {
                result(true)
            } else {
                result(true)
            }
        }
    }
    
    /// 设为默认地址
    class func setAddressToDefault(_ accepterid: String) {
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Personal/state", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "accepterid": accepterid]) { (resultModel) in
            if resultModel?.status == 200 {
                CommonFunction.HUD(resultModel?.msg ?? "删除成功", type: .success)
            } else {
                CommonFunction.HUD(resultModel?.msg ?? "删除失败", type: .error)
            }
        }
    }
    
}
