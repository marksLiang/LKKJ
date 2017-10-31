//
//  MyInfomation.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/24.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyInfomation: UITableViewController {
    
    fileprivate let MSHeaderCell = "MyHeaderCell"
    fileprivate let MSNormalCell = "MyNomalCell"
    fileprivate let titles = ["头像管理", "昵称", "手机号", "修改登录密码", "修改支付密码", "性别"]
    fileprivate let infoDatas = ["", "马大哈", "13725475504", "", "", "男"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func if_rightBarButtonItemEvent() {
        
    }
}

// MARK: - 界面
extension MyInfomation {
    fileprivate func setupUI() {
        
        var bounds = self.view.bounds
        bounds.size.height = 4.0;
        let headerView = UIView(frame: bounds)
        headerView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableHeaderView = headerView
        
        let footerView = UIView(frame: bounds)
        footerView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = footerView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(if_rightBarButtonItemEvent))
    }
}

// MARK: - Table view data source & delegate
extension MyInfomation {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MSHeaderCell, for: indexPath) as! MyHeaderCell
            cell.titleLabel.text = titles[indexPath.row]
            cell.titleLabel.font = UIFont.systemFont(ofSize: 16.0)
            return cell
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: MSNormalCell)
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: MSNormalCell)
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
                cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 15.0)
            }
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.text = titles[indexPath.row]
            cell?.detailTextLabel?.text = infoDatas[indexPath.row]
            return cell ?? UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 76.0
        }
        return 54.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            if indexPath.row == 0 {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let pickerController = UIImagePickerController()
                    pickerController.delegate = self
                    pickerController.sourceType = .photoLibrary
                    self.present(pickerController, animated: true, completion: nil)
                }
            }
        case 1, 2:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ChangeInfomation", Identifier: "ChangeInfomation") as! ChangeInfomation
            vc.info = infoDatas[indexPath.row]
            vc.completion = {(newNickname) in
                let cell = tableView.cellForRow(at: indexPath)
                cell?.detailTextLabel?.text = newNickname
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ChangeLoginPw", Identifier: "ChangeLoginPw") as! ChangeLoginPw
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ChangePayPassword", Identifier: "ChangePayPassword") as! ChangePayPassword
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ChangeGender", Identifier: "ChangeGender") as! ChangeGender
            let cell = self.tableView.cellForRow(at: IndexPath(row: self.infoDatas.count - 1, section: 0))
            guard let safCell = cell else {
                return
            }
            vc.currentGender = safCell.detailTextLabel?.text
            vc.changeGenderCompletion = { (result) in
                safCell.detailTextLabel?.text = result
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        default: break;
            
        }
        
    }
}

// MARK: - UIImagePickerControllerDelegate
extension MyInfomation {
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MyHeaderCell
        cell.headerImageView.image = pickedImage
        self.dismiss(animated: true, completion: nil)
    }
}
