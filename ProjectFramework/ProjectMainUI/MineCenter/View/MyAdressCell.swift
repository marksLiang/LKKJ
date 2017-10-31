//
//  MyAdressCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/16.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyAdressCell: UITableViewCell {
    typealias selectbackValue=(_ tag:Int)->Void //类似于OC中的typedef
    var myselectbackValue:selectbackValue?  //声明一个闭包 类似OC的Block属性
    func  selectCallbackValue(value:selectbackValue?){
        myselectbackValue = value //返回值
    }
    
    @IBOutlet weak var consignee: UILabel!//收货人
    @IBOutlet weak var ReceivingAddress: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var moren: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clear
        selectButton.backgroundColor = UIColor.white
        selectButton.layer.cornerRadius = selectButton.frame.width/2
        selectButton.layer.borderColor = UIColor.darkGray.cgColor
        selectButton.layer.borderWidth = 0.5
        selectButton.setBackgroundImage(UIImage.init(named: "a"), for: .normal)
        selectButton.setBackgroundImage(UIImage.init(named: "shopcarSelect"), for: .selected)
        selectButton.tag = 1
        editButton.tag = 2
        deleteButton.tag = 3
        selectButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
    }
    func buttonClick(button:UIButton) -> Void {
        if myselectbackValue != nil {
            myselectbackValue!(button.tag)
        }
    }
    func changeUI() -> Void {
        selectButton.isSelected = !selectButton.isSelected
        if selectButton.isSelected {
            moren.text = "默认地址"
        }else{
            moren.text = "设为默认"
        }
    }
}
