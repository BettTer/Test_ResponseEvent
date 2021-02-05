//
//  Sasdasd.swift
//  Test_ResponseEvent
//
//  Created by tianw on 2021/2/5.
//  Copyright © 2021 Young Robine. All rights reserved.
//

import UIKit

extension String {
    public func cutWithPlaces(startPlace: Int,
                              endPlace: Int,
                              file: String = #file,
                              method: String = #function,
                              line: Int = #line) -> String {
        if self == "" {
            return ""
            
        }else {
            let startIndex = self.index(self.startIndex, offsetBy: startPlace)
            let endIndex = self.index(startIndex, offsetBy: endPlace - startPlace)
            
            return String(self[startIndex ..< endIndex])
        }
        
    }
    
    /// 生成一个随机字符串
    static public func random(_ count: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        var ranStr = ""
        for _ in 0 ..< count {
            let index = Int.random(in: 0 ..< characters.count)
            ranStr.append(characters[characters.index(characters.startIndex, offsetBy: index)])
            
        }
        
        return ranStr
    }// funcEnd
    
    /// 使用正则表达式替换
    public func pregReplace(pattern: String?, with: String,
                            options: NSRegularExpression.Options = []) -> String {
        
        /// 只留汉字的正则表达式
        let OnlyChinesePattern = "[^\\u4E00-\\u9FA5]"
        
        
        let regex = try! NSRegularExpression(pattern: OnlyChinesePattern, options: options)
        
        let resultString = regex.stringByReplacingMatches(in: with, options: [],
                                                          range: NSMakeRange(0, with.count),
                                                          withTemplate: with)
        
        return resultString
    }
    
    /// 去除Emoji表情
    public func stringByRemovingEmoji() -> String {
        return String(self.filter { !$0.isEmoji() })
    }
    
    /// range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
}

extension String {
    /// 计算文本高度
    /// - Parameters:
    ///   - font: 字体
    ///   - isSingleLine: 是否为单行
    ///   - textWidth: 内容宽度
    /// - Returns: 高度
    public func calculateTextHeight(font: UIFont, isSingleLine: Bool, textWidth: CGFloat) -> CGFloat {
        var width: CGFloat = 0
        
        if isSingleLine != true {
            width = textWidth
            
        }
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return rect.size.height
        
    }
    
}

extension Character {
    fileprivate func isEmoji() -> Bool {
        return Character(UnicodeScalar(UInt32(0x1d000))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f77f))!)
            || Character(UnicodeScalar(UInt32(0x2100))!) <= self && self <= Character(UnicodeScalar(UInt32(0x26ff))!)
    }
}
