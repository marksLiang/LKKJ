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
    fileprivate var userInfo: UserModel?
    fileprivate var userHeaderImage: Data?
    
    deinit {
        debugPrint(self.description)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getUserInfo()
    }
    
    // 获取用户信息
    private func getUserInfo() {
        MyInfoViewModel.fetchUserInfomation { (user) in
            self.userInfo = user
            self.tableView.reloadData()
        }
    }
    // 保存
    @objc fileprivate func if_rightBarButtonItemEvent() {
        guard let user = self.userInfo else {
            return
        }
       
        if self.userHeaderImage != nil {
            MyInfoViewModel.changeUserInfomation(user.nickname, user.phone, user.sex, self.userHeaderImage!)
        }
        
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
            cell.titleLabel.font = UIFont.systemFont(ofSize: 15.0)
            cell.headerImageView.ImageLoad(PostUrl: self.userInfo?.userpic ?? "")
            return cell
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: MSNormalCell)
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: MSNormalCell)
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
                cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14.0)
            }
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.text = titles[indexPath.row]
            var detailText = ""
            switch indexPath.row {
            case 1:
                detailText = self.userInfo?.nickname ?? ""
            case 2:
                detailText = self.userInfo?.phone ?? ""
            case titles.count - 1:
                let index = Int(self.userInfo?.sex ?? "0") ?? LKGenders.count - 1
                detailText =  LKGenders[index]
            default:
                break
            }
            cell?.detailTextLabel?.text = detailText
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
        case 1:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ChangeInfomation", Identifier: "ChangeInfomation") as! ChangeInfomation
            vc.info = self.userInfo?.nickname
            vc.type = .nickname
            vc.completion = {(result) in
                let cell = tableView.cellForRow(at: indexPath)
                cell?.detailTextLabel?.text = result
                self.userInfo?.nickname = result
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = CommonFunction.ViewControllerWithStoryboardName("ChangeInfomation", Identifier: "ChangeInfomation") as! ChangeInfomation
            vc.type = .password
            vc.info = self.userInfo?.phone
            vc.completion = {(result) in
                let cell = tableView.cellForRow(at: indexPath)
                cell?.detailTextLabel?.text = result
                self.userInfo?.phone = result
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
            let cell = self.tableView.cellForRow(at: IndexPath(row: self.titles.count - 1, section: 0))
            guard let safCell = cell else {
                return
            }
            vc.currentGender = safCell.detailTextLabel?.text
            vc.changeGenderCompletion = { (result) in
                safCell.detailTextLabel?.text = result
                let index = LKGenders.index(of: result)
                self.userInfo?.sex = "\(index ?? 2)"
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
        self.userHeaderImage = UIImage.da_compressImage(toData: pickedImage, withRatio: 1.0)
        
        self.dismiss(animated: true, completion: nil)
    }
}
