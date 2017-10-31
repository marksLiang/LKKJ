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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的收藏"
        self.inituI()
    }
    //MARK: tableDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyCollectCell
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    //MARK: initUI
    private func inituI()->Void{
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight , width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight )
        self.tableView.backgroundColor = UIColor().TransferStringToColor("#EEEEEE")
        self.numberOfRowsInSection = 4
        self.numberOfSections = 1
        self.tableViewheightForRowAt = 120
    }

}
