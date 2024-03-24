//
//  CALayer+XPTheme.swift
//  XPTheme
//
//  Created by lixiaoping on 2022/10/19.
//

import Foundation
public extension CALayer {
    struct key {
        static  var xpBorderColor = "xpBorderColor"
        static  var gradientColors = "gradientColors"
        static  var xpShadowColor = "xpShadowColor"
        
    }
    
    var xpBorderColor: XPThemeColor? {
        get {
            objc_getAssociatedObject(self, &key.xpBorderColor) as? XPThemeColor
        }
        set {
            guard let cgColor = newValue?.color?().cgColor else { return }
            borderColor = cgColor
            objc_setAssociatedObject(self, &key.xpBorderColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateBorderColor))
        }
    }
    
    @objc func updateBorderColor() {
        if let cgColor = xpBorderColor?.color?().cgColor {
            self.borderColor = cgColor
        }
    }
    var xpShadowColor: XPThemeColor? {
        get {
            objc_getAssociatedObject(self, &key.xpShadowColor) as? XPThemeColor
        }
        set {
            guard let cgColor = newValue?.color?().cgColor else { return }
            shadowColor = cgColor
            objc_setAssociatedObject(self, &key.xpShadowColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateShadowColor))
        }
    }
    
    @objc func updateShadowColor() {
        if let cgColor = xpBorderColor?.color?().cgColor {
            self.shadowColor = cgColor
        }
    }
    
}

public extension CAShapeLayer {
    struct key {
        static  var xpfillColor = "xpfillColor"
        static  var gradientColors = "gradientColors"
        
    }
    
    var xpfillColor: XPThemeColor? {
        get {
            objc_getAssociatedObject(self, &key.xpfillColor) as? XPThemeColor
        }
        set {
            guard let cgColor = newValue?.color?().cgColor else { return }
            fillColor = cgColor
            objc_setAssociatedObject(self, &key.xpfillColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateFillColor))
        }
    }
    
    @objc func updateFillColor() {
        if let cgColor = xpfillColor?.color?().cgColor {
            self.borderColor = cgColor
        }
    }
}
