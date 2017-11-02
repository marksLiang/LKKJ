//
//  ShoppingCar.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ShoppingCar: CustomTemplateViewController {
    /********************  XIB  ********************/
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var selectAllBtn: UIButton!//全选
    @IBOutlet weak var TotalpriceLable: UILabel!//总计
    @IBOutlet weak var actionBtn: UIButton!//结算 && 删除
    
    fileprivate lazy var edtingBtn: UIButton = {
        let edtingBtn = UIButton.init(type: .system)
        edtingBtn.frame = CGRect.init(x: 0, y: 0, width: 50, height: 30)
        edtingBtn.tag = 100
        edtingBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        edtingBtn.setTitle("编辑", for: .normal)
        edtingBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return edtingBtn
    }()
    /********************  属性  ********************/
    fileprivate let identifier = "ShoppingCarCell"
    fileprivate var isCellEditing = false
    fileprivate let viewModel = ShoppingCarViewModel()
    fileprivate var dataArray = [CarModel]()
    fileprivate var selectArray = [CarModel]()
    //MARK: 视图加载
    override func viewDidLayoutSubviews() {
        //全选按钮
        selectAllBtn.tag = 101
        selectAllBtn.layer.borderWidth = 0.5
        selectAllBtn.layer.borderColor = UIColor.gray.cgColor
        selectAllBtn.layer.cornerRadius = selectAllBtn.frame.width / 2
        selectAllBtn.setBackgroundImage(UIImage.init(named: "a"), for: .normal)
        selectAllBtn.setBackgroundImage(UIImage.init(named: "shopcarSelect"), for: .selected)
        selectAllBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        //默认结算
        actionBtn.tag = 102
        actionBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        bottomView.layer.borderWidth = 0.5
        bottomView.layer.borderColor = UIColor.gray.cgColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "购物车"
        // Do any additional setup after loading the view.
        self.initUI()
        self.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CommonFunction.Instance.isNeedRefreshShoppingCar {
            self.getData()
            CommonFunction.Instance.isNeedRefreshShoppingCar = false
        }
    }
    
    //MARK: 刷新
    override func headerRefresh() {
        getData()
    }
    override func Error_Click() {
        getData()
    }
    
    func getData() -> Void {
        viewModel.getGoodsCarList { (result) in
            if result {
                self.dataArray.removeAll()
                for model in self.viewModel.model.goods_car! {
                    self.dataArray.append(model)
                }
                self.numberOfSections = 1
                self.numberOfRowsInSection = self.viewModel.model.goods_car?.count ?? 0
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: false)
            } else {
                self.RefreshRequest(isLoading: false, isHiddenFooter: true, isLoadError: true)
            }
        }
    }
    //MARK: 按钮方法
    func buttonClick(button:UIButton) -> Void {
        switch button.tag {
            //编辑 & 完成
        case 100:
            isCellEditing = !isCellEditing
            if isCellEditing == true {
                edtingBtn.setTitle("完成", for: .normal)
            }else{
                edtingBtn.setTitle("编辑", for: .normal)
            }
            self.chageUI()
            break
            //全选
        case 101:
            button.isSelected = !button.isSelected
            self.selectArray.removeAll()
            if button.isSelected {
                debugPrint("111")
                for i in 0..<self.dataArray.count {
                    let model = self.dataArray[i]
                    model.isSelected = true
                    self.selectArray.append(model)
                }
            }else{
                debugPrint("222")
                for i in 0..<self.dataArray.count {
                    let model = self.dataArray[i]
                    model.isSelected = false
                }
            }
            self.RefreshRequest(isLoading: false, isHiddenFooter: true)
            self.totalPrice()
            break
        case 102:
            debugPrint("结算")
            //编辑删除时
            if isCellEditing == true{
                CommonFunction.AlertController(self, title: "是否删除", message: "确定将该商品从购物车删除？", ok_name: "确定", cancel_name: "取消", OK_Callback: {
                    for i in 0..<self.selectArray.count{
                        let model = self.selectArray[i]
                        self.dataArray.remove(at: (self.dataArray.index(of: model))!)
                    }
                    self.selectArray.removeAll()
                    self.totalPrice()
                    self.verityAllSelectState()
                    self.RefreshRequest(isLoading: false, isHiddenFooter: true)
                }) {
                    
                }
            }else{//结算
                
            }
            break
        default:
            break
        }
    }
    //编辑改变UI样式
    private func chageUI()->Void{
        if isCellEditing == true {
            actionBtn.setTitle("删除", for: .normal)
            actionBtn.backgroundColor = UIColor.red
        }else{
            actionBtn.setTitle("结算", for: .normal)
            actionBtn.backgroundColor = CommonFunction.SystemColor()
        }
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
    }
    //MARK: 计算加钱
    func totalPrice()->Void{
        var totlePrice = 0.0
        for i in 0..<self.selectArray.count {
            let model = self.selectArray[i]
            let price = Double(Int((model.goodsinfo?.price)!)!) * Double(model.count)!
            totlePrice += price
        }
        let text = "合计:¥\(totlePrice)"
        let STR = NSMutableAttributedString.init(string: text)
        let rang: NSRange = (text as NSString).range(of: "合计:")
        STR.addAttribute("合计:", value: UIColor.black, range: rang)
        STR.addAttribute("合计:", value: UIFont.systemFont(ofSize: 15), range: rang)
        self.TotalpriceLable.attributedText = STR
    }
    //MARK: 验证是否全选
    func verityAllSelectState()->Void{
        if self.selectArray.count == self.dataArray.count && self.dataArray.count != 0{
            selectAllBtn.isSelected = true
        }else{
           selectAllBtn.isSelected = false
        }
    }
    //MARK: tableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ShoppingCarCell
        let model = self.viewModel.model.goods_car![indexPath.row]
        cell.isCellEding = isCellEditing
        //cell操作
        cell.FuncCallbackValue {[weak self] (buttonTag,number) in
            self?.selectArray.append(model)
            self?.totalPrice()
        }
        cell.selectCallbackValue {[weak self] (isSelected) in
            model.isSelected = isSelected
            if isSelected == true {
                self?.selectArray.append(model)
                debugPrint("标记")
            }else{
                //选择数组里删除取消的model
                self?.selectArray.remove(at: (self?.selectArray.index(of: model))!)
                debugPrint("取消标记")
            }
            self?.totalPrice()
            self?.verityAllSelectState()
        }
        cell.reloadCell(model: model)
        return cell
    }
    //MARK: initUI
    private func initUI()->Void{
        self.InitCongif(tableView)
        self.header.isHidden = true
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight - 49 - 40)
        self.numberOfSections = 1
        self.tableViewheightForRowAt = 100
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
        //设置导航栏
        let rightItem = UIBarButtonItem.init(customView: edtingBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
}
extension ShoppingCar {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        CommonFunction.AlertController(self, title: "是否删除", message: "确定将该商品从购物车删除？", ok_name: "确定", cancel_name: "取消", OK_Callback: {
            let model = self.dataArray[indexPath.row]
            //判断是否存在
            if self.selectArray.contains(model){
                self.selectArray.remove(at: (self.selectArray.index(of: model))!)
            }
            self.dataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row:indexPath.row, section: 0)], with: .left)
            self.totalPrice()
            self.verityAllSelectState()
        }) {
            
        }
    }
}
