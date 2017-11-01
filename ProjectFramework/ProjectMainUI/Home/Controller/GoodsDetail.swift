//
//  GoodsDetail.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import RxSwift

class GoodsDetail: CustomTemplateViewController {
    /********************  懒加载  ********************/
    fileprivate lazy var buttonBar: LYFButtonBar = {
        let buttonBar = LYFButtonBar.init(frame: CGRect.init(x: 0, y: 64, width: CommonFunction.kScreenWidth * 0.6, height: 35), font:UIFont.systemFont(ofSize: 16), normalColor: UIColor.white, selectColor: UIColor.white, textArray: ["商品","评论","详情"], Callback_SelectedValue: {[weak self] (buttontag) in
            
        })
        return buttonBar
    }()
    //轮播图
    fileprivate lazy var shuffling: SDCycleScrollView = {
        let shuffling = SDCycleScrollView(frame:CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 200),delegate:self ,placeholderImage:UIImage.init(named: "placeholder"))
//        shuffling?.localizationImageNamesGroup = [StartOneImageList]
        shuffling?.pageDotColor = UIColor.white
        shuffling?.currentPageDotColor = CommonFunction.SystemColor()
        return shuffling!
    }()
    //用户评论
    fileprivate lazy var userCommentSection: UIView = {
        let userCommentSection = UIView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 40))
        userCommentSection.backgroundColor = UIColor.white
        userCommentSection.layer.borderWidth = 0.5
        userCommentSection.layer.borderColor = UIColor.lightGray.cgColor
        return userCommentSection
    }()
    fileprivate lazy var userCommentCount: UILabel = {
       let userCommentCount = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: 200, height: 20))
        userCommentCount.center.y = self.userCommentSection.center.y
       userCommentCount.font = UIFont.systemFont(ofSize: 13)
       return userCommentCount
    }()
    fileprivate lazy var moreComment: UIView = {
       let moreComment = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 60))
        moreComment.backgroundColor = UIColor.white
        return moreComment
    }()
    //更多按钮
    fileprivate lazy var moreButton: UIButton = {
       let moreButton = UIButton.init(type: .system)
        moreButton.frame = CGRect.init(x: 0, y: 0, width: 80, height: 25)
        moreButton.center = self.moreComment.center
        moreButton.layer.borderColor = UIColor.blue.withAlphaComponent(0.6).cgColor
        moreButton.layer.borderWidth = 0.5
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        moreButton.setTitle("更多评论", for: .normal)
        moreButton.setTitleColor(UIColor.blue.withAlphaComponent(0.6), for: .normal)
        moreButton.rx.tap.subscribe(
            onNext:{ [weak self] value in
                debugPrint("更多评论")
        }).addDisposableTo(self.disposeBag)
        return moreButton
    }()
    //收藏按钮
    fileprivate lazy var collectionBtn: UIButton = {
       let collectionBtn = UIButton.init(type: .custom)
        collectionBtn.frame = CGRect.init(x: self.view.frame.width - 80, y: 0, width: 80, height: 50)
        collectionBtn.layer.borderColor = UIColor.gray.cgColor
        collectionBtn.layer.borderWidth = 0.5
        collectionBtn.setImage(UIImage.init(named: "icon_Collection"), for: .normal)
        collectionBtn.rx.tap.subscribe(
            onNext:{ [weak self] value in
                //  收藏
                if Global_UserInfo.IsLogin {
                    GoodsDetailViewModel.collectGooods(goodsid: (self?.model?.goodsid)!, userid: Global_UserInfo.userid, token: Global_UserInfo.token)
                } else {
                    let vc = LoginViewControllerTwo()
                    self?.present(vc, animated: true, completion: nil)
                }
        }).addDisposableTo(self.disposeBag)
        return collectionBtn
    }()
    /********************  XIB  ********************/
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHead: UIView!
    /********************  属性  ********************/
    fileprivate let disposeBag = DisposeBag() //创建一个处理包（通道）
    fileprivate let colorArray = [CommonFunction.SystemColor(),UIColor().TransferStringToColor("#F09826")] //颜色
    fileprivate let textArray  = ["立即购买","加入购物车"]
    
    var model: index_goodsList?
    
    @IBOutlet weak var goodsInfoLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var nowPriecLabel: UILabel!
    @IBOutlet weak var soldOutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNagationBar()
        self.initBottomBar()
        self.initUI()
    }
    //MARK: tableDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    var _viewForHeaderInSection = [UIView(),UIView()]
    //组头
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        _viewForHeaderInSection[0] = self.userCommentSection
        _viewForHeaderInSection[1] = UIView().setIntroduceView(height: 40, title: "商品详情")
        return _viewForHeaderInSection[section]
    }
    //组头高
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //组尾
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            moreComment.addSubview(self.moreButton)
            return moreComment
        }else{
            return UIView()
        }
    }
   var _heightForFooterInSection = [CGFloat(60),CGFloat(0)]
    //组尾高
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return _heightForFooterInSection[section]
    }
    var _numberOfRowsInSection = [2,1]
    //组个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return _numberOfRowsInSection[section]
    }
    var _heightForRowAt = [CGFloat(110),CGFloat(250)]
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return _heightForRowAt[indexPath.section]
    }
    //MARK: initBottomBar
    private func initBottomBar()->Void{
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: self.view.frame.height - 50, width: self.view.frame.width, height: 50))
        bottomView.backgroundColor = UIColor.white
        self.view.addSubview(bottomView)
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
                    
                } else if buttonTitle == "加入购物车" {
                    
                } else {
                    
                }
                
            }).addDisposableTo(self.disposeBag)
            bottomView.addSubview(button)
        }
    }
    //MARK: initUI
    private func initUI()->Void{
        self.userCommentCount.text = "评价晒单(233)"
        self.userCommentSection.addSubview(self.userCommentCount)
        
        self.tableViewHead.addSubview(shuffling)
        self.InitCongif(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: CommonFunction.NavigationControllerHeight, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - CommonFunction.NavigationControllerHeight - 50)
        self.tableViewheightForRowAt = 110
        self.tableView.tableHeaderView = tableViewHead
        self.header.isHidden = true
        self.RefreshRequest(isLoading: false, isHiddenFooter: true)
        
        guard let model = self.model else {
            return
        }
        shuffling.imageURLStringsGroup = [model.goodspic]
        
        goodsInfoLabel.text = model.content
        originalPriceLabel.text = model.cashtype + model.old_price
        nowPriecLabel.text = model.cashtype + model.price
        soldOutLabel.text = model.sold_out
    }
    //MARK: 设置导航栏
    private func initNagationBar()->Void{
        self.navigationItem.titleView = buttonBar
    }
}
extension GoodsDetail: SDCycleScrollViewDelegate {
    //MARK: 轮播图代理
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        debugPrint(index)
    }
}
