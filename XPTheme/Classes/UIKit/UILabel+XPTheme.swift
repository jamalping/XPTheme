//
//  UILabel+XPTheme.swift
//  XPTheme
//
//  Created by lixiaoping on 2022/10/18.
//

import Foundation
public extension UILabel {
    struct key {
        static  var xpRiseFallColor = "xpRiseFallColor"
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
    
    /// 设置涨跌字体颜色
    var xpRiseFallColor: XPThemeRiseFallColor? {
        get {
            objc_getAssociatedObject(self, &key.xpRiseFallColor) as? XPThemeRiseFallColor
        }
        set {
            setRiseFallColor(newValue)
            
            objc_setAssociatedObject(self, &key.xpRiseFallColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateRiseFallColor))
        }
    }
    
    @objc func updateRiseFallColor() {
        setRiseFallColor(self.xpRiseFallColor)
    }
    
    func setRiseFallColor(_ riseFallColor: XPThemeRiseFallColor?) {
        switch AAQCChartUIManager.shared.lineColorStyle {
        case .redRise:
            textColor = riseFallColor?.riseFallColor?().riseColor
        case .greenRise:
            textColor = riseFallColor?.riseFallColor?().fallColor
        }
    }
    
    
}
