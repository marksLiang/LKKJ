//
//  MyInfoModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/1.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class UserInfomationModel: NSObject {
    var personal: UserModel?
}

class UserModel: NSObject {
    var userid = ""
    var username = ""
    var nickname = ""
    var userpic = ""
    var phone = ""
    var sex = ""
}
