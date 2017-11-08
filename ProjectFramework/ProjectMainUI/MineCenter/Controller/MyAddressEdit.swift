//
//  MyAddressEdit.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/3.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyAddressEdit: UITableViewController {
    
    let items = ["收件人", "联系电话"]
    let itemsPlaceholder = ["请输入收件人", "请输入联系电话"]
    var needRefreshAddressList: (()->())?
    var address: AdressModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
    }
    
    @objc private func rightBarButtonItemEvent() {
        
        let nameCell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! MyAddressEditCell
        let name = nameCell.contentTextField.text
        let phoneCell = tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! MyAddressEditCell
        let phone = phoneCell.contentTextField.text
        let areaCell = tableView.cellForRow(at: IndexPath.init(row: 2, section: 0))
        let area = areaCell?.detailTextLabel?.text == "请选择" ? "" : areaCell?.detailTextLabel?.text
        let detailCell = tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! MyAddressEditDetailCell
        let detailAddress = detailCell.detailAddressTextField.text
        let switchCell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as! MyAddressSetDefaultCell
        let isOn = switchCell.switchButton.isOn ? "1" : "0"
        
        guard let kname = name,
            let kphone = phone,
            let karea = area,
            let kdetailAddress = detailAddress else {
            return
        }
        
        let ocPhoneString = kphone as NSString
        if !ocPhoneString.isValidPhoneNumber() {
            MBProgressHUD.lk_showError(status: "请正确输入手机号")
            return
        }
        
        if kname.lengthOfBytes(using: .utf8) == 0 ||
            kphone.lengthOfBytes(using: .utf8) == 0 ||
            kdetailAddress.lengthOfBytes(using: .utf8) == 0 {
            MBProgressHUD.lk_showError(status: "请填写完整")
            return 
        }
        
        if address == nil {
            // 新增地址
            MyAdressViewModel.addAddress(kname, kphone, karea + kdetailAddress, isOn) { (result) in
                if result {
                    self.navigationController?.popViewController(animated: true)
                    if self.needRefreshAddressList != nil {
                        self.needRefreshAddressList!()
                    }
                }
            }
        } else {
            // 修改地址
            MyAdressViewModel.changeAddress((address?.accepterid)!, (address?.name)!, (address?.phone)!, (address?.address)!, isOn) { (result) in
                if result {
                    self.navigationController?.popViewController(animated: true)
                    if self.needRefreshAddressList != nil {
                        self.needRefreshAddressList!()
                    }
                }
            }
        }
    }
    
    private func setupSubViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(rightBarButtonItemEvent))
    }
}

// MARK: - Table view data source & delegate
extension MyAddressEdit {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 4 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 || indexPath.row == 1 {
                // 收货人/电话
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyAddressEditCell", for: indexPath) as! MyAddressEditCell
                cell.titleLabel.text = items[indexPath.row]
                cell.contentTextField.placeholder = itemsPlaceholder[indexPath.row]
                if indexPath.row == 1 {
                    cell.contentTextField.keyboardType = .numberPad
                    cell.contentTextField.tag = 110
                    cell.contentTextField.delegate = self
                }
                
                if address != nil {
                    if indexPath.row == 0 {
                        cell.contentTextField.text = address?.name
                    } else {
                        cell.contentTextField.text = address?.phone
                    }
                }
                return cell
            } else if indexPath.row == 2 {
                // 地区选择
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyAddressSelectAreaCell", for: indexPath)
                cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13.0)
                cell.textLabel?.text = "所在地区"
                cell.detailTextLabel?.text = "请选择"
                if address != nil {
                    if (address?.address.contains("区"))! {
                        
                    }
                }
                return cell
            } else {
                // 详细地址
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyAddressEditDetailCell", for: indexPath) as! MyAddressEditDetailCell
                if address != nil {
                    cell.detailAddressTextField.text = address?.address
                }
                return cell
            }
        } else {
            // 设为默认地址
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyAddressSetDefaultCell", for: indexPath) as! MyAddressSetDefaultCell
            if address != nil {
                cell.switchButton.isOn = address?.state == "1" ? true : false
            }
            
            cell.titleLabel.text = "设为默认地址"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 || indexPath.row == 1 {
               
            } else if indexPath.row == 2 {
                // 地区选择
                self.view.endEditing(true)
                
                let cityView = CityChooseView.init(frame: self.view.bounds)
                cityView.myClosure = { (province: String, city: String , area: String) -> Void in
                    let cell = tableView.cellForRow(at: indexPath)
                    cell?.detailTextLabel?.text = province + city + area
                }
                
                self.view.addSubview(cityView)
            } else {
                // 详细地址
                
            }
        } else {
            // 设为默认地址
           
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
                return 100
            } else {
                return 56
            }
        } else {
            return 56
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 8.0
        }
        return 0.1
    }
}

extension MyAddressEdit: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 110 {
            let ocString = string as NSString
            if string != "" {
                return ocString.isMatchRegex("^[0-9]+$")
            }
        }
        return true
    }
    
}

// MARK: - UIScrollViewDelegate
extension MyAddressEdit {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
