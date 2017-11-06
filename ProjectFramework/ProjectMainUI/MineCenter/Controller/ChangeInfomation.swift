//
//  ChangeInfomation.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/24.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

enum ChangeInfomationType {
    case none
    case nickname
    case password
}

class ChangeInfomation: MyInfomationBase {
    var info: String?
    var type: ChangeInfomationType = .none
    
    typealias EditCompletion = (_ nickname: String) -> Void
    var completion:EditCompletion? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func rightBarButtonItemEvent() {
        if completion != nil {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ChangeInfomationCell
            completion!(cell.textField.text ?? "")
        }
        super.rightBarButtonItemEvent()
    }
}

// MARK: - 设置界面
extension ChangeInfomation {
    fileprivate func setupUI() {
        tableView.backgroundColor = UIColor.groupTableViewBackground
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ChangeInfomation {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInfomationCell", for: indexPath) as! ChangeInfomationCell
        if self.type == .password {
            cell.textField.keyboardType = .numberPad
        } else {
            cell.textField.keyboardType = .default
        }
        cell.textField.becomeFirstResponder()
        cell.selectionStyle = .none
        
        cell.textField.text = info ?? ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
}
