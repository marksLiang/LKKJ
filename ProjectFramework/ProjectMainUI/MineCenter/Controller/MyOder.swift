//
//  MyOder.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/25.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

enum MyOderListType {
    case paid
    case obligation
}

class MyOder: CustomTemplateViewController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate let identifier = "MyOderCell"
    fileprivate let viewModel = MyOderViewModel()
    fileprivate var listType: MyOderListType = .obligation
    // 已付款
    fileprivate var paids = [MyOderModel]()
    // 待付款
    fileprivate var obligations = [MyOderModel]()
    
    //按钮条
    fileprivate lazy var buttonBar: LYFButtonBar = {
        let buttonBar = LYFButtonBar.init(frame: CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: 40), font:UIFont.systemFont(ofSize: 13),normalColor: UIColor.black, selectColor: CommonFunction.SystemColor(), textArray: ["待付款","待发货"], Callback_SelectedValue: {[weak self] (buttontag) in
            if buttontag == 0 {
                self?.listType = .obligation
            } else {
                self?.listType = .paid
            }
            if self?.paids.count == 0 || self?.obligations.count == 0 {
                self?.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            } else {
                self?.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: false)
            }
        })
        return buttonBar
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
        self.initUI()
        self.getHttpData()
    }
    
    private func getHttpData() {
        viewModel.fetchOderList { (result) in
            if result {
                
                if self.viewModel.oderListModel.orderlist?.count != 0 {
                    for model in self.viewModel.oderListModel.orderlist! {
                        // 待付款
                        if model.ispay == "0" {
                            self.obligations.append(model)
                        } else {
                            self.paids.append(model)
                        }
                    }
                }
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: false)
            } else {
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    
    //MARK: initUI
    private func initUI()->Void{
        self.view.addSubview(buttonBar)
        self.InitCongif(tableView)
        
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight + 40, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight - 40)
        self.numberOfSections = 1
        self.tableViewheightForRowAt = 110
    }
    
    //MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyOderCell

        let model = self.viewModel.oderListModel.orderlist![indexPath.row]
        let goods = model.goodsinfo?.first
        
        cell.mainImageView.ImageLoad(PostUrl: goods?.goodsinfo?.goodspic ?? "")
        cell.Datetime.text = model.addtime
        cell.goodsName.text = goods?.goodsinfo?.title ?? ""
        cell.goodsCount.text = goods?.count ?? "1"
        cell.goodsPrice.text = goods?.goodsinfo?.price ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = listType == .obligation ? self.obligations[indexPath.row] : self.paids[indexPath.row]
        let vc = CommonFunction.ViewControllerWithStoryboardName("MyOderDetails", Identifier: "MyOderDetails") as! MyOderDetails

        let oderModel = OderDetailsModel()
        oderModel.orderid = model.orderid
        oderModel.ispay = model.ispay
        oderModel.orderlistid = model.orderlistid
        oderModel.addtime = model.addtime
        oderModel.accepterid = model.accepterid
        oderModel.name = model.accepter?.name ?? ""
        oderModel.phone = model.accepter?.phone ?? ""
        oderModel.address = model.accepter?.address ?? ""
        oderModel.totalprice = model.totalprice
        let goodsInfo = model.goodsinfo?.first

        vc.oderModel = oderModel
        vc.goodsModel = goodsInfo?.goodsinfo
        vc.goodsNumber = Int(goodsInfo?.count ?? "0") ?? 1
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listType == .obligation ? self.obligations.count : self.paids.count
    }
}

