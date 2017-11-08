//
//  MyCollect.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyCollect: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let identifier = "MyCollectCell"
    fileprivate  var viewModel = MyCollectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的收藏"
        self.inituI()
        self.getCollectionList()
    }
    
    private func getCollectionList() {
        viewModel.fetchColletionList { (result) in
            if result {
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: false)
            } else {
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    
    //MARK: tableDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyCollectCell
        let model = viewModel.model.goods_like![indexPath.row]
        
        cell.mainImage.ImageLoad(PostUrl: (model.goodsinfo?.goodspic)!)
        cell.goodsTitle.text = model.goodsinfo?.title
        cell.goodsPrice.text = model.goodsinfo?.price
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.model.goods_like?.count ?? 0
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = viewModel.model.goods_like![indexPath.row]
            self.lk_showLoadingIndicator(status: "删除中", autoHide: false)
            GoodsDetailViewModel.collet(collet: .delete, goodsid: (model.goodsinfo?.goodsid)!, reslut: { (result) in
                self.lk_hideLoadingIndicator()
                if result {
                    tableView.performBatchUpdatesBlock({
                        self.viewModel.model.goods_like?.remove(at: (self.viewModel.model.goods_like?.index(of: model))!)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }, completion: { (_) in
                        MBProgressHUD.lk_showSuccess(status: "删除成功")
                        tableView.reloadVisibleRows(with: .top)
                    })
                } else {
                    MBProgressHUD.lk_showSuccess(status: "删除失败")
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("GoodsDetails", Identifier: "GoodsDetails") as! GoodsDetails
        let model = viewModel.model.goods_like![indexPath.row]
        vc.model = model.goodsinfo
        self.navigationController?.show(vc, sender: self)
    }
    
    //MARK: initUI
    private func inituI()->Void{
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight , width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight )
        self.tableView.backgroundColor = UIColor().TransferStringToColor("#EEEEEE")
        self.numberOfSections = 1
        self.tableViewheightForRowAt = 120
    }

}
