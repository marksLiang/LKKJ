//
//  MyInfomationBase.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/24.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyInfomationBase: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bounds = self.view.bounds
        bounds.size.height = 4.0;
        let headerView = UIView(frame: bounds)
        headerView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableHeaderView = headerView
        
        let footerView = UIView(frame: bounds)
        footerView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = footerView

        tableView.separatorStyle = .none
//        tableView.tableFooterView = UIView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(rightBarButtonItemEvent))
    }
    
    func rightBarButtonItemEvent() {
        self.navigationController?.popViewController(animated: true)
    }
}
