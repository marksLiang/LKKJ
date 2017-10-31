//
//  MyOder.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/25.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOder: CustomTemplateViewController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate let identifier = "MyOderCell"
    //按钮条
    fileprivate lazy var buttonBar: LYFButtonBar = {
        let buttonBar = LYFButtonBar.init(frame: CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: 40), font:UIFont.systemFont(ofSize: 13),normalColor: UIColor.black, selectColor: CommonFunction.SystemColor(), textArray: ["全部订单","待付款","待发货","待收货","待评价"], Callback_SelectedValue: {[weak self] (buttontag) in
            
        })
        return buttonBar
    }()
    //MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyOderCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CommonFunction.ViewControllerWithStoryboardName("MyOderDetails", Identifier: "MyOderDetails")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
        self.initUI()
    }
    
    //MARK: initUI
    private func initUI()->Void{
        self.view.addSubview(buttonBar)
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight + 40, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight - 40)
        self.numberOfRowsInSection = 10
        self.numberOfSections = 1
        self.tableViewheightForRowAt = 110
    }
}

