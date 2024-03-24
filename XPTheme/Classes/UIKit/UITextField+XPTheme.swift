//
//  UITextField+XPTheme.swift
//  XPTheme
//
//  Created by lixiaoping on 2023/5/16.
//

import Foundation

public extension UITextField {
    struct key {
        static  var xpTextColor = "xpTextColor"
        
    }
    
    /// 设置字体
    var xpTextColor: XPThemeColor? {
        get {
            objc_getAssociatedObject(self, &key.xpTextColor) as? XPThemeColor
        }
        set {
            textColor = newValue?.color?()
            objc_setAssociatedObject(self, &key.xpTextColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateTextColor))
        }
    }
    
    @objc func updateTextColor() {
        if let xpTextColor = xpTextColor {
            self.textColor = xpTextColor.color?()
        }
    }
}
