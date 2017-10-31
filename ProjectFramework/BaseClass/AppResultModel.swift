//
//  File.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 16/10/26.
//  Copyright © 2016年 HCY. All rights reserved.
//

import Foundation


class AppResultModel:NSObject{
    
    ///请求
    var status = 0
    ///返回结果
    var msg:String=""
    ///包体（消息)
    var data:Any?
}
