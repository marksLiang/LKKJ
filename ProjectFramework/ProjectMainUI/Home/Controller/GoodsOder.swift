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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        getAdress()
    }
    
    @objc fileprivate func submitButtonEvent() {
        print(#function)
    }
    
    private func getAdress() {
        viewModel.getMyAdress { (result) in
            if result {
                var address: AdressModel? = nil
                for addr in self.viewModel.model.address! {
                    if addr.state == "1" {
                        address = addr
                        break
                    }
                }
                guard let defaultAddress = address else {
                    return
                }
                let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! GoodsOderAdressCell
                cell.nameLabel.text = defaultAddress.name
                cell.phoneLabel.text = defaultAddress.phone
                cell.addressLabel.text = defaultAddress.address
            }
            
        }
    }
}

// MARK: - Table view data source & delegate
extension GoodsOder {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 100 : 160
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
            cell.discountsLabel.text = "已优惠：¥\(discounts)"
            cell.numberLabel.text = "数量：\(goodsNumber)"
            cell.submitButton.layer.cornerRadius = 2.0
            cell.submitButton.layer.borderWidth = 0.5
            cell.submitButton.layer.borderColor = CommonFunction.SystemColor().cgColor
            cell.submitButton.addTarget(self, action: #selector(submitButtonEvent), for: .touchUpInside)
            return cell
        }
    }
}
