//
//  ShoppingCarViewModel.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/1.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ShoppingCarViewModel {
    var model = GoodsCarModel()
    func getGoodsCarList(result:@escaping (_ result: Bool ,_ istokenValid: Bool)->()) {
        CommonFunction.Global_Post(entity: GoodsCarModel(), IsListData: false, url: HttpsUrl + "index.php/Car/index", isHUD: false, isHUDMake: false, parameters: ["userid": Global_UserInfo.userid, "token": Global_UserInfo.token]) { (resultModel) in
            debugPrint(Global_UserInfo.userid,Global_UserInfo.token)
            if resultModel?.status == 200 {
                self.model = resultModel?.data as! GoodsCarModel
                result(true,true)
            } else {
                CommonFunction.HUD((resultModel?.msg) ?? "请求错误", type: .error)
                if resultModel?.status == 501 {
                    result(true,true)
                }
                if  resultModel?.status == 502 {
                    result(true,false)
                }
                result(false,true)
            }
        }
    }
    func setCarUpdate(_ userid:Int,_ token:String , goodsid:Int ,count:Int,_ result:((_ result:Bool?) -> Void)?) {
        let parameters = ["userid":Global_UserInfo.userid,"token":token,"goodsid":goodsid,"count":count] as [String : Any]
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl+"/index.php/Car/update", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if resultModel?.status == 200 {
                debugPrint("修改成功")
            }else{
                debugPrint("修改失败")
            }
        }
    }
    func deleteCar(goodsid:String) -> Void {
        let parameters = ["userid":Global_UserInfo.userid,"token":Global_UserInfo.token,"goodsid":goodsid]
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl+"/index.php/Car/delete", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            
            if resultModel?.status == 200 {
                debugPrint("删除成功")
            }else{
                debugPrint("删除失败")
            }
        }
    }
}
