//
//  HomeViewModel.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/27.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HomeViewModel {
    var model = HomeModel()
    
    func GetHomeModel(result:((_ result:Bool?) -> Void)?) {
        CommonFunction.Global_Post(entity: HomeModel(), IsListData: false, url: HttpsUrl+"index.php/", isHUD: false, isHUDMake: false, parameters: nil) { (resultModel) in
            if resultModel?.status == 200 {
                if resultModel?.data == nil {
                    return
                }
                self.model = resultModel?.data as! HomeModel
                result?(true)
            }else{
                result?(false)
            }
        }
    }
}
