//
//  ChangePayPassword.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/10/25.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ChangePayPassword: UIViewController {
    @IBOutlet weak var InputContentView: UIView!
    
    @IBOutlet weak var successView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordInputView: LKPasswordView!
    @IBOutlet weak var forgetPwButton: UIButton!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "修改支付密码"
        var count = 0
        var isForgetBtnHidden = false
        var inputTitle = "请输入旧密码"
        successView.isHidden = true
        InputContentView.isHidden = false
        passwordInputView.completion = { [weak self] (password) in
            count = count + 1
            
            if count == 1 {
                isForgetBtnHidden = true
                inputTitle = "请输入新密码"
            } else if count == 2 {
                isForgetBtnHidden = true
                inputTitle = "请确认新密码"
                
            } else {
                self?.title = nil
                self?.passwordInputView.isHidden = true
                self?.titleLabel.isHidden = true
                self?.forgetPwButton.isHidden = true
                
                self?.successView.isHidden = false
                self?.InputContentView.isHidden = true
                self?.view.endEditing(true)
            }
            self?.forgetPwButton.isHidden = isForgetBtnHidden
            self?.titleLabel.text = inputTitle
            print("输入密码为：\(password)")
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
    @IBAction func forgetButtonEvent(_ sender: Any) {
        debugPrint(#function)
    }
    @IBAction func useNewPasswordToLogin(_ sender: Any) {
        debugPrint(#function)
    }
    deinit {
        print(self.description + "deinit")
    }
}

