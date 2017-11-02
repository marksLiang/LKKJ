//
//  MyMessgae.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyMessgae: CustomTemplateViewController {
    //按钮条
    fileprivate lazy var buttonBar: LYFButtonBar = {
        let buttonBar = LYFButtonBar.init(frame: CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: 40), font:UIFont.systemFont(ofSize: 13),normalColor: UIColor.black, selectColor: CommonFunction.SystemColor(), textArray: ["通知","系统消息"], Callback_SelectedValue: {[weak self] (buttontag) in
            
        })
        return buttonBar
    }()
    @IBOutlet weak var tableView: UITableView!
    /********************  属性  ********************/
    fileprivate let identifier = "MyMessageCell"
    fileprivate let viewModel = MyMessageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的消息"
        self.initUI()
        self.getMessage()
    }
    private func getMessage() {
        viewModel.getMyMessage { (result) in
            if result {
                self.numberOfRowsInSection = self.viewModel.model.message?.count ?? 0
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)
            } else {
                self.RefreshRequest(isLoading: false, isHiddenFooter: false, isLoadError: true)
            }
        }
    }
    
    //MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyMessageCell
        
        let models = self.viewModel.model.message
        if models?.count != 0 {
            let model = models![indexPath.row]
            cell.messageTitle.text = model.title
            cell.massageContent.text = model.content
            cell.messageTime.text = model.addtime.CompareCurretTime()
        }
        
        return cell
    }
    //MARK: initUI
    private func initUI()->Void{
        let line = UIView.init(frame: CGRect.init(x: CommonFunction.kScreenWidth/2, y: 4, width: 0.5, height: 30))
        line.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(buttonBar)
        self.buttonBar.addSubview(line)
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight + 40, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight - 40)
        self.numberOfSections = 1
        self.tableViewheightForRowAt = 120
    }

}
