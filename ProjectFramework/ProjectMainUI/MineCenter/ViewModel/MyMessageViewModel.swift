//
//  MyMessageViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/2.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyMessageViewModel {
    var model = MyMessageModel()
    
    func getMyMessage(result: @escaping (_ result: Bool) -> Void) {
        CommonFunction.Global_Post(entity: MyMessageModel(), IsListData: false, url: HttpsUrl + "index.php/Personal/message", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token]) { (resultModel) in
            if resultModel?.status == 200 {
                self.model = resultModel?.data as! MyMessageModel
                result(true)
            } else {
                result(false)
            }
        }
    }
    
}
