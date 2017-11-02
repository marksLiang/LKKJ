//
//  MineCenter.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MineCenter: UIViewController {
    ///UITableView
    fileprivate lazy var tableView:UITableView = {
        var _frame=self.view.frame
        _frame.origin.y -= CommonFunction.StatusBarHeight
        _frame.size.height += CommonFunction.StatusBarHeight
        let tabview=UITableView(frame: _frame, style: .plain)
        tabview.delegate=self //设置代理
        tabview.dataSource=self
        tabview.tableFooterView=UIView() //去除多余底部线条
        return tabview
    }()
    
    fileprivate let identifier="MyCell"
    fileprivate let _MyHeadUIView=MyHeadUIView()
    fileprivate var ImageList = ["Order","shop","information","myaddress","myCollction","mysetting","contact","Exit"]
    fileprivate var TitleList = ["我的订单","我的店铺","我的消息","我的地址","我的收藏","系统设置","联系客服","安全退出"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人中心"
        // Do any additional setup after loading the view.
        self.initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if(Global_UserInfo.IsLogin==true){
            self._MyHeadUIView.Imgbtn?.ImageLoad(PostUrl: HttpsUrlImage+Global_UserInfo.ImagePath)
            self._MyHeadUIView.LabName.text = Global_UserInfo.nickname
        }else{
            self._MyHeadUIView.Imgbtn?.image = UIImage.init(named: "userIcon_defualt")
        }
    }
    private func initUI()->Void{
        self.view.backgroundColor = CommonFunction.RGBA(239, g: 191, b: 133, a: 1)
        self.tableView.backgroundColor = UIColor.clear
        tableView.register(MyCell.self, forCellReuseIdentifier: identifier)
        self.view.addSubview(tableView)
        _ = _MyHeadUIView._layer(tableHeaderView: tableView, target: self, selector: #selector(UserInfoEdit))
    }
    ///用户信息
    func UserInfoEdit(){
        if Global_UserInfo.IsLogin {
            let vc = CommonFunction.ViewControllerWithStoryboardName("MyInfomation", Identifier: "MyInfomation") as! MyInfomation
            self.navigationController?.show(vc, sender: self)
        } else {
            let vc = LoginViewControllerTwo()
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}
extension MineCenter:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommonFunction.kScreenHeight-200
    }
    
    //返回节的个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //返回某个节中的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //为表视图单元格提供数据，该方法是必须实现的方法
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyCell
        cell.accessoryType = UITableViewCellAccessoryType.none
        cell.selectionStyle = .none
        cell._InitConfig(ImageList,TitleList)
        cell.FuncCallbackValue { [weak self] (button)in
            switch button.tag {
            //我的订单
            case 100:
                let vc = CommonFunction.ViewControllerWithStoryboardName("MyOder", Identifier: "MyOder") as! MyOder
                self?.navigationController?.show(vc, sender: self)
                break;
            case 102:
                let vc = CommonFunction.ViewControllerWithStoryboardName("MyMessgae", Identifier: "MyMessgae") as! MyMessgae
                self?.navigationController?.show(vc, sender: self)
                break;
            case 103:
                let vc = CommonFunction.ViewControllerWithStoryboardName("MyAdress", Identifier: "MyAdress") as! MyAdress
                self?.navigationController?.show(vc, sender: self)
                break;
            case 104:
                let vc = CommonFunction.ViewControllerWithStoryboardName("MyCollect", Identifier: "MyCollect") as! MyCollect
                self?.navigationController?.show(vc, sender: self)
                break;
            case 105:
                let vc = CommonFunction.ViewControllerWithStoryboardName("MySetting", Identifier: "MySetting") as! MySetting
                self?.navigationController?.show(vc, sender: self)
                
                break;
            default:
                break;
            }
        }
        return cell
    }
}

