//
//  GoodsDetailViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/31.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodsDetailViewModel: NSObject {

    class func collectGooods(goodsid: String, userid: String, token: String) {
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl + "index.php/Goods/detail", isHUD: false, isHUDMake: false, parameters: ["goodsid": goodsid, "userid": userid, "token": token]) { (resultModel) in
            if resultModel?.status == 200 {
                CommonFunction.HUD("收藏成功", type: .success)
            } else {
                let message = resultModel?.msg
                CommonFunction.HUD(message ?? "收藏失败", type: .error)
            }
        }
    }

}
