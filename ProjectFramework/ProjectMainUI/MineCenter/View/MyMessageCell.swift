//
//  MyMessageCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyMessageCell: UITableViewCell {

    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var massageContent: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}