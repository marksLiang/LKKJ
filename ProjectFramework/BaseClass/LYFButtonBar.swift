//
//  LYFButtonBar.swift
//  RepairCar
//
//  Created by 梁元峰 on 2017/8/16.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class LYFButtonBar: UIView {
    typealias CallbackValue=(_ value:Int)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    
    var currentBtn = UIButton()
    var normalColor = UIColor()
    var currentColor = UIColor()
    init(frame:CGRect,font:UIFont,normalColor:UIColor,selectColor:UIColor,textArray:Array<String>,Callback_SelectedValue:CallbackValue?) {
        self.myCallbackValue = Callback_SelectedValue
        self.currentColor = selectColor
        self.normalColor = normalColor
        super.init(frame: frame)
        for i in 0..<textArray.count {
            let title = textArray[i]
            let button = UIButton.init(type: .system)
            let frame_x = CGFloat((frame.width/CGFloat(textArray.count))*CGFloat(i))
            button.frame = CommonFunction.CGRect_fram(frame_x, y:0, w:frame.width / CGFloat(textArray.count) , h: frame.height - 5)
            button.tag = i
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = font
            button.setTitleColor(normalColor, for: .normal)
            
            button.addTarget(self, action:#selector(headerClick), for: .touchUpInside)
            
            if (i == 0) {
                button.setTitleColor(selectColor, for: .normal)
                self.currentBtn = button
                let bottomLine = UIView()
                bottomLine.tag = 666
                bottomLine.frame = CommonFunction.CGRect_fram(0, y: button.frame.maxY, w: 50, h: 2)
                bottomLine.center.x = button.center.x
                bottomLine.backgroundColor = selectColor
                self.addSubview(bottomLine)
            }
            self.addSubview(button)

        }
    }
    func headerClick(_ button: UIButton) -> Void {
        UIView.animate(withDuration: 0.3) {
            let line = self.viewWithTag(666)
            line?.center.x = button.center.x
            button.setTitleColor(self.currentColor, for: .normal)
            self.currentBtn.setTitleColor(self.normalColor, for: .normal)
            self.currentBtn = button
        }
        if myCallbackValue != nil {
            myCallbackValue!(button.tag)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
