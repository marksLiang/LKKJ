//
//  ShoppingCarCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ShoppingCarCell: UITableViewCell {
    //选择按钮  加减按钮回调
    typealias CallbackValue=(_ tag:Int , _ number:Int)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    typealias selectbackValue=(_ value:Bool)->Void //类似于OC中的typedef
    var myselectbackValue:selectbackValue?  //声明一个闭包 类似OC的Block属性
    func  selectCallbackValue(value:selectbackValue?){
        myselectbackValue = value //返回值
    }
    @IBOutlet weak var selectBtn: UIButton!//选中按钮
    @IBOutlet weak var goodsImageView: UIImageView!//商品照片
    @IBOutlet weak var goodsName: UILabel!//商品名
    @IBOutlet weak var goodsCount: UILabel!//商品数量
    @IBOutlet weak var goodsPrice: UILabel!//现价
    @IBOutlet weak var goodsOldPrice: UILabel!//原价
    @IBOutlet weak var line: UILabel!//线
    @IBOutlet weak var cut: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var currenNumberLable: UILabel!//当前数量
    private var iscellEded = false
    var isCellEding:Bool {
        get{
            //返回成员变量
            return iscellEded;
        }
        set(newValue){
            //使用 _成员变量 记录值
            iscellEded = newValue;
            self.changeUI()
        }
    }
    
    var currenNumber = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //绘制按钮
        selectBtn.tag = 1
        cut.tag      = 2
        add.tag      = 3
        selectBtn.layer.borderWidth = 0.5
        selectBtn.layer.borderColor = UIColor.gray.cgColor
        selectBtn.layer.cornerRadius = selectBtn.frame.width / 2
        selectBtn.setBackgroundImage(UIImage.init(named: "a"), for: .normal)
        selectBtn.setBackgroundImage(UIImage.init(named: "shopcarSelect"), for: .selected)
        cut.layer.borderWidth = 0.5
        cut.layer.borderColor = UIColor.gray.cgColor
        cut.isHidden = true
        add.layer.borderWidth = 0.5
        add.layer.borderColor = UIColor.gray.cgColor
        add.isHidden = true
        currenNumberLable.isHidden = true
        currenNumberLable.layer.borderWidth = 0.5
        currenNumberLable.layer.borderColor = UIColor.gray.cgColor
        selectBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        cut.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        add.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func buttonClick(_ button: UIButton) -> Void {
        switch button.tag {
        case 1:
            button.isSelected = !button.isSelected
            if (myselectbackValue != nil) {
                myselectbackValue!(button.isSelected)
            }
            break
        case 2:
            //当数量为1时提醒用户不能再减
            if currenNumber == 1 {
                CommonFunction.HUD("亲，该商品数不能再减啦", type: .error)
                return
            }
            currenNumber-=1
            if (myCallbackValue != nil) {
                myCallbackValue!(button.tag,currenNumber)
            }
            break
        case 3:
            currenNumber+=1
            if (myCallbackValue != nil) {
                myCallbackValue!(button.tag,currenNumber)
            }
            break
        default:
            break
        }
        goodsCount.text = "数量 x \(currenNumber)"
        currenNumberLable.text = "\(currenNumber)"
    }
    //编辑时改变UI
    func changeUI() -> Void {
            goodsCount.isHidden = self.iscellEded
            cut.isHidden = !self.iscellEded
            add.isHidden = !self.iscellEded
            currenNumberLable.isHidden = !self.iscellEded
    }
    //MARK: reloadUI
    func reloadCell(model:GoodsCarModel) -> Void {
        currenNumber = model.goodsCount
        selectBtn.isSelected = model.isSelected //是否选择
        goodsCount.text = "数量 x \(currenNumber)"
        currenNumberLable.text = "\(currenNumber)"
        goodsOldPrice.text = "¥\(model.OriginalPrice)"
        goodsPrice.text = "¥\(model.PresentPrice)"
        let width = "¥\(model.OriginalPrice)".getContenSizeWidth(font: UIFont.systemFont(ofSize: 11))
        line.frame = CGRect.init(x: line.frame.minX, y: line.frame.minY, width: width+3, height: 1)
    }
}

