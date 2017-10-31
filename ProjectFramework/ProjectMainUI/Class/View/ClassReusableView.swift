//
//  ClassReusableView.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/20.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ClassReusableView: UICollectionReusableView {
    fileprivate lazy var sectionHeader: UIView = {
        let sectionHeader = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: 45))
        sectionHeader.backgroundColor = UIColor.white
        for i in 0..<2 {
            let line = UILabel.init(frame: CGRect.init(x: 15 + CGFloat(i)*(self.frame.width/2 - 15 + 45), y: 22, width: self.frame.width/2 - 45 - 15, height: 1))
            line.backgroundColor = CommonFunction.SystemColor()
            sectionHeader.addSubview(line)
        }
        return sectionHeader
    }()
    lazy var sectioLable: UILabel = {
        let sectioLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 75, height: 25))
        sectioLable.center = self.sectionHeader.center
        sectioLable.layer.borderWidth = 0.5
        sectioLable.layer.borderColor = UIColor().TransferStringToColor(CommonFunction.SystemColor()).cgColor
        sectioLable.textAlignment = .center
        sectioLable.font = UIFont.systemFont(ofSize: 13)
        return sectioLable
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(sectionHeader)
        self.sectionHeader.addSubview(sectioLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
