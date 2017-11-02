//
//  MyAdress.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/16.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import RxSwift

class MyAdress: CustomTemplateViewController {
    /********************  懒加载  ********************/
    fileprivate lazy var addNewAdress: UIButton = {
        let addNewAdress = UIButton.init(type: .custom)
        addNewAdress.frame = CGRect.init(x: 0, y: CommonFunction.kScreenHeight - 45, width:  CommonFunction.kScreenWidth, height: 45)
        addNewAdress.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addNewAdress.backgroundColor = CommonFunction.SystemColor()
        addNewAdress.setTitle("添加新地址", for: .normal)
        addNewAdress.setTitleColor(UIColor.white, for: .normal)
        addNewAdress.rx.tap.subscribe(
            onNext:{ [weak self] value in
                debugPrint("添加新地址")
                let vc = CommonFunction.ViewControllerWithStoryboardName("MyAdressEdit", Identifier: "MyAdressEdit") as! MyAdressEdit
                self?.navigationController?.show(vc, sender: self)
        }).addDisposableTo(self.disposeBag)
        return addNewAdress
    }()
    /********************  XIB  ********************/
    @IBOutlet weak var tableView: UITableView!
    /********************  属性  ********************/
    fileprivate let disposeBag = DisposeBag() //创建一个处理包（通道）
    fileprivate var currenCell:MyAdressCell! = nil
    fileprivate let identifier = "MyAdressCell"
    fileprivate let viewModel = MyAdressViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的地址"
        self.inituI()
        self.getAdress()
    }
    
    private func getAdress() {
        viewModel.getMyAdress { (result) in
            if result {
                self.numberOfRowsInSection = self.viewModel.model.address?.count ?? 0
                self.RefreshRequest(isLoading: false, isHiddenFooter: true)
            } else {
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    
    //MARK: tableDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyAdressCell
        cell.selectionStyle = .none
        let model = self.viewModel.model.address![indexPath.row]
        cell.consignee.text = model.name
        cell.ReceivingAddress.text = model.address
        cell.selectButton.isSelected = false
        if model.state == "1" {
            cell.changeUI()
            currenCell = cell
        }
        cell.selectCallbackValue {[weak self] (buttonTag) in
            print(indexPath.row)
            switch buttonTag {
            case 1:
                if self?.currenCell != cell {
                    //反选
                    self?.currenCell.changeUI()
                    cell.changeUI()
                    self?.currenCell = cell
                }
                break;
            case 2:
                debugPrint("编辑")
                break;
            case 3:
                MBProgressHUD.showloading("正在删除", ismask: false, to: tableView)
                MyAdressViewModel.deleteAddress(model.accepterid, result: { (result) in
                    MBProgressHUD.hide(for: tableView, animated: true)
                    if result {
                        self?.getAdress()
                        MBProgressHUD.showSuccess("删除成功", to: tableView)
                    } else {
                        MBProgressHUD.showError("请求错误", to: tableView)
                    }
                })
                
                break;
            default:
                break;
            }
        }
        return cell
    }
    //MARK: initUI
    private func inituI()->Void{
        self.view.addSubview(addNewAdress)
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight , width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight - 45)
        self.tableView.backgroundColor = UIColor().TransferStringToColor("#EEEEEE")
        self.numberOfSections = 1
        self.tableViewheightForRowAt = 125
        self.header.isHidden = true
//        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
    }

}
