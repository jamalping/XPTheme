//
//  UIButton+XPTheme.swift
//  XPTheme
//
//  Created by lixiaoping on 2022/10/31.
//
//// import AAExtension
public extension UIButton {
    struct Key {
        static  var xpImageColor = "buttonxpImageColor"
        static  var xpThemeImage = "xpThemeImage"
        static  var xpTextColor = "buttonxpTextColor"
        static  var xpButtonBackgroundColor = "xpButtonBackgroundColor"
        
    }
    
    /// 设置图片以及背景色
    var xpImageColor: XPThemeImageColor? {
        get {
            objc_getAssociatedObject(self, &Key.xpImageColor) as? XPThemeImageColor
        }
        set {

            setterImage(imageAndColor: newValue)
            
            objc_setAssociatedObject(self, &Key.xpImageColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateGradientImageColors))
        }
    }
    
    @objc func updateGradientImageColors() {
        setterImage(imageAndColor: xpImageColor)
    }
    
    fileprivate func setterImage(imageAndColor: XPThemeImageColor?) {
        guard let imageColor = imageAndColor?.imageColorCallbacK() else {return}
        let colorArr1 = imageColor.normalColors
        
        let normalImage1 = imageColor.normalImage.xp_gradientColor(colorArr1.first!, endColor: colorArr1.last!, size: imageColor.normalImage.size, direction: imageColor.direction)
        self.setImage(normalImage1, for: .normal)
        
        if let selectImage = imageColor.selectImage, let colorArr2 = imageColor.selectColors {
            let normalImage2 = selectImage.xp_gradientColor(colorArr2.first!, endColor: colorArr2.last!, size: selectImage.size, direction: imageColor.direction)
            self.setImage(normalImage2, for: .selected)
        }
    }
}

public extension UIButton {
    var xpThemeImage: XPControlThemeImage? {
        get {
            objc_getAssociatedObject(self, &Key.xpThemeImage) as? XPControlThemeImage
        }
        set {
            /// 把数据存起来，方便后续取数据
            if let newValue = newValue {
                var themeImages = XPControlThemeManage.shared.stateThemeImageDic[self] ?? [XPControlThemeImage]()
                /// 移除旧的
                themeImages.removeAll { themeImage in
                    themeImage.state == newValue.state
                }
                themeImages.append(newValue)
                XPControlThemeManage.shared.stateThemeImageDic[self] = themeImages
            }
            setterThemeImage(themeImage: newValue)
            objc_setAssociatedObject(self, &Key.xpThemeImage, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateThemeImageColor))
        }
    }
    
    @objc func updateThemeImageColor() {
        if let xp = XPControlThemeManage.shared.stateThemeImageDic[self] {
            let vthemeImage = xp.last { themeImage in
                return themeImage.state == self.state
            }
            setterThemeImage(themeImage: vthemeImage)
        }
    }
    
    fileprivate func setterThemeImage(themeImage: XPControlThemeImage?) {
        guard let image = themeImage?.imageThemeCallback?() else {return}
        guard let colorsCallback = themeImage?.gradientColorsCallbacK?() else {return}
        let state = themeImage?.state ?? .normal
        let colorArr1 = colorsCallback.colors
        
        let normalImage1 = image.xp_gradientColor(colorArr1.first!, endColor: colorArr1.last!, size: image.size, direction: GradientDirection.init(rawValue: colorsCallback.direction.rawValue) ?? .bottom)
        self.setImage(normalImage1, for: state)
    }
    
    var xpTextColor: XPControlThemeColor? {
        get {
            objc_getAssociatedObject(self, &Key.xpTextColor) as? XPControlThemeColor
        }
        set {
            if let newValue = newValue {
                var themeColors = XPControlThemeManage.shared.stateThemeColorDic[self] ?? [XPControlThemeColor]()
                
                themeColors.removeAll { themeColor in
                    themeColor.state == newValue.state
                }
                themeColors.append(newValue)
                XPControlThemeManage.shared.stateThemeColorDic[self] = themeColors
            }
            if let color = newValue?.color?(), let state = newValue?.state {
                self.setTitleColor(color, for: state)
            }
            
            objc_setAssociatedObject(self, &Key.xpTextColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateTextColors))
        }
    }
    
    @objc func updateTextColors() {
        if let colors = XPControlThemeManage.shared.stateThemeColorDic[self] {
            let vthemeColor = colors.last { themeColor in
                return themeColor.state == self.state
            }
            if let color = vthemeColor?.color?(), let state = vthemeColor?.state {
                self.setTitleColor(color, for: state)
                
            }
        }
    }
    
    var xpButtonBackgroundColor: XPControlThemeColor? {
        get {
            objc_getAssociatedObject(self, &Key.xpButtonBackgroundColor) as? XPControlThemeColor
        }
        set {
            if let newValue = newValue {
                var themeColors = XPControlThemeManage.shared.stateThemeColorDic[self] ?? [XPControlThemeColor]()
                
                themeColors.removeAll { themeColor in
                    themeColor.state == newValue.state
                }
                themeColors.append(newValue)
                XPControlThemeManage.shared.stateThemeColorDic[self] = themeColors
            }
            
            if let color = newValue?.color?(), let state = newValue?.state {
                
                self.setBackgroundImage(UIImage.init(color: color), for: state)
            }
            
            objc_setAssociatedObject(self, &Key.xpButtonBackgroundColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateButtonBackgroundColor))
        }
    }
    
    @objc func updateButtonBackgroundColor() {
        if let colors = XPControlThemeManage.shared.stateThemeColorDic[self] {
            let vthemeColor = colors.last { themeColor in
                return themeColor.state == self.state
            }
            
            if let color = vthemeColor?.color?(), let state = vthemeColor?.state {
                self.setBackgroundImage(UIImage.init(color: color), for: state)
            }
        }
    }
    
    var xpButtonBackgroundGradientColor: XPControlThemeGradientColor? {
        get {
            objc_getAssociatedObject(self, &Key.xpButtonBackgroundColor) as? XPControlThemeGradientColor
        }
        set {
//            if let colors = newValue?.gradientColors().colors, let state = newValue?.state {
//
//                let gFirstColor = colors.first ?? .white
//                let gLastColor = colors.last ?? .white
//
//                let direction = newValue?.gradientColors().direction ?? .bottom
//
//                self.layoutIfNeeded()
//
//                let gradientColor = UIColor.gradientColor(gFirstColor, toColor: gLastColor, size: self.size, direction: direction) ?? .white
//
//                self.setBackgroundImage(UIImage.init(color: gradientColor), for: state)
//            }
            updateButtonBackgroundGradientColor()
            
            objc_setAssociatedObject(self, &Key.xpButtonBackgroundColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateButtonBackgroundGradientColor))
        }
    }
    
    @objc func updateButtonBackgroundGradientColor() {
        if let colors = xpButtonBackgroundGradientColor?.gradientColors().colors, let state = xpButtonBackgroundGradientColor?.state {
            
            let gFirstColor = colors.first ?? .white
            let gLastColor = colors.last ?? .white
            
            let direction = xpButtonBackgroundGradientColor?.gradientColors().direction ?? .bottom

            self.layoutIfNeeded()
            
            let gradientColor = UIColor.xp_gradientColor(gFirstColor, toColor: gLastColor, size: self.frame.size, direction: direction) ?? .white
            
            self.setBackgroundImage(UIImage.init(color: gradientColor), for: state)
        }
    }
    
}
