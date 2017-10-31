//
//  ClassCollectionViewCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ClassCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var classIamge: UIImageView!
    @IBOutlet weak var classText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func InitConfig(_ cell: Any) {
        let model = cell as! third_typeList
        classIamge.ImageLoad(PostUrl: model.typepic)
        classText.text = model.typename
    }
}
