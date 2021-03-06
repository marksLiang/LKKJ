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
    fileprivate var ImageList = ["Order","information","myaddress","myCollction","mysetting","contact"]
    fileprivate var TitleList = ["我的订单","我的消息","我的地址","我的收藏","系统设置","联系客服"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人中心"
        
        if Global_UserInfo.IsLogin {
            ImageList.append("Exit")
            TitleList.append("安全退出")
        }
        
        self.initUI()

        if(Global_UserInfo.IsLogin==true){
            self._MyHeadUIView.LabName.text = Global_UserInfo.nickname
            self._MyHeadUIView.Imgbtn?.ImageLoad(PostUrl: Global_UserInfo.ImagePath)
        }else{
            self._MyHeadUIView.Imgbtn?.image = UIImage.init(named: "userIcon_defualt")
            self._MyHeadUIView.LabName.text = "登录"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
            vc.changeMineCenterHeader = {
                self._MyHeadUIView.Imgbtn?.ImageLoad(PostUrl: Global_UserInfo.ImagePath)
            }
            self.navigationController?.show(vc, sender: self)
        } else {
            self.Login()
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
                if Global_UserInfo.IsLogin == true {
                    let vc = CommonFunction.ViewControllerWithStoryboardName("MyOder", Identifier: "MyOder") as! MyOder
                    self?.navigationController?.show(vc, sender: self)
                }else{
                    self?.Login()
                }
                break;
            case 101:
                if Global_UserInfo.IsLogin == true {
                    let vc = CommonFunction.ViewControllerWithStoryboardName("MyMessgae", Identifier: "MyMessgae") as! MyMessgae
                    self?.navigationController?.show(vc, sender: self)
                }else{
                    self?.Login()
                }
                break;
            case 102:
                if Global_UserInfo.IsLogin == true {
                    let vc = CommonFunction.ViewControllerWithStoryboardName("MyAdress", Identifier: "MyAdress") as! MyAdress
                    self?.navigationController?.show(vc, sender: self)
                }else{
                    self?.Login()
                }
                break;
            case 103:
                if Global_UserInfo.IsLogin == true {
                    let vc = CommonFunction.ViewControllerWithStoryboardName("MyCollect", Identifier: "MyCollect") as! MyCollect
                    self?.navigationController?.show(vc, sender: self)
                }else{
                    self?.Login()
                }
                
                break;
            case 104:
                let vc = CommonFunction.ViewControllerWithStoryboardName("MySetting", Identifier: "MySetting") as! MySetting
                self?.navigationController?.show(vc, sender: self)
                
                break;
            case 105:
                CommonFunction.CallPhone(self!, number: "15907740425")
                break;
            case 106:
                CommonFunction.AlertController(self!, title: "注销账户", message: "确定注销该账户吗？", ok_name: "确定", cancel_name: "取消", OK_Callback: {
                    //置空数据
                    Global_UserInfo.ImagePath=""
                    Global_UserInfo.phone=""
                    Global_UserInfo.nickname=""
                    Global_UserInfo.sex="不详"
                    Global_UserInfo.userid=""
                    Global_UserInfo.IsLogin=false
                    Global_UserInfo.token=""
                    //登陆成功后 存储到数据库
                    CommonFunction.ExecuteUpdate("update MemberInfo set userid = (?), phone = (?) , token = (?), IsLogin = (?) ,nickname=(?),sex=(?),ImagePath=(?)",
                                                 [Global_UserInfo.userid as AnyObject
                                                    ,Global_UserInfo.phone as AnyObject
                                                    ,Global_UserInfo.token as AnyObject
                                                    ,Global_UserInfo.IsLogin as AnyObject
                                                    ,Global_UserInfo.nickname as AnyObject
                                                    ,Global_UserInfo.sex as AnyObject
                                                    ,Global_UserInfo.ImagePath as AnyObject
                                                    
                        ], callback: nil )
                    //移除数据
                    self?.TitleList.removeLast()
                    self?.ImageList.removeLast()
                    self?.tableView.reloadData()
                    self?._MyHeadUIView.Imgbtn?.image = UIImage.init(named: "userIcon_defualt")
                    self?._MyHeadUIView.LabName.text = "登录"
                    //发送退出通知
                    LKNotification.post(name: LKUserDidLogoutNotification)
                }, Cancel_Callback: nil)
                break;
            default: 
                break;
            }
        }
        return cell
    }
    func Login() -> Void {
        let vc = LoginViewControllerTwo()
        vc.Callback_Value {[weak self] (reuslt) in
            self?.TitleList.append("安全退出")
            self?.ImageList.append("Exit")
            self?.tableView.reloadData()
            self?._MyHeadUIView.LabName.text = Global_UserInfo.nickname
            self?._MyHeadUIView.Imgbtn?.ImageLoad(PostUrl: Global_UserInfo.ImagePath)
        }
        self.present(vc, animated: true, completion: nil)
    }
}

