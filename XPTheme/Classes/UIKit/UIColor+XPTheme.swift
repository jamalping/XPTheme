//
//  UIColor+XPTheme.swift
//  GradientViewDemoSwift
//
//  Created by lixiaoping on 2022/8/18.
//
import UIKit
public extension UIColor {
    ///  color -> hsba
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h*359, s*100, b*100, a)
    }
    ///  hex -> color
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    ///  color -> hex
    func hexRGB() -> String {
        guard let colorComponents = self.cgColor.components else { return "#FFFFFF" }
        return String(format: "#%02x%02x%02x",
                      Int(colorComponents[0]*255.0),
                      Int(colorComponents[1]*255.0),
                      Int(colorComponents[2]*255.0)).uppercased()
    }
    ///  修改color的hue -> color
    static func changeHueColor(hue: CGFloat?,bright: CGFloat?, color: UIColor) -> UIColor  {
        if hue == nil {
            return color
        }
        return UIColor.init(hue: hue!/359.0, saturation:color.hsba.saturation/100.0 , brightness:((bright != nil) ? bright! : color.hsba.brightness)/100.0  , alpha: color.hsba.alpha)
    }
    
    ///  修改color的hue -> color
    static func changeOnlyHueColor(hue: CGFloat?, color: UIColor) -> UIColor  {
        if hue == nil {
            return color
        }
        return UIColor.init(hue: hue!/359.0, saturation:color.hsba.saturation/100.0 , brightness:color.hsba.brightness/100.0  , alpha: color.hsba.alpha)
    }
    
    ///  hsb -> color
    static func getHsbColor(hue: CGFloat, s: CGFloat,b: CGFloat) -> UIColor  {
        
        return UIColor.init(hue: hue/359.0, saturation: s/100.0, brightness: b/100.0, alpha:1)
    }
    
    ///  rgb -> color
    static func rgb(r: CGFloat, _ g: CGFloat, _ b: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    ///  hex -> rgb
    static func rgbFromHex(_ val: UInt) -> UIColor {
        var r: UInt = 0, g: UInt = 0, b: UInt = 0
        var a: UInt = 0xFF
        var rgb = val
        if (val & 0xFFFF0000) == 0 {
            a = 0xF
            if val & 0xF000 > 0 {
                a = val & 0xF
                rgb = val >> 4
            }
            r = (rgb & 0xF00) >> 8
            r = (r << 4) | r
            g = (rgb & 0xF0) >> 4
            g = (g << 4) | g
            b = rgb & 0xF
            b = (b << 4) | b
            a = (a << 4) | a
        } else {
            if val & 0xFF000000 > 0 {
                a = val & 0xFF
                rgb = val >> 8
            }
            r = (rgb & 0xFF0000) >> 16
            g = (rgb & 0xFF00) >> 8
            b = rgb & 0xFF
        }
        // NSLog("r:%X g:%X b:%X a:%X", r, g, b, a)
        return UIColor(red: CGFloat(r) / 255.0,
                       green: CGFloat(g) / 255.0,
                       blue: CGFloat(b) / 255.0,
                       alpha: CGFloat(a) / 255.0)
    }
    
    /// UIColor转UIImage
    class func creatImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorImage!
    }
    

    
}

extension String {
  func CGFloatValue() -> CGFloat? {
    guard let doubleValue = Double(self) else {
        return 0.0
    }
    return CGFloat(doubleValue)
  }
}


/// 渐变色方向
public enum GradientDirection: Int {
    case right = 0
    case left
    case bottom
    case top
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft
}

public extension UIColor {
    
    /// 生产渐变颜色
    ///
    /// - Parameters:
    ///   - from: 开始的颜色
    ///   - toColor: 结束的颜色
    ///   - size: 渐变颜色的范围
    ///   - direction: 渐变方向
    /// - Returns: 渐变颜色
    class func xp_gradientColor(_ fromColor: UIColor, toColor: UIColor, size: CGSize, direction: GradientDirection = GradientDirection.bottom) -> UIColor? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [fromColor.cgColor, toColor.cgColor]
        
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
        
        context?.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        
        UIGraphicsEndImageContext()
        
        return UIColor.init(patternImage: image)
    }
}
