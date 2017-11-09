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
    class func changeUserInfomation(_ nickname: String, _ phone: String, _ sex: String, _ userpic: Data, reslut: @escaping (Bool) -> ()) {
        let params = ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "nickname": nickname, "phone": phone, "sex": sex]
        
        AFNHelper.upload(HttpsUrl + "index.php/Personal/save", parameters: params as NSDictionary, constructingBodyWithBlock: { (formatData) in
            
            formatData.appendPart(withFileData: userpic, name: "userpic", fileName: "image.jpg", mimeType: "image/jpeg")
        }, uploadProgress: { (progress) in
        }, success: { (success) in
            MBProgressHUD.lk_showSuccess(status: "修改成功")
            reslut(true)
        }) { (failure) in
            MBProgressHUD.lk_showError(status: "修改失败")
            reslut(false)
        }
    }
    
    class func changeLoginPassword(_ password: String, _ new_pwd: String, _ check_pwd: String, result:@escaping ((Bool)->())) {
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Personal/save_pwd", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token, "password": password, "new_pwd": new_pwd, "check_pwd": check_pwd]) { (resultModel) in
            if resultModel?.status == 200 {
                MBProgressHUD.lk_showSuccess(status: resultModel?.msg ?? "修改成功")
                result(true)
            } else {
                MBProgressHUD.lk_showError(status: resultModel?.msg ?? "修改失败")
                result(false)
            }
        }
    }
}
