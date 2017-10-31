//
//  ClassTableviewCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ClassTableviewCell: UITableViewCell {
    
    lazy var lable: UILabel = {
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 20))
        lable.font = UIFont.systemFont(ofSize: 13)
        lable.textAlignment = .center
        return lable
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            //debugPrint("我点击了")
            self.backgroundColor = UIColor.white
        }
        
    }
    
    override func layoutSubviews() {
        lable.center = self.contentView.center
        self.contentView.addSubview(lable)
        if isSelected == true {
            self.backgroundColor = UIColor.white
        }else{
            self.backgroundColor = UIColor().TransferStringToColor("#F1F2F3")
        }
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor().TransferStringToColor("#DADBDC").cgColor
        self.selectionStyle = .none
    }
    func change() -> Void {
        self.backgroundColor = UIColor().TransferStringToColor("#F1F2F3")
    }
}

