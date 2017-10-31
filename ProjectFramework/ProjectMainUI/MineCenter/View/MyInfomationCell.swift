//
//  MyInfomationCell.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/24.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

/// 头像管理
class MyHeaderCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerImageView.layer.cornerRadius = headerImageView.frame.size.width/2
        headerImageView.layer.masksToBounds = true
    }
}

