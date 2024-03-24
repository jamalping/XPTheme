//
//  UIView+XPTheme.swift
//  AAExtension
//
//  Created by lixiaoping on 2022/10/17.
//

// import AAExtension

public extension UIView {
    struct key {
        static  var backgroundColor = "backgroundColor"
        static  var gradientColors = "gradientColors"
        static  var riseFallBGColor = "riseFallBGColor"
    }
    
    /// 设置背景色
    var xpBackgroundColor: XPThemeColor? {
        get {
            objc_getAssociatedObject(self, &key.backgroundColor) as? XPThemeColor
        }
        set {
            backgroundColor = newValue?.color?()
            objc_setAssociatedObject(self, &key.backgroundColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateBackgroundColor))
        }
    }
    
    @objc func updateBackgroundColor() {
        if let xpBackgroundColor = xpBackgroundColor {
            self.backgroundColor = xpBackgroundColor.color?()
        }
    }
    
    /// 设置渐变色，使用的时候要在布局设置之后调用
    var gradientColors: XPThemeGradientColors? {
        get {
            objc_getAssociatedObject(self, &key.gradientColors) as? XPThemeGradientColors
        }
        set {
            setterGradientColors(gradientColors: newValue)

            objc_setAssociatedObject(self, &key.gradientColors, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateGradientColors))
        }
    }
    
    @objc func updateGradientColors() {
        
        setterGradientColors(gradientColors: gradientColors)
    }
    
    fileprivate func setterGradientColors(gradientColors: XPThemeGradientColors?) {
        guard let gradientColors = gradientColors else { return }
        let gFirstColor = gradientColors.gradientColors().colors.first ?? .white
        let gLastColor = gradientColors.gradientColors().colors.last ?? .white
        
        let direction = gradientColors.gradientColors().direction

        self.layoutIfNeeded()
        
        self.backgroundColor = UIColor.xp_gradientColor(gFirstColor, toColor: gLastColor, size: self.frame.size, direction: direction)
    }
    
    /// 设置涨跌背景颜色
    var xpRiseFallBGColor: XPThemeRiseFallColor? {
        get {
            objc_getAssociatedObject(self, &key.riseFallBGColor) as? XPThemeRiseFallColor
        }
        set {
            setRiseFallBGColor(newValue)
            
            objc_setAssociatedObject(self, &key.riseFallBGColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateRiseFallBGColor))
        }
    }
    
    @objc func updateRiseFallBGColor() {
        setRiseFallBGColor(self.xpRiseFallBGColor)
    }
    
    func setRiseFallBGColor(_ riseFallBGColor: XPThemeRiseFallColor?) {
        switch AAQCChartUIManager.shared.lineColorStyle {
        case .redRise:
            backgroundColor = riseFallBGColor?.riseFallColor?().riseColor
        case .greenRise:
            backgroundColor = riseFallBGColor?.riseFallColor?().fallColor
        }
    }
}
