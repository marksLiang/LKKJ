//
//  MyAdressEdit.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/16.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum EditType{
    case edit//修改
    case add//增加
    case dufault//默认地址
}

class MyAdressEdit: CustomTemplateViewController {
    
    fileprivate lazy var saveButton: UIButton = {
        let saveButton = UIButton.init(type: .system)
        saveButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 30)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        saveButton.setTitle("保存", for: .normal)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        return saveButton
    }()
    //
    @IBOutlet weak var tableView: UITableView!
    fileprivate let disposeBag   = DisposeBag() //创建一个处理包（通道）
    fileprivate let identifier = "MyAdressEditCell"
    fileprivate let identifier1 = "MyAdressDetailCell"
    fileprivate let identifier2 = "MyDefaultCell"
    fileprivate let keyArray = ["收货人","联系电话","所在地区","街道"]
    var type:EditType!=nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "编辑地址"
        switch type {
        case .edit:
            self.title = "编辑地址"
            break;
        case .add:
            self.title = "添加新地址"
            break;
        case .dufault:
            
            break;
        default:
            break;
        }
        self.setNagvtionbar()
        self.inituI()
        
    }
    //MARK: tableDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return type == .dufault ? 1 : 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return keyArray.count + 1
        }else{
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 4 ? 80 : 50
    }
    //组尾高
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row < 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyAdressEditCell
                cell.keyName.text = keyArray[indexPath.row]
                if indexPath.row > 1 {
                    cell.phoneText.isHidden = true
                    cell.rightText.isHidden = false
                    cell.littleImage.isHidden = false
                }
                if indexPath.row == 1 {
                    cell.phoneText.keyboardType = .numberPad
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: identifier1, for: indexPath) as! MyAdressDetailCell
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier2, for: indexPath) as! MyDefaultCell
            return cell
        }
    }
    //MARK: setNagvtionbar
    private func setNagvtionbar()->Void{
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: saveButton)
    }
    //MARK: initUI
    private func inituI()->Void{
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight , width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight )
        self.tableView.backgroundColor = UIColor().TransferStringToColor("#EEEEEE")
        self.header.isHidden = true
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
