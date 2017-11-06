//
//  MyCollectViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyCollectViewModel: NSObject {
    var model = MyCollectModel()
    func fetchColletionList(result: @escaping (Bool)->()) {
        CommonFunction.Global_Post(entity: MyCollectModel(), IsListData: false, url: HttpsUrl + "index.php/Personal/likelist", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token]) { (resultModel) in
            if resultModel?.status == 200 {
                self.model = resultModel?.data  as! MyCollectModel
                result(true)
            } else {
                result(false)
            }
        }
    }
}
