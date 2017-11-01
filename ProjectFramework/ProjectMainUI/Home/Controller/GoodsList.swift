//
//  GoodsList.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/25.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodsList: CustomTemplateViewController {

    @IBOutlet weak var tableView: UITableView!
    /********************  属性  ********************/
    var typeid: String?
    var search: String?
    
    fileprivate let sortType = ["信用从高到低", "价格从高到低", "价格从低到高", "售量从高到低"]
    fileprivate var Menuview:MenuView?  = nil
    fileprivate let identifier = "GoodsListCell"
    fileprivate let viewModel = GoodListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgationBar()
        self.initUI()
        self.setMenuView()
        self.getHttpData(typeid: self.typeid ?? "", search: self.search ?? "")
    }
    
    // MARK: - 获取数据
    fileprivate func getHttpData(typeid: String = "", select: String = "", search: String = "") {
        viewModel.getGoodList(typeid: typeid, search: search, select:select) { (result) in
            if result == true {
                self.numberOfSections = 1
                self.numberOfRowsInSection = self.viewModel.model.goods_list!.count
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)
            } else {
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
                CommonFunction.HUD("请求错误", type: .error)
            }
        }
    }
    
    //MARK: 设置导航栏
    private func setNavgationBar()->Void{
        self.navigationItem.titleView=UIButton().SearchBtn(target: self,actionEvent: #selector(SearchEvent), placeholder: "请输入搜索的商品")
    }
    //MARK: 搜索事件
    func SearchEvent(){
        debugPrint("点击搜索")
        let searchViewController                 =   PYSearchViewController(hotSearches: nil, searchBarPlaceholder: "请输入搜索的商品")
        searchViewController?.hotSearchStyle     = .default
        searchViewController?.searchHistoryStyle = .normalTag
        searchViewController?.delegate=self
        let nav =  CYLBaseNavigationController (rootViewController: searchViewController!)
        self.present(nav, animated: false, completion: nil)
    }
    //MARK: 设置才筛选栏
    private func setMenuView()->Void{
        Menuview=MenuView(delegate: self, frame:  CGRect(x: 0, y: CommonFunction.NavigationControllerHeight, width: self.view.frame.width, height: 35))
        self.view.addSubview(Menuview!)
        
        let model1       = MenuModel()
        for i:Int in 0..<4 {
            let onemol   = OneMenuModel()
            onemol.type  = 1
            onemol.name  = "全部"
            onemol.value = i.description
            model1.OneMenu.append(onemol)
        }
        
        let model2       = MenuModel()
        for  i:Int in 0..<self.sortType.count {
            let onemol   = OneMenuModel()
            onemol.type  = 2
            onemol.name  = self.sortType[i]
            onemol.value = (i + 1).description
            model2.OneMenu.append(onemol)
        }
        Menuview?.AddMenuData(model1)
        Menuview?.AddMenuData(model2)
        Menuview?.Callback_SelectedValue { (name, value,type) in
            print(name)
            if type == 1 {
                
            } else {
                self.getHttpData(select: "\(value)")
            }
        }
        Menuview?.menureloadData()
    }
    //MARK: initUI
    private func initUI()->Void{
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight+35, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight - 35)
        self.tableViewheightForRowAt = 120
    }
    
    //MARK: - UITableViewDelegate & UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! GoodsListCell
        let model = self.viewModel.model.goods_list![indexPath.row]
        cell.goodspicImageView.ImageLoad(PostUrl: model.goodspic)
        cell.contentLabel.text = model.content
        cell.priceLabel.text = model.price
        cell.sold_outLabel.text = model.sold_out
        return cell
    }
}
extension GoodsList: SDCycleScrollViewDelegate,PYSearchViewControllerDelegate {
    //MARK: 轮播图代理
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        debugPrint(index)
    }
    //PYSearchViewControllerDelegate 搜索时调用
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWithsearchBar searchBar: UISearchBar!, searchText: String!) {
        searchViewController.dismiss(animated: false) {
            self.getHttpData(search: searchText)
        }
    }
}
