//
//  MyOderCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/25.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOderCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var Datetime: UILabel!
    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var goodsCount: UILabel!
    @IBOutlet weak var goodsPrice: UILabel!
    @IBOutlet weak var StateButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        StateButton.layer.borderWidth = 0.5
        StateButton.layer.borderColor = UIColor().TransferStringToColor(CommonFunction.SystemColor()).cgColor
        StateButton.setTitleColor(CommonFunction.SystemColor(), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
