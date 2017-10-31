//
//  HomeMenuCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HomeMenuCell: UICollectionViewCell {

    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
//        self.backgroundColor = UIColor.red
        mainImage.layer.cornerRadius = 20
        mainImage.clipsToBounds = true
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! index_typeList
        mainImage.ImageLoad(PostUrl: model.typepic)
        menuName.text = model.typename
    }
}
