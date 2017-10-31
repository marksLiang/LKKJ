//
//  HomeHeaderView.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {
    typealias selectbackValue=(_ value:Int)->Void //类似于OC中的typedef
    var myselectbackValue:selectbackValue?  //声明一个闭包 类似OC的Block属性
    func  selectCallbackValue(value:selectbackValue?){
        myselectbackValue = value //返回值
    }
    
    lazy var collectionView:UICollectionView = {
        let layout = LYFFlowLayout()
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 150, width: CommonFunction.kScreenWidth, height: 155), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        let requesterNib = UINib(nibName: "HomeMenuCell", bundle: nil)
        collectionView.register(requesterNib, forCellWithReuseIdentifier: "HomeMenuCell")
        return collectionView
    }()
    var dataList:[index_typeList]?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(collectionView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HomeHeaderView: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList != nil ? (dataList?.count)! : 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeMenuCell", for: indexPath) as! HomeMenuCell
        cell.InitConfig(dataList![indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if myselectbackValue != nil {
            myselectbackValue!(indexPath.row)
        }
    }
}
