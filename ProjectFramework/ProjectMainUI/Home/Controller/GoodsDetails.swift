//
//  GoodsDetails.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import RxSwift

class GoodsDetails: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var model: index_goodsList?
    var contentImageViewHeight = 0.0
    
    fileprivate let disposeBag = DisposeBag() //创建一个处理包（通道）
    fileprivate let colorArray = [CommonFunction.SystemColor(),UIColor().TransferStringToColor("#F09826")] //颜色
    fileprivate let textArray  = ["立即购买","加入购物车"]
    
    //轮播图
    fileprivate lazy var scrollView: SDCycleScrollView = {
        let scrollView = SDCycleScrollView(frame:CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 200),delegate:nil ,placeholderImage:UIImage.init(named: "placeholder"))
        scrollView?.pageDotColor = UIColor.white
        scrollView?.currentPageDotColor = CommonFunction.SystemColor()
        return scrollView!
    }()
    
    //收藏按钮
    fileprivate lazy var collectionBtn: UIButton = {
        let collectionBtn = UIButton.init(type: .custom)
        collectionBtn.frame = CGRect.init(x: self.view.frame.width - 80, y: 0, width: 80, height: 50)
        collectionBtn.layer.borderColor = UIColor.gray.cgColor
        collectionBtn.layer.borderWidth = 0.5
        collectionBtn.setImage(UIImage.init(named: "icon_Collection"), for: .normal)
        collectionBtn.setImage(UIImage.init(named: "myCollction"), for: .highlighted)
        collectionBtn.setImage(UIImage.init(named: "myCollction"), for: .selected)
        collectionBtn.rx.tap.subscribe(
            onNext:{ [weak self] value in
                
                if Global_UserInfo.IsLogin {
                    // 取消收藏
                    if (self?.collectionBtn.isSelected)! {
                        GoodsDetailViewModel.collet(collet: .delete, goodsid: self?.model?.goodsid ?? "") { (reslut) in
                            self?.collectionBtn.isSelected = !reslut
                            if reslut {
                                MBProgressHUD.lk_showSuccess(status: "已取消收藏")
                            } else {
                                MBProgressHUD.lk_showSuccess(status: "取消收藏失败")
                            }
                        }
                    } else {
                        GoodsDetailViewModel.collet(collet: .add, goodsid: self?.model?.goodsid ?? "") { (reslut) in
                            self?.collectionBtn.isSelected = reslut
                            if reslut {
                                MBProgressHUD.lk_showSuccess(status: "收藏成功")
                            } else {
                                MBProgressHUD.lk_showSuccess(status: "收藏失败")
                            }
                        }
                    }
                } else {
                    let vc = LoginViewControllerTwo()
                    self?.present(vc, animated: true, completion: nil)
                }
        }).addDisposableTo(self.disposeBag)
        return collectionBtn
    }()
    
    fileprivate lazy var tableFooterView = UIImageView(frame: CGRect(x: 0.0, y: 8.0, width: UIScreen.main.bounds.size.width , height: 10))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "商品详情"
        setupSubViews()
        setupBottomBar()
        fetchColoectStatus()
    }
    
    /// 获取收藏状态
    private func fetchColoectStatus() {
        GoodsDetailViewModel.collet(collet: .status, goodsid: model?.goodsid ?? "") { (reslut) in
            self.collectionBtn.isSelected = reslut
        }
    }
}

// MARK: - 界面
extension GoodsDetails {
    
    fileprivate func setupBottomBar() {
        // 底部Bar
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: self.view.frame.height - 50, width: self.view.frame.width, height: 50))
        self.view.insertSubview(bottomView, aboveSubview: self.tableView)
        bottomView.addSubview(collectionBtn)
        
        for i in 0..<2 {
            let button = UIButton.init(type: .system)
            button.frame = CGRect.init(x: ((self.view.frame.width - 80)/2)*CGFloat(i), y: 0, width: (self.view.frame.width - 80)/2, height: 50)
            button.tag = i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.backgroundColor = colorArray[i]
            button.setTitle(textArray[i], for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.rx.tap.subscribe( {[weak self] (value) in
                let buttonTitle = button.titleLabel!.text
                if buttonTitle == "立即购买" {
                    let vc = CommonFunction.ViewControllerWithStoryboardName("GoodsOder", Identifier: "GoodsOder") as! GoodsOder
                    vc.model = self?.model
                    self?.navigationController?.show(vc, sender: self)
                } else if buttonTitle == "加入购物车" {
                    GoodsDetailViewModel.addGoodsCar(goodsid: (self?.model?.goodsid)!, count: 1)
                } else {
                    
                }
                
            }).addDisposableTo(self.disposeBag)
            bottomView.addSubview(button)
        }
    }
    
    fileprivate func setupSubViews() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        
        // 滚动视图
        self.tableView.tableHeaderView = scrollView
        scrollView.imageURLStringsGroup = [model?.goodspic ?? ""]
        
        // 商品详情
        let url = URL(string: model?.infopic ?? "")
        self.tableFooterView.sd_setImage(with: url, completed: { (image, error, _, _) in
            if error == nil && image != nil {
                self.tableFooterView.backgroundColor = UIColor.white
                self.tableFooterView.contentMode = .scaleToFill
                var bounds = self.tableFooterView.bounds
                bounds.size.height = (image?.size.height)!
                self.tableFooterView.bounds = bounds
                self.tableView.tableFooterView = self.tableFooterView
            }
        })
    }
}

// MARK: - Table view data source & delegage
extension GoodsDetails: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 140 : 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoodsDetailInfoCell", for: indexPath) as! GoodsDetailInfoCell
            cell.selectionStyle = .none
            cell.titlLabel.text = self.model?.content
            cell.originalPriceLabel.text = "原价：¥" + (self.model?.old_price)!
            cell.currentPriceLabel.text = "现价：¥" + (self.model?.price)!
            cell.soldOutLabel.text = "已售：" + (self.model?.sold_out)!
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "商品详情"
            cell.contentView.backgroundColor = UIColor.groupTableViewBackground
            return cell
        }
    }
}

