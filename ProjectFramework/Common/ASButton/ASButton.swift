//
//  ASButton.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/9.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ASButton: UIView {
    /// 边框颜色
    var borderColor: UIColor = .gray {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            line1.backgroundColor = borderColor
            line2.backgroundColor = borderColor
        }
    }
    /// 边框宽度
    fileprivate let kBorderWidth: CGFloat = 0.5
    
    fileprivate lazy var addButton = UIButton.as_textButton(title: "+", fontSize: 13.0, normalColor: .gray, heightlightedColor: .darkGray)
    fileprivate lazy var subtractButton = UIButton.as_textButton(title: "-", fontSize: 13.0, normalColor: .gray, heightlightedColor: .darkGray)
    fileprivate lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 13.0)
        textField.text = "1"
        return textField
    }()
    fileprivate lazy var line1: UIView = {
       let line = UIView()
        line.backgroundColor = self.borderColor
        return line
    }()
    fileprivate lazy var line2: UIView = {
        let line = UIView()
        line.backgroundColor = self.borderColor
        return line
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubViews()
    }
    
    func textValue() -> String {
        return numberTextField.text ?? "1"
    }
    
}

// MARK: - Event
extension ASButton {
    
    @objc fileprivate func addButtonEvent() {
        var text = numberTextField.text
        if text == "" {
            text = "0"
        }
        
        guard let ktext = text else {
            numberTextField.text = "1"
            return
        }
        var number = Int(ktext)!
        number = number + 1
        if number >= 999 {
            number = 999
        }
        numberTextField.text = String(number)
    }
    
    @objc fileprivate func subtractButtonEvent() {
        var text = numberTextField.text
        if text == "" || text == "0" {
            text = "1"
        }
        guard let ktext = text else {
            numberTextField.text = "1"
            return
        }
        var number = Int(ktext)!
        number = number - 1
        if number <= 1 {
            number = 1
        }
        numberTextField.text = String(number)
    }
}

// MARK: - UI
extension ASButton {
    
    fileprivate func setupSubViews() {
        addSubview(addButton)
        addSubview(subtractButton)
        addSubview(numberTextField)
        addSubview(line1)
        addSubview(line2)
        
        self.layer.cornerRadius = 2.0
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = kBorderWidth
        
        addButton.addTarget(self, action: #selector(addButtonEvent), for: .touchUpInside)
        subtractButton.addTarget(self, action: #selector(subtractButtonEvent), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var rect = self.bounds
        rect.size.width = rect.size.width / 4
        subtractButton.frame = rect
        
        rect.origin.x = rect.size.width
        rect.size.width = kBorderWidth
        line1.frame = rect
        
        rect.origin.x = rect.origin.x + rect.size.width
        rect.size.width = self.bounds.size.width / 2 - kBorderWidth * 2.0
        numberTextField.frame = rect
        
        rect.origin.x = rect.origin.x + rect.size.width
        rect.size.width = kBorderWidth
        line2.frame = rect
        
        rect.origin.x = rect.origin.x + rect.size.width
        rect.size.width = self.bounds.size.width / 4
        addButton.frame = rect
    }
}

// MARK: - UITextFieldDelegate
extension ASButton: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var oText = textField.text
        oText?.append(string)
        let ocText = oText! as NSString
        
        if ocText.length > 3 || (ocText.length == 1 && string == "0") {
            return false
        }
        return true
    }
}

// MARK: - 创建按钮
extension UIButton {
    /// 创建文本按钮
    ///
    /// - Parameters:
    ///   - title: 标题文字
    ///   - fontSize: 字体大小
    ///   - normalColor: 默认字体颜色
    ///   - heightlightedColor: 高亮字体颜色
    /// - Returns: 实例
    class func as_textButton(title: String, fontSize: CGFloat, normalColor: UIColor, heightlightedColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(heightlightedColor, for: .highlighted)
        return button
    }
}
