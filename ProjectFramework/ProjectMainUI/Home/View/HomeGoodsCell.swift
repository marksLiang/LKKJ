//
//  HomeGoodsCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/19.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HomeGoodsCell: UITableViewCell {

    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goosTitle: UILabel!
    @IBOutlet weak var goodsOldPrice: UILabel!
    @IBOutlet weak var goodsNewPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! index_goodsList
        goodsImage.ImageLoad(PostUrl: model.goodspic)
        goosTitle.text = model.tilte
        goodsOldPrice.text = model.cashtype + model.old_price
        goodsNewPrice.text = model.price
    }
}
