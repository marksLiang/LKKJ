//
//  GoodsListCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/25.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodsListCell: UITableViewCell {

    @IBOutlet weak var sold_outLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var goodspicImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
