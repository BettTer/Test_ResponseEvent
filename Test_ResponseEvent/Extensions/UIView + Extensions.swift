//
//  Adasda.swift
//  Test_ResponseEvent
//
//  Created by tianw on 2021/2/5.
//  Copyright © 2021 Young Robine. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 获取当前View的横坐标
    public func x() -> CGFloat {
        return self.frame.origin.x
    }
    
    /// 获取当前View的纵坐标
    public func y() -> CGFloat {
        return self.frame.origin.y
    }
    
    /// 获取当前View的宽
    public func width() -> CGFloat {
        return self.frame.width
    }
    
    /// 获取当前View的高
    public func height() -> CGFloat {
        return self.frame.height
    }
    
    /// 获取当前View底部的CGFloat
    public func getBottom() -> CGFloat {
        return self.frame.origin.y + self.frame.height
    }
    
    /// 当前View截图 (是否不透明)
    @objc public func normalShot(isOpaque: Bool, scale: CGFloat) -> UIImage {
        // 参数①：截屏区域  参数②：是否透明  参数③：清晰度
        UIGraphicsBeginImageContextWithOptions(self.frame.size, isOpaque, scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return image;
    }
    
    /// 特殊View(渲染类)截图
    public func offScreenshot(isOpaque: Bool, scale: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, isOpaque, scale)
        _ = self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    /// 添加阴影
    private func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = true
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    /// 抖动方向
    public enum ShakeDirection: Int{
        /// 水平
        case horizontal
        /// 垂直
        case vertical
    }
    
    /// - Parameters:
    ///   - direction: 抖动方向（默认是水平方向）
    ///   - times: 抖动次数（默认5次）
    ///   - interval: 每次抖动时间（默认0.1秒）
    ///   - delta: 抖动偏移量（默认2）
    ///   - completion: 抖动动画结束后的回调
    /// UIView的抖动方法
    private func shake(direction: ShakeDirection = .horizontal, times: Int = 16, interval: TimeInterval = 0.01, delta: CGFloat = 3.5, completion: (() -> Void)? = nil)
    {
        UIView.animate(withDuration: interval, animations: {
            
            switch direction
            {
            case .horizontal:
                self.layer.setAffineTransform(CGAffineTransform(translationX: delta, y: 0))
            case .vertical:
                self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: delta))
            }
        }) { (finish) in
            
            if times == 0
            {
                UIView.animate(withDuration: interval, animations: {
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (finish) in
                    completion?()
                })
            }
            else
            {
                self.shake(direction: direction, times: times - 1, interval: interval, delta: -delta, completion: completion)
            }
        }
    }
    
}

extension UIView {
    static private var BorderLayersKey = "BorderLayersKey"
    
    private var borderLayers: [CAShapeLayer]? {
        set {
            objc_setAssociatedObject(self, &UIView.BorderLayersKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
        get {
            return objc_getAssociatedObject(self, &UIView.BorderLayersKey) as! [CAShapeLayer]?
            
        }
    }
    

    /// 同时设置圆角与外边框
    /// - Parameters:
    ///   - size: 最终大小
    ///   - corners: 圆角的部位
    ///   - radii: 圆角半径(⚠️: 大于高的一半时会失效)
    ///   - borderColor: 边框颜色
    ///   - borderWidth: 边框宽度
    public func setCornerAndBorder(
        targetSize: CGSize? = nil,
        byRoundingCorners corners: UIRectCorner?,
        radii: CGFloat?,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil) {
        
        if let maskLayer = self.layer.mask {
            maskLayer.removeFromSuperlayer()
            self.layer.mask = nil
            
        }
        
        var size: CGSize = .zero
        
        if let beingSize = targetSize {
            size = beingSize
            
        }else {
            size = self.bounds.size
            
        }
        
        let needCorners: Bool = (corners != nil)
        let needBorder: Bool = (borderColor != nil)
        
        if needCorners == false && needBorder == false  {
            return
            
        }
        
        /// 遮罩线
        var maskPath: UIBezierPath
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        if needCorners {
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners!, cornerRadii: CGSize(width: radii!, height: radii!))
            
        }else {
            maskPath = UIBezierPath(rect: bounds)
            
        }
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        if needBorder {
            
            // * 如果有之前的 先清掉
            if let _ = borderLayers {
                for borderLayer in borderLayers! {
                    borderLayer.removeFromSuperlayer()
                    
                }
                
                borderLayers!.removeAll()
            }
            
            borderLayers = []
            
            /// 边框线
            let borderPath = UIBezierPath.init(rect: bounds)
            self.setBorder(byRoundingPath: borderPath, color: borderColor!, width: borderWidth! * 2)
            
            if needCorners {
                
                if corners!.contains(.bottomRight) {
                    let arcCenter = CGPoint.init(
                        x: bounds.width - radii!,
                        y: bounds.height - radii!)
                    let bottomRightCornerPath = UIBezierPath.init(arcCenter: arcCenter, radius: radii!, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
                    self.setBorder(byRoundingPath: bottomRightCornerPath, color: borderColor!, width: borderWidth! * 2)
                }
                
                if corners!.contains(.bottomLeft) {
                    let arcCenter = CGPoint.init(
                        x: radii!,
                        y: bounds.height - radii!)
                    let bottomRightCornerPath = UIBezierPath.init(arcCenter: arcCenter, radius: radii!, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
                    self.setBorder(byRoundingPath: bottomRightCornerPath, color: borderColor!, width: borderWidth! * 2)
                }

                if corners!.contains(.topLeft) {
                    let arcCenter = CGPoint.init(
                        x: radii!,
                        y: radii!)
                    let bottomRightCornerPath = UIBezierPath.init(arcCenter: arcCenter, radius: radii!, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: true)
                    self.setBorder(byRoundingPath: bottomRightCornerPath, color: borderColor!, width: borderWidth! * 2)


                }

                if corners!.contains(.topRight) {
                    let arcCenter = CGPoint.init(
                        x: bounds.width - radii!,
                        y: radii!)
                    let bottomRightCornerPath = UIBezierPath.init(arcCenter: arcCenter, radius: radii!, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: true)
                    self.setBorder(byRoundingPath: bottomRightCornerPath, color: borderColor!, width: borderWidth! * 2)
                }
                
            }
            
        }
        
        
    }
    
    /// 添加边框
    private func setBorder(
        byRoundingPath path: UIBezierPath, color: UIColor, width: CGFloat) -> Void {
        
        /// 边框Layer
        let borderShapeLayer = CAShapeLayer.init()
        borderShapeLayer.path = path.cgPath
        
        borderShapeLayer.strokeColor = color.cgColor
        borderShapeLayer.fillColor = UIColor.clear.cgColor
        borderShapeLayer.lineWidth = width
        
        self.layer.addSublayer(borderShapeLayer)
        
        if let _ = borderLayers {
            borderLayers!.append(borderShapeLayer)
            
        }
        
    }
    
    
}


extension CALayer {
    
    /// 设置常用属性
    ///
    /// - Parameters:
    ///   - cornerRadius: 圆角值
    ///   - borderColor: 边框颜色
    ///   - borderWidth: 边框宽
    public func setCommonProperties(cornerRadius: CGFloat?,
                                    borderColor: UIColor?,
                                    borderWidth: CGFloat?) -> Void {
        
        self.masksToBounds = true
        
        if let radius = cornerRadius {
            self.cornerRadius = radius
            
        }
        
        if let color = borderColor {
            self.borderColor = color.cgColor
            self.borderWidth = borderWidth!
        }
        
    }
    
}
