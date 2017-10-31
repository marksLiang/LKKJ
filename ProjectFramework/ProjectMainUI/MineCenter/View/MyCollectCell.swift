//
//  MyCollectCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyCollectCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var goodsTitle: UILabel!
    @IBOutlet weak var goodsPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
