//
//  GoodsOder.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodsOder: UITableViewController {
    
    var model: index_goodsList?
    var goodsNumber = 1
    fileprivate let viewModel = MyAdressViewModel()
    fileprivate let oderViewModel = MyOderViewModel()
    fileprivate var defaultAddress: AdressModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        getDefaultAddress()
    }
}

// MARK: - Custom Method
extension GoodsOder {
    
    @objc fileprivate func submitButtonEvent() {
        let goodsid = self.model?.goodsid ?? ""
        let goods = [[goodsid: "\(goodsNumber)"] as NSDictionary] as NSArray
        let json = goods.mj_JSONString() ?? ""
        self.lk_showLoadingIndicator(status: "订单生成中")
        oderViewModel.submitOder(accepterid: self.defaultAddress?.accepterid ?? "", goodsArr: json) { (result) in
            self.lk_hideLoadingIndicator()
            if result {
                let vc = CommonFunction.ViewControllerWithStoryboardName("MyOderDetails", Identifier: "MyOderDetails") as! MyOderDetails
                vc.oderModel = self.oderViewModel.oderDetailsModel.orderlist
                vc.goodsModel = self.model
                vc.goodsNumber = self.goodsNumber
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    /// 获取默认地址
    fileprivate func getDefaultAddress() {
        viewModel.getMyAdress { (result) in
            if result {
                for addr in self.viewModel.model.address! {
                    if addr.state == "1" {
                        self.defaultAddress = addr
                        break
                    }
                }
                if self.defaultAddress == nil && (self.viewModel.model.address?.count ?? 0) > 0 {
                    self.defaultAddress = self.viewModel.model.address?.first
                }
                guard let defaultAddress = self.defaultAddress else {
                    let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! GoodsOderAdressCell
                    cell.nameLabel.text = "点击添加收货地址"
                    return
                }
                self.setAddress(address: defaultAddress)
            }
        }
    }
    
    /// 设置地址
    fileprivate func setAddress(address: AdressModel) {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! GoodsOderAdressCell
        cell.nameLabel.text = address.name
        cell.phoneLabel.text = address.phone
        cell.addressLabel.text = address.address
    }
}

// MARK: - Table view data source & delegate
extension GoodsOder {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoodsOderAdressCell", for: indexPath) as! GoodsOderAdressCell
            cell.selectionStyle = .none
            return cell
        } else {
            guard let model = self.model else {
                return UITableViewCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoodsOderCell", for: indexPath) as! GoodsOderCell
            cell.selectionStyle = .none
            cell.goodsImageView.ImageLoad(PostUrl: model.goodspic)
            cell.priceLabel.text = "价格：¥\(model.price)"
            let discounts = Int(model.old_price)! - Int(model.price)!
            cell.discountsLabel.text = "已优惠：¥\(discounts * goodsNumber)"
            cell.numberLabel.text = "数量：\(goodsNumber)"
            cell.submitButton.layer.cornerRadius = 2.0
            cell.submitButton.layer.borderWidth = 0.5
            cell.submitButton.layer.borderColor = CommonFunction.SystemColor().cgColor
            cell.submitButton.addTarget(self, action: #selector(submitButtonEvent), for: .touchUpInside)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 100 : 160
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = CommonFunction.ViewControllerWithStoryboardName("MyAdress", Identifier: "MyAdress") as! MyAdress
            vc.oderAddressSelectedCompletion = { (address) in
                self.defaultAddress = address
                self.setAddress(address: address)
            }
            self.navigationController?.show(vc, sender: self)
        }
    }
}
