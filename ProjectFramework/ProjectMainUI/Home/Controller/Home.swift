//
//  Home.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class Home: CustomTemplateViewController {
    /********************  XIB属性  ********************/
    @IBOutlet weak var tableView: UITableView!
    /********************  懒加载  ********************/
    fileprivate let identiFier1 = "HomeFirstCell"
    fileprivate let identiFier2 = "HomeSecondCell"
    fileprivate let identiFier3 = "HomeGoodsCell"
    fileprivate let sectionText = ["热门商品"]
    fileprivate var viewModel = HomeViewModel()
    fileprivate var imageList = [String]()
    //tableView头部
    fileprivate lazy var headerView: HomeHeaderView = {
        let headerView = HomeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 305))
//        headerView.isHidden = true
        headerView.selectCallbackValue {[weak self] (row) in
            let vc = CommonFunction.ViewControllerWithStoryboardName("GoodsList", Identifier: "GoodsList") as! GoodsList
            vc.typeid = self?.viewModel.model.index_type![row].typeid
            self?.navigationController?.show(vc, sender: self)
        }
        return headerView
    }()
    //轮播图
    fileprivate lazy var shuffling: SDCycleScrollView = {
        let shuffling = SDCycleScrollView(frame:CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 150),delegate:self ,placeholderImage:UIImage.init(named: "placeholder"))
        shuffling?.pageDotColor = UIColor.white
        shuffling?.currentPageDotColor = CommonFunction.SystemColor()
        return shuffling!
    }()
    //MARK: viewload
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgationBar()
        self.getHttpData()
        self.initUI()
    }
    //MARK: 刷新
    override func headerRefresh() {
        getHttpData()
    }
    override func Error_Click() {
        getHttpData()
    }
    //MARK: 获取数据
    func getHttpData() -> Void {
        self.imageList.removeAll()
        viewModel.GetHomeModel { (result) in
            self.header.endRefreshing()
            if result == true {
                for model in self.viewModel.model.index_adv! {
                    self.imageList.append(model.advpic)
                }
                self.shuffling.imageURLStringsGroup = self.imageList
                self.numberOfSections = 1
                self.numberOfRowsInSection = (self.viewModel.model.index_goods?.count)!
                self.headerView.isHidden = false
                self.headerView.dataList = self.viewModel.model.index_type
                self.headerView.collectionView.reloadData()
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                
            }else{
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    //MARK: tableViewDelegate
    
    //组头
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return (self.viewModel.model.index_goods?.count)! > 0 ? self.setSection(text: sectionText[section]) : UIView()
    }
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return (self.viewModel.model.index_goods?.count)! > 0 ? 45 : 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier3, for: indexPath) as! HomeGoodsCell
        cell.InitConfig(self.viewModel.model.index_goods![indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("GoodsDetail", Identifier: "GoodsDetail") as! GoodsDetail
        vc.model = self.viewModel.model.index_goods![indexPath.row]
        self.navigationController?.show(vc, sender: self)
    }
    //MARK: initUI
    private func initUI()->Void{
        self.headerView.addSubview(shuffling)
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight - 49)
        self.tableViewheightForRowAt = 90
        self.headerView.isHidden = true
        self.tableView.tableHeaderView = headerView
        
    }
    //MARK: setNavgationBar
    private func setNavgationBar() -> Void {
        
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(image: UIImage.init(named: "scanning"), style: .done, target: self, action: #selector(self.leftButtonItem))
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage.init(named: "icon_information"), style: .done, target: self, action: #selector(self.righButtonItem))
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
    //MARK: 扫描
    func leftButtonItem (){
        ///需要真机调试
        let vc = QQScanViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: 消息
    func righButtonItem (){
        debugPrint("点击消息")
    }
    //MARK: 返回组头
    private func setSection(text:String )->UIView{
        let sectionHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 45))
        sectionHeader.backgroundColor = UIColor.white
        for i in 0..<2 {
            let line = UILabel.init(frame: CGRect.init(x: CGFloat(i)*(CommonFunction.kScreenWidth/2 + 50), y: 22, width: CommonFunction.kScreenWidth/2 - 50, height: 1))
            line.backgroundColor = CommonFunction.SystemColor()
            sectionHeader.addSubview(line)
        }
        
        let sectioLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 75, height: 25))
        sectioLable.center = sectionHeader.center
        sectioLable.layer.borderWidth = 0.5
        sectioLable.layer.borderColor = UIColor().TransferStringToColor(CommonFunction.SystemColor()).cgColor
        sectioLable.textAlignment = .center
        sectioLable.font = UIFont.systemFont(ofSize: 13)
        sectioLable.text = text
        sectionHeader.addSubview(sectioLable)
        return sectionHeader
    }

}
extension Home: SDCycleScrollViewDelegate,PYSearchViewControllerDelegate {
    //MARK: 轮播图代理
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        debugPrint(index)
    }
    //PYSearchViewControllerDelegate 搜索时调用
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWithsearchBar searchBar: UISearchBar!, searchText: String!) {
        searchViewController.dismiss(animated: false) {
            let vc = CommonFunction.ViewControllerWithStoryboardName("GoodsList", Identifier: "GoodsList") as! GoodsList
            vc.search = searchText
            self.navigationController?.show(vc, sender: self)
        }
    }
}
