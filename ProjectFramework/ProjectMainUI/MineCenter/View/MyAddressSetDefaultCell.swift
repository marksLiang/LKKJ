//
//  MyAddressSetDefaultCell.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/3.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyAddressSetDefaultCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
