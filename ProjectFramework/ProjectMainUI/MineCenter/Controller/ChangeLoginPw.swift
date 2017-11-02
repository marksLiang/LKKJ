//
//  ChangeLoginPw.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/24.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ChangeLoginPw: MyInfomationBase {
    
    let titles = ["旧密码：", "新密码：", "确认密码："]
    let placeholders = ["请输入您的旧密码", "请输入您的新密码", "请输入您的新密码"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .singleLine
    }
    
    override func rightBarButtonItemEvent() {
        let allCells:[ChangeLoginPwCell] = self.tableView.visibleCells as! [ChangeLoginPwCell]
        var texts = [String]()
        
        for cell in allCells {
            texts.append(cell.textField.text ?? "")
        }
        if texts.count == titles.count {
            MyInfoViewModel.changeLoginPassword(texts.first ?? "", texts[1], texts.last ?? "") { (success) in
                if success {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ChangeLoginPw {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeLoginPwCell", for: indexPath) as! ChangeLoginPwCell
        if indexPath.row == 0 {
            cell.textField.becomeFirstResponder()
        }
        cell.titleLabel.text = titles[indexPath.row]
        cell.textField.placeholder = placeholders[indexPath.row]
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
}
