//
//  MySetting.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/26.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MySetting: MyInfomationBase {
    
    fileprivate let titles = ["清理缓存", "关于我们", "意见反馈"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = nil
        self.tableView.separatorStyle = .singleLine
    }
}

// MARK: - Table view data source & delegate
extension MySetting {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MySettingCell", for: indexPath)
        
        cell.textLabel?.text = titles[indexPath.row]
        if indexPath.row == 0 {
            cell.accessoryType = .none
            cell.detailTextLabel?.text = "9.9M"
            
        } else {
           cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
