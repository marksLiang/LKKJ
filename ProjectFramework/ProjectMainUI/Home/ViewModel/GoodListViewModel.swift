//
//  GoodListViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/31.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodListViewModel {
    var model = GoodListModel()
    
    func getGoodList(typeid: String = "", search: String = "", select: String = "", result:((_ result:Bool?) -> Void)?) {
        CommonFunction.Global_Post(entity: GoodListModel(), IsListData: false, url: HttpsUrl + "index.php/Goods/index", isHUD: false, isHUDMake: false, parameters: ["typeid": typeid, "search": search, "select": select]) { (resultModel) in
            if resultModel?.status == 200 {
                if resultModel?.data == nil {
                    return
                }
                self.model = resultModel?.data as! GoodListModel
                result?(true)
            }else{
                result?(false)
            }
        }
    }
}
