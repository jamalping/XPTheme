//
//  XPThemeColor.swift
//  XPTheme
//
//  Created by lixiaoping on 2022/10/17.
//

import UIKit
//// import AAExtension
//import AAFontSize

/// 设置单个颜色
public typealias ColorCallbacK = (() -> UIColor)
/// 设置单个图片
public typealias ImageThemeCallback = (() -> UIImage)
/// 设置渐变色
public typealias GradientColorsCallbacK = (() -> (colors: [UIColor], direction: GradientDirection))
/// 设置图片，涨跌色（支持渐变）
public typealias RiseFallImageColorCallbacK = (() -> (image: UIImage, riseColors: [UIColor], fallColors: [UIColor], direction: GradientDirection))
/// 设置按钮图片色（支持渐变）
public typealias ImageColorCallbacK = (() -> (normalImage: UIImage, normalColors: [UIColor], selectImage: UIImage?,selectColors: [UIColor]?, direction: GradientDirection))
/// 设置涨跌颜色
public typealias RiseFallColorCallbacK = (() -> (riseColor: UIColor, fallColor: UIColor))

public class XPThemeColor {
    /// 获取颜色
    var color: ColorCallbacK?

    init(color: @escaping ColorCallbacK) {
        self.color = color
    }
}

public class XPThemeImage {
    /// 获取颜色
    var imageThemeCallback: ImageThemeCallback?
    
    var gradientColorsCallbacK: GradientColorsCallbacK?

    init(imageThemeCallback: @escaping ImageThemeCallback, gradientColorsCallbacK:@escaping GradientColorsCallbacK) {
        self.imageThemeCallback = imageThemeCallback
        self.gradientColorsCallbacK = gradientColorsCallbacK
    }
}

/// 渐变色
public class XPThemeGradientColors {
    /// 获取颜色数组（作为渐变色）
    var gradientColors: GradientColorsCallbacK
    
    init(gradientColors: @escaping GradientColorsCallbacK) {
        self.gradientColors = gradientColors
    }
}

/// 图片填色渐变色
public class XPThemeRiseFallImageColor {
    /// 获取颜色数组（作为渐变色）
    var riseFallImageColorCallbacK: RiseFallImageColorCallbacK
    
    init(riseFallImageColorCallbacK: @escaping RiseFallImageColorCallbacK) {
        self.riseFallImageColorCallbacK = riseFallImageColorCallbacK
    }
}
/// 图片填色渐变色
public class XPThemeImageColor {
    /// 获取颜色数组（作为渐变色）
    var imageColorCallbacK: ImageColorCallbacK
    
    init(imageColorCallbacK: @escaping ImageColorCallbacK) {
        self.imageColorCallbacK = imageColorCallbacK
    }
}

/// 红绿颜色
public class XPThemeRiseFallColor {
    var riseFallColor: RiseFallColorCallbacK?
    
    init(riseFallColor: RiseFallColorCallbacK? = nil) {
        self.riseFallColor = riseFallColor
    }
}


public class XPControlThemeManage {
    public var stateThemeImageDic = [UIControl: [XPControlThemeImage]]()
    public var stateThemeColorDic = [UIControl: [XPControlThemeColor]]()
    public var stateThemeGradientColorDic = [UIControl: [XPControlThemeGradientColor]]()
    
    public static let shared = XPControlThemeManage()
}

public class XPControlThemeColor: XPThemeColor {
    /// 按钮状态
    var state :UIControl.State
    
    public init(state: UIControl.State, colorCallback: @escaping ColorCallbacK) {
        self.state = state
        super.init(color: colorCallback)
    }
}

public class XPControlThemeImage: XPThemeImage {
    /// 按钮状态
    var state :UIControl.State
    
    public init(state: UIControl.State, imageThemeCallback: @escaping ImageThemeCallback, gradientColorsCallbacK: @escaping GradientColorsCallbacK) {
        self.state = state
        super.init(imageThemeCallback: imageThemeCallback, gradientColorsCallbacK: gradientColorsCallbacK)
    }
}

public class XPControlThemeGradientColor: XPThemeGradientColors {
    /// 按钮状态
    var state :UIControl.State
    
    public init(state: UIControl.State, gradientColors: @escaping GradientColorsCallbacK) {
        self.state = state
        super.init(gradientColors: gradientColors)
    }
}


/// 获取单个颜色
/// - Parameter themeColor: 颜色闭包

public func themeColor(_ themeColor: @escaping ColorCallbacK) -> XPThemeColor {
    
    return XPThemeColor.init(color: themeColor)
}


/// 获取颜色数组，作为渐变色
public func themeGradientColors(_ gradientColors: @escaping GradientColorsCallbacK) -> XPThemeGradientColors {
    
    return XPThemeGradientColors.init(gradientColors: gradientColors)
}

public func themeRiseFallImageColor(_ riseFallImageColorCallbacK: @escaping RiseFallImageColorCallbacK) -> XPThemeRiseFallImageColor {
    
    return XPThemeRiseFallImageColor.init(riseFallImageColorCallbacK: riseFallImageColorCallbacK)
}

/// 设置涨跌色
public func themeRiseFallColor(_ riseFallColor: @escaping RiseFallColorCallbacK) -> XPThemeRiseFallColor {
    
    return XPThemeRiseFallColor.init(riseFallColor: riseFallColor)
}
/// 设置图片
public func themeImageColor(_ imageColor: @escaping ImageColorCallbacK) -> XPThemeImageColor {
    
    return XPThemeImageColor.init(imageColorCallbacK: imageColor)
}
