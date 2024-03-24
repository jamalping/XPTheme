//
//  UIImage+XPTheme.swift
//  XPTheme
//
//  Created by lixiaoping on 2022/10/19.
//


// import AAExtension

public extension UIImageView {
    struct Key {
        static var xpImageRiseFallColor = "xpImageRiseFallColor"
        static var xpImageColor = "xpImageColor"
    }
    
    /// 设置图片以及涨跌色
    var xpImageRiseFallColor: XPThemeRiseFallImageColor? {
        get {
            objc_getAssociatedObject(self, &Key.xpImageRiseFallColor) as? XPThemeRiseFallImageColor
        }
        set {

            setterImage(riseFallImageColor: newValue)
            
            objc_setAssociatedObject(self, &Key.xpImageRiseFallColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addObserver(#selector(updateRiseFallGradientImageColors))
        }
    }
    
    @objc func updateRiseFallGradientImageColors() {
        setterImage(riseFallImageColor: xpImageRiseFallColor)
    }
    
    fileprivate func setterImage(riseFallImageColor: XPThemeRiseFallImageColor?) {
        guard let riseFallImageColor = riseFallImageColor?.riseFallImageColorCallbacK() else {return}
        var colors: [UIColor] = riseFallImageColor.riseColors
        switch AAQCChartUIManager.shared.lineColorStyle {
        case .redRise:
            colors = riseFallImageColor.riseColors
        case .greenRise:
            colors = riseFallImageColor.fallColors
        }
        if let first = colors.first, let end = colors.last {
            
            self.image = riseFallImageColor.image.xp_gradientColor(first, endColor: end, size: riseFallImageColor.image.size, direction: riseFallImageColor.direction)
        }
    }
    
}

public extension UIImageView {

    /// 设置图片以及背景色
    var xpImageColor: XPThemeImageColor? {
        get {
            objc_getAssociatedObject(self, &UIImageView.Key.xpImageColor) as? XPThemeImageColor
        }
        set {

            setterImage(imageAndColor: newValue)

            objc_setAssociatedObject(self, &UIImageView.Key.xpImageColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
        self.image = normalImage1
    
    }
}

extension UIImage {
    func xp_gradientColor(_ startColor: UIColor, endColor: UIColor, size: CGSize, direction: GradientDirection = GradientDirection.right) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.setBlendMode(.normal)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [startColor.cgColor, endColor.cgColor]

        guard let gradient: CGGradient = CGGradient.init(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil) else { return nil }

        var startPoint: CGPoint
        var endPoint: CGPoint
        switch direction {
        case .left:
            startPoint = CGPoint.init(x: size.width, y: 0.0)
            endPoint = CGPoint.init(x: 0.0, y: 0.0)
        case .right:
            startPoint = CGPoint.init(x: 0.0, y: 0.0)
            endPoint = CGPoint.init(x: size.width, y: 0.0)
        case .bottom:
            startPoint = CGPoint.init(x: 0.0, y: 0.0)
            endPoint = CGPoint.init(x: 0.0, y: size.height)
        case .top:
            startPoint = CGPoint.init(x: 0.0, y: size.height)
            endPoint = CGPoint.init(x: 0.0, y: 0.0)
        case .topLeftToBottomRight:
            startPoint = CGPoint.init(x: 0.0, y: 0.0)
            endPoint = CGPoint.init(x: size.width, y: size.height)
        case .topRightToBottomLeft:
            startPoint = CGPoint.init(x: size.width, y: 0.0)
            endPoint = CGPoint.init(x: 0.0, y: size.height)
        case .bottomLeftToTopRight:
            startPoint = CGPoint.init(x: 0.0, y: size.height)
            endPoint = CGPoint.init(x: size.width, y: 0.0)
        case .bottomRightToTopLeft:
            startPoint = CGPoint.init(x: size.width, y: size.height)
            endPoint = CGPoint.init(x: 0.0, y: 0.0)
        }
        guard (self.cgImage != nil) else { return  nil }
        context?.clip(to: CGRect.init(origin: CGPoint.zero, size: size), mask: self.cgImage!)
        context?.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}


public extension UIImage {
    convenience init(color: UIColor) {
       let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
       UIGraphicsBeginImageContext(rect.size)
       let context = UIGraphicsGetCurrentContext()
       context?.setFillColor(color.cgColor)
       context?.fill(rect)
       let image = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       self.init(cgImage: (image?.cgImage)!)
   }
}
