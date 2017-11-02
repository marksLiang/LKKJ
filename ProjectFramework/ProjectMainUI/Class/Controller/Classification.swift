//
//  Classification.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/9/18.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class Classification: UIViewController {
    //左边tableview
    fileprivate lazy  var leftTableView: UITableView = {
        let leftTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: CommonFunction.kScreenHeight  - 49))
        leftTableView.delegate = self
        leftTableView.dataSource = self
        let footder = UIView.init()
        leftTableView.tableFooterView = footder
        leftTableView.register(ClassTableviewCell.self, forCellReuseIdentifier: self.identiFier)
//        leftTableView.layer.borderWidth = 0.5
//        leftTableView.layer.borderColor = UIColor.gray.cgColor
        return leftTableView
    }()
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 80, y: 64, width: CommonFunction.kScreenWidth - 80, height: CommonFunction.kScreenHeight - 64  - 49), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        let requesterNib = UINib(nibName: "ClassCollectionViewCell", bundle: nil)
        collectionView.register(requesterNib, forCellWithReuseIdentifier: "ClassCollectionViewCell")
        collectionView.register(ClassReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.backgroundColor = UIColor.white
//        collectionView.layer.borderWidth = 0.5
//        collectionView.layer.borderColor = UIColor.gray.cgColor
        return collectionView
    }()
    /********************  属性  ********************/
    fileprivate let identiFier = "ClassTableviewCell"
    fileprivate var currenCell:ClassTableviewCell? = nil
    fileprivate let sectionText = ["热门商品","猜你喜欢","为你推荐"]
    fileprivate var viewModel = ClassViewModel()
    fileprivate var index = 0
    fileprivate var isfinished = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分类"
        self.GetHttpData()
        self.initUI()
        
    }
    //请求数据
    private func GetHttpData()->Void{
        viewModel.GetGoodsClass { (result) in
            if result == true {
                self.isfinished = true
                self.leftTableView.reloadData()
                self.collectionView.reloadData()
            }else{
                CommonFunction.HUD("请求错误", type: .error)
            }
        }
    }
    //MARK: initUI
    private func initUI()->Void{
        self.view.addSubview(leftTableView)
        self.view.addSubview(collectionView)
    }
}

extension Classification: UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //MARK: tableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.model.goodsType?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiFier, for: indexPath) as! ClassTableviewCell
        if indexPath.row == 0 && currenCell == nil {
            cell.isSelected = true
            currenCell = cell
        }
        let model = self.viewModel.model.goodsType![indexPath.row]
        cell.lable.text = model.typename
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = leftTableView.visibleCells[indexPath.row] as! ClassTableviewCell
        if cell != currenCell {
            currenCell?.change()
            currenCell = cell
            self.index = indexPath.row
            self.collectionView.reloadData()
        }
        
    }
    //MARK: collectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return isfinished ? self.viewModel.model.goodsType![index].second_type!.count : 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isfinished ? self.viewModel.model.goodsType![index].second_type![section].third_type!.count : 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCollectionViewCell", for: indexPath) as! ClassCollectionViewCell
        cell.InitConfig(self.viewModel.model.goodsType![index].second_type![indexPath.section].third_type![indexPath.row] as Any)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)as!ClassReusableView
            head.sectioLable.text = self.viewModel.model.goodsType![index].second_type![indexPath.section].typename
            return head
        }
        else{
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  CGSize(width: self.collectionView.frame.width, height: 45)
    }
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0,0,0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let showrowsitem:CGFloat=3  //竖屏显示的数目 （暂时未做横屏手机item  间距直接也存在点差异 ipad 没事 iPhone需要修改
        return CGSize(width: self.collectionView.frame.width / showrowsitem, height: self.collectionView.frame.width / showrowsitem * 1.3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.viewModel.model.goodsType![index].second_type![indexPath.section].third_type![indexPath.row] as third_typeList
        let vc = CommonFunction.ViewControllerWithStoryboardName("GoodsList", Identifier: "GoodsList") as! GoodsList
        vc.typeid = model.typeid
        self.navigationController?.show(vc, sender: self)
    }
}
