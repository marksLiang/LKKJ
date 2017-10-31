//
//  LYFFlowLayout.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/19.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class LYFFlowLayout: UICollectionViewFlowLayout {
    let rowCount = 4
    let lowCount = 2
    override func prepare() {
        super.prepare()
        scrollDirection = UICollectionViewScrollDirection.horizontal
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        itemSize = CGSize(width: CommonFunction.kScreenWidth/CGFloat(rowCount), height: 75)
        super.prepare()
    }
    //（该方法默认返回false） 返回true  frame发生改变就重新布局  内部会重新调用prepare 和layoutAttributesForElementsInRect
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
