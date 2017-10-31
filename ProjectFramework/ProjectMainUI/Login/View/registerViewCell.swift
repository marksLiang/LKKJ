//
//  registerViewCell.swift
//  Cloudin
//
//  Created by hcy on 2017/3/8.
//  Copyright © 2017年 子轩. All rights reserved.
//

import UIKit 


class registerViewCell: UITableViewCell {
     
       var timer:Timer!     //计时器（点击.验证码)
    /// 设置计时器的最大秒数
    fileprivate  var timerMaxInterval:Int=60
    
    fileprivate var IntervalInitialize=0    //计时器自增数
    fileprivate var Intervallnitialize1 = 0
    
    //是否是验证码
    var VerificationCode=false
    //文本
    lazy var lab:UILabel = {
        let lab = UILabel(frame: CGRect(x: 10, y: 8, width: 70, height: 30))
        lab.text=""
        lab.font=UIFont.systemFont(ofSize: 12)
        lab.textColor = UIColor.white
        return lab
    }()
    //输入框
    lazy var inpuText:UITextField = {
       
        var newTextField:UITextField?=nil
        if (self.VerificationCode == true ){
        newTextField = UITextField(frame: CGRect(x: 75, y:10, width: self.bounds.width-140, height: 27))
        }else{
            
        newTextField = UITextField(frame: CGRect(x: 75, y:10, width: self.bounds.width-100, height: 27))
        }
        newTextField?.placeholder=""
        newTextField?.font=UIFont.systemFont(ofSize: 12)
        newTextField?.textColor=UIColor.white
        newTextField?.clearButtonMode = .always
        return newTextField!
    }()
    //验证码旁边的线条
    lazy var Hline:UILabel = {
        let lab = UILabel(frame: CGRect(x: self.bounds.width-80, y:10, width: 1, height: 27))
        lab.backgroundColor=UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1)
        return lab
    }()
    
    ///验证码
    lazy var VerificationCodeBtn:UIButton = {
        
        let btn = UIButton(frame: CGRect(x: self.bounds.width-100, y: 12, width: 69, height: 20))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle(  "获取验证码",   for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.layer.cornerRadius=4
        btn.layer.masksToBounds=true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    //下划线
    lazy var bottomLine: UILabel = {
        let bottomLine = UILabel.init(frame: CGRect.init(x: 10, y: self.lab.frame.maxY+1, width: self.VerificationCodeBtn.frame.maxX - 10, height: 1))
        bottomLine.backgroundColor = UIColor.white
        return bottomLine
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        self.backgroundColor = UIColor.clear
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initConfig( ){
        self.inpuText.setValue(UIColor.white.withAlphaComponent(0.8), forKeyPath: "_placeholderLabel.textColor")
        self.contentView.addSubview(lab)
        self.contentView.addSubview(inpuText)
        self.contentView.addSubview(bottomLine)
        if(VerificationCode==true){
            self.contentView.addSubview(VerificationCodeBtn)
        }
        
       
    }
    
    func StartTime(){
       self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.VerificationCodeTime), userInfo: nil, repeats: true)
    }
    
    
    
    //获取验证码计时器
    func VerificationCodeTime(){
        IntervalInitialize+=1
        VerificationCodeBtn.isEnabled=false  //使能 不可用 可点击
        VerificationCodeBtn.setTitleColor(UIColor.gray, for: .normal)
        VerificationCodeBtn.setTitle((timerMaxInterval-IntervalInitialize).description+" 秒", for: UIControlState())    //设置秒数
        
        if(IntervalInitialize>=timerMaxInterval){
            VerificationCodeBtn.isEnabled=true   //可用 可点击
            self.timer.invalidate() //停止计时器
            IntervalInitialize=0    //初始化
            VerificationCodeBtn.setTitleColor(UIColor.red, for: .normal)
            VerificationCodeBtn.setTitle("获取验证码", for: UIControlState())
        }
    }
    

}
