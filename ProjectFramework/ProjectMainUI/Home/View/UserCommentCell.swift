//
//  UserCommentCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/10.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class UserCommentCell: UITableViewCell {

    //用户头像
    lazy var userIcon: UIImageView = {
        let userIcon = UIImageView.init(frame: CommonFunction.CGRect_fram(15, y: 5, w: 35, h: 35))
        userIcon.image = UIImage.init(named: "testimg")
        userIcon.layer.cornerRadius = userIcon.frame.width / 2
        userIcon.clipsToBounds = true
        return userIcon
    }()
    //用户昵称
    lazy var userNickName: UILabel = {
        let userNickName = UILabel.init(frame: CommonFunction.CGRect_fram(self.userIcon.frame.maxX + 5, y: 5, w: 100, h:15 ))
        userNickName.font = UIFont.systemFont(ofSize: 11)
        userNickName.text = "住朋购友"
        return userNickName
    }()
    //时间
    lazy var timeLable: UILabel = {
        let timeLable = UILabel.init(frame: CommonFunction.CGRect_fram(CommonFunction.kScreenWidth - 150 - 10, y: 5, w: 150, h:15 ))
        timeLable.font = UIFont.systemFont(ofSize: 11)
        timeLable.textAlignment = .right
        timeLable.textColor = UIColor.lightGray
        timeLable.text = "3天前"
        return timeLable
    }()
    //评分
    lazy var startView: XHStarRateView = {
        let startView = XHStarRateView.init(frame: CommonFunction.CGRect_fram(self.userNickName.frame.minX, y: self.userNickName.frame.maxY+3, w: 80, h: 12), numberOfStars: 5, rateStyle: .HalfStar, isAnination: true, delegate: self)
        //        startView?.backgroundColor = UIColor.blue
        startView!.isUserInteractionEnabled = false
        return startView!
    }()
    //评论内容
    lazy var commentLable: UILabel = {
        let commentLable = UILabel.init(frame: CommonFunction.CGRect_fram(15, y: self.userIcon.frame.maxY + 5, w: CommonFunction.kScreenWidth - 30, h:0 ))
        commentLable.font = UIFont.systemFont(ofSize: 11)
        commentLable.numberOfLines = 0
        return commentLable
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        self.selectionStyle = .none
        self.contentView.addSubview(self.userIcon)
        self.contentView.addSubview(self.userNickName)
        self.contentView.addSubview(self.startView)
        self.contentView.addSubview(self.timeLable)
        self.contentView.addSubview(self.commentLable)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func InitConfig(_ cell: Any) {
        
    }
}
