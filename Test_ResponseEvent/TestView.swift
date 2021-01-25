//
//  TestView.swift
//  Test_ResponseEvent
//
//  Created by Young Robine on 2020/5/6.
//  Copyright © 2020 Young Robine. All rights reserved.
//

import UIKit

class TestView: UIView {
    lazy var button: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(button)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addSubview(button)
    }
    
    
    

}

extension TestView {
    /// 如何扩大view的响应范围 / 穿透 / ...
    /// ⚠️: 一次触摸会被调用三次
    /// - Parameters:
    ///   - point: 触摸点
    ///   - event: 点击事件
    /// - Returns: 处理该点击事件的View
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
//        // * 三种情况会为空
//        // * - 不接收用户交互: userInteractionEnabled = NO
//        // * - 隐藏: hidden = YES
//        // * - 透明: alpha = 0.0 ~ 0.01
//        if event == nil {
//
//
//        }else {
//            let systemTimeInterval = ProcessInfo.processInfo.systemUptime
//
//            if systemTimeInterval - event!.timestamp > 0.1 { // * not the event we were interested in
//
//            }else { // * use this call
//
//
//            }
//
//        }
        
        let targetView = super.hitTest(point, with: event)
        
        // * 转换坐标系
        let buttonPoint = button.convert(point, to: self)
        
        // * 如果触摸点在button的内部, 则把事件交给button处理
        if button.point(inside: buttonPoint, with: event) {
            return button
            
        }else {
            return targetView
            
        }
        
    }
    
    
}
