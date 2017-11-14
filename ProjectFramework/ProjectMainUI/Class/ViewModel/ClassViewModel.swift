//
//  ClassViewModel.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/31.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class ClassViewModel {
    var model = ClassModel()
    func GetGoodsClass(result:((_ result:Bool?) -> Void)?){
        CommonFunction.Global_Post(entity: ClassModel(), IsListData: false, url: HttpsUrl+"index.php/Type/index", isHUD: true, isHUDMake: false, parameters: nil) { (resultModel) in
            
            if resultModel?.status == 200 {
                if resultModel?.data != nil {
                    self.model = resultModel?.data as! ClassModel
                    result?(true)
                }
            }else {
                result?(false)
            }
        }
    }
}
