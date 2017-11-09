//
//  LKPasswordView.swift
//  SwiftTestDemo
//
//  Created by Jinjun liang on 2017/10/25.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit

class LKPasswordView: UIView {

    var completion: ((_ password: String) ->Void)?
    fileprivate var textField: UITextField!
    fileprivate let passwordCount = 6
    fileprivate let dotSize = CGSize(width: 10.0, height: 10.0)
    fileprivate let borderColor = UIColor.black
    fileprivate var dotViews = [UIView]()
    
    convenience init(frame: CGRect, completion:@escaping (_ password: String) ->Void) {
        self.init(frame: frame)
        self.completion = completion
        setupSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubViews()
    }
    
    /// 输入框内容改变
    @objc fileprivate func textFieldDidChange() {
        let textFieldText = textField.text! as NSString
        
        shouDotViews(count: textFieldText.length)
        /// 输入完成
        if textFieldText.length == passwordCount {
            if completion != nil {
                ///
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                    self.completion!(self.textField.text ?? "")
                    self.clearUpPassword()
                }
            }
        }
    }
    
    /// 清除密码
    func clearUpPassword() {
        textField.text = ""
        shouDotViews(count: 0)
    }
    
    /// 显示黑点
    ///
    /// - Parameter count: 显示个数
    fileprivate func shouDotViews(count: NSInteger) {
        for dotView in dotViews {
            dotView.isHidden = true
        }
        for i in 0..<count {
            dotViews[i].isHidden = false
        }
    }
    
    fileprivate func setupSubViews() {
        
        self.backgroundColor = UIColor.white
        
        textField = UITextField(frame: self.bounds)
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.delegate = self
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad;
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.addSubview(textField)
        
        let textFieldCoverView = UIView(frame: self.bounds)
        textFieldCoverView.isUserInteractionEnabled = false
        textFieldCoverView.layer.borderColor = borderColor.cgColor
        textFieldCoverView.layer.borderWidth = 1.0
        self.addSubview(textFieldCoverView)
        
        /// 分割线
        let itemWidth = self.frame.size.width / CGFloat(passwordCount)
        let itemHeight = self.frame.size.height
        for i in 0..<passwordCount - 1 {
            let lineView = UIView(frame: CGRect(x: itemWidth + itemWidth * CGFloat(i), y: 0.0, width: 1, height: itemHeight))
            lineView.backgroundColor = borderColor
            self.addSubview(lineView)
        }
        /// 黑点
        for i in 0..<passwordCount {
            let dotView = UIView(frame: CGRect(x: (itemWidth - dotSize.width) / 2 + itemWidth * CGFloat(i), y: (itemHeight - dotSize.width) / 2, width: dotSize.width, height: dotSize.height))
            dotView.layer.cornerRadius = dotSize.width / 2
            dotView.layer.masksToBounds = true
            dotView.backgroundColor = UIColor.black
            dotView.isHidden = true
            self.addSubview(dotView)
            dotViews.append(dotView)
        }
    }
}

// MARK: - UITextFieldDelegate
extension LKPasswordView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let replacementString = string as NSString
        let textFieldText = textField.text! as NSString
        
        if string == "\n" {
            /// 按回车关闭键盘
            textField.resignFirstResponder()
            return false
        } else if replacementString.length == 0 {
            /// 判断是不是删除键
            return true
        } else if textFieldText.length >= passwordCount {
            /// 输入的字符个数大于6，则无法继续输入，返回false表示禁止输入
            return false
        } else {
            return true
        }
    }
}
