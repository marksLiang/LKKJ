//
//  MyInfoViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/1.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyInfoViewModel: NSObject {
    
    /// 获取用户信息
    ///
    /// - Parameter result: 信息回调
    class func fetchUserInfomation(result:@escaping (_ user: UserModel)->()) {
        CommonFunction.Global_Post(entity: UserInfomationModel(),
                                   IsListData: false,
                                   url: HttpsUrl + "index.php/Personal/setting",
                                   isHUD: false, isHUDMake: false,
                                   parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token]) { (resultModel) in
                                    if resultModel?.status == 200 {
                                        let model = resultModel?.data as! UserInfomationModel
                                        result(model.personal ?? UserModel())
                                    } else {
                                        CommonFunction.HUD(resultModel?.msg ?? "请求错误", type: .error)
                                    }
        }
    }
    /// 修改用户信息
    ///
    /// - Parameters:
    ///   - nickname: 昵称
    ///   - phone: 手机号
    ///   - sex: 性别
    ///   - userpic: 头像
    class func changeUserInfomation(_ nickname: String, _ phone: String, _ sex: String, _ userpic: String) {
        let params = ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "nickname": nickname, "phone": phone, "sex": sex, "userpic": userpic]
        
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Personal/save", isHUD: false, isHUDMake: false, parameters: params as NSDictionary) { (result) in
            
            if result?.status == 200 {
                CommonFunction.HUD(result?.msg ?? "修改成功", type: .success)
                debugPrint(result?.msg ?? "修改成功")
            } else {
                debugPrint(result?.msg ?? "请求错误")
            }
        }
    }
    
    class func changeLoginPassword(_ password: String, _ new_pwd: String, _ check_pwd: String, result:@escaping ((Bool)->())) {
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Personal/save_pwd", isHUD: false, isHUDMake: false, parameters: ["password": password, "new_pwd": new_pwd, "check_pwd": check_pwd]) { (resultModel) in
            if resultModel?.status == 200 {
                CommonFunction.HUD(resultModel?.msg ?? "修改成功", type: .success)
                debugPrint(resultModel?.msg ?? "修改成功")
                result(true)
            } else {
                CommonFunction.HUD(resultModel?.msg ?? "修改失败", type: .success)
                debugPrint(resultModel?.msg ?? "修改失败")
                result(false)
            }
        }
    }
}