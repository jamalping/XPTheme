//
//  XPChartUIManager.swift
//  DemoChartGradient
//
//  Created by lixiaoping on 2022/6/17.
//
import UIKit
//import AAFontSize
//// import AAExtension

let UpDownColorKey = "ChartRiseState"
let DarkLightKey = "DarkLightState"

let PrimaryColorHueKey = "PrimaryColorHueKey"
let PrimaryColor2HueKey = "PrimaryColor2HueKey"
let Dataup1HueKey = "Dataup1HueKey"
let Datadown1HueKey = "Datadown1HueKey"

let NewPrimaryColorKey = "NewPrimaryColorKey"
let NewPrimaryColor2Key = "NewPrimaryColor2Key"
let NewDataup1Key = "NewDataup1Key"
let NewDataup2Key = "NewDataup2Key"
let NewDatadown1NewKey = "NewDatadown1NewKey"
let NewDatadown2NewKey = "NewDatadown2NewKey"


public let ThemeNotifacationName = NSNotification.Name("keyThemeNotifacation")
public let FontTpyeNotifacationName = NSNotification.Name("FontTpyeNotifacationName")

///线条颜色风格 --- 红涨绿跌/绿涨红跌
public enum LineColorStyle: String {
    case redRise
    case greenRise
}
///主题 --- 深色/浅色
public enum ThemeType: String {
    case dark
    case light
}
///字体 ---正常字体/大字体
public enum FontType: Int {
    case normal
    case large
}


public class AAQCChartUIManager: NSObject {
    public static let shared = AAQCChartUIManager()
    public var currentJson: [String: Any]?
    public var isUserLogin: Bool = false
    public var allThemeColors: [String: [String: Any]] = ColorManager.export()
    public var currentTheme: ThemeType {
        get {
            guard let state = UserDefaults.standard.string(forKey: DarkLightKey) else {
                return .dark
            }
            return ThemeType(rawValue: state) ?? .dark
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: DarkLightKey)
            UserDefaults.standard.synchronize()
        }
    }
    public var newPrimaryColor: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+NewPrimaryColorKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+NewPrimaryColorKey)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }
    
    public var newPrimaryColor2: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+NewPrimaryColor2Key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+NewPrimaryColor2Key)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }
    
    public var newDataup1: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+NewDataup1Key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+NewDataup1Key)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }
    public var newDataup2: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+NewDataup2Key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+NewDataup2Key)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }
    
    public var newDatadown1: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+NewDatadown1NewKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+NewDatadown1NewKey)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }
    public var newDatadown2: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+NewDatadown2NewKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+NewDatadown2NewKey)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }

    
    
    public var primaryColorHue: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+PrimaryColorHueKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+PrimaryColorHueKey)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }
    
    public var primaryColor2Hue: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+PrimaryColor2HueKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+PrimaryColor2HueKey)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }
    
    public var Dataup1Hue: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+Dataup1HueKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+Dataup1HueKey)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }
    
    public var Datadown1Hue: Any? {
        get {
            return UserDefaults.standard.value(forKey: currentTheme.rawValue+Datadown1HueKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: currentTheme.rawValue+Datadown1HueKey)
            UserDefaults.standard.synchronize()
            configHsbColor()
        }
    }
    

    public var lineColorStyle: LineColorStyle {
        get {
            guard let redRise = UserDefaults.standard.string(forKey: UpDownColorKey) else {
                return .redRise
            }
            return LineColorStyle(rawValue: redRise) ?? .redRise
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: UpDownColorKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    public func initWithFileName(_ named: String = "theme") {
        let type: String? = named.lowercased().contains("json") ? nil : "json"
        
        /// 主工程里面有就优先拿主工程里面的（用于开发）
//        var jsonString: String?
//        if let jsonPath = Bundle.main.path(forResource: named, ofType: type) {
//            jsonString = jsonPath
//        }else {
//        }
        let jsonString = self.getResourceBundle()?.path(forResource: named, ofType: type)
        
        let data = try! Data(contentsOf: URL(fileURLWithPath: jsonString!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        launchConfig(json)
    }
    
    public func configJson(_ json: [String: Any], type: ThemeType) {
        var dict = [String: String]()
        if type == .dark {
            dict = json["dark"] as! [String: String]
        } else {
            dict = json["light"] as! [String: String]
        }
        let gradientAlphaFrom = Double(dict["WatchListGradientAlphaFrom"] ?? "0.2")
        let gradientAlphaTo = Double(dict["WatchListGradientAlphaTo"] ?? "0.0")
        let cellBgAlpha = Double(dict["WatchListCellBackgroundColorAlpha"] ?? "1")
        
        /// hsb 颜色
        configHsbColor()
        
        /// 整个底部大的背景色
        ColorManager.tableviewBackgroundColorLayer1 = UIColor(hexString: dict["TableviewBackgroundColorLayer1"] ?? "0x1C2334")!
        ColorManager.tableviewBackgroundColorLayer2 = UIColor(hexString: dict["TableviewBackgroundColorLayer2"] ?? "0x27304A")!
        ColorManager.tableviewBackgroundColorLayer3 = UIColor(hexString: dict["TableviewBackgroundColorLayer3"] ?? "0x2E3750")!
        /// 线条颜色
        ColorManager.watchListRedLineColorFrom = UIColor(hexString: dict["data-down1"] ?? "0xFCA086")!
        ColorManager.watchListRedLineColorTo = UIColor(hexString: dict["data-down2"] ?? "0xFD73A7")!
        ColorManager.watchListGreenLineColorFrom = UIColor(hexString: dict["data-up1"] ?? "0x67B723")!
        ColorManager.watchListGreenLineColorTo = UIColor(hexString: dict["data-up2"] ?? "0x30C969")!
        ColorManager.watchListGreyLineColorFrom = UIColor(hexString: dict["data-grey1"] ?? "0x8D99BA")!
        ColorManager.watchListGreyLineColorTo = UIColor(hexString: dict["data-grey2"] ?? "data-grey2")!
        /// 线条下方渐变色
        ColorManager.watchListRedGradientColorFrom = UIColor(hexString: dict["data-down1"] ?? "0xDB6F9C", alpha: gradientAlphaFrom!)!
        ColorManager.watchListRedGradientColorTo = UIColor(hexString: dict["data-down2"] ?? "0xDB6F9C", alpha: gradientAlphaTo!)!
        ColorManager.watchListGreenGradientColorFrom = UIColor(hexString: dict["data-up1"] ?? "0x37BA6C", alpha: gradientAlphaFrom!)!
        ColorManager.watchListGreenGradientColorTo = UIColor(hexString: dict["data-up2"] ?? "0x37BA6C", alpha: gradientAlphaTo!)!
        ColorManager.watchListGreyGradientColorFrom = UIColor(hexString: dict["data-grey1"] ?? "0x8791A5", alpha: gradientAlphaFrom!)!
        ColorManager.watchListGreyGradientColorTo = UIColor(hexString: dict["data-grey2"] ?? "0x8791A5", alpha: gradientAlphaTo!)!
        /// 百分比背景渐变色
        ColorManager.colorLabelRedFrom = UIColor(hexString: dict["ColorLabelRedFrom"] ?? "0x7A7090")!
        ColorManager.colorLabelRedTo = UIColor(hexString: dict["ColorLabelRedTo"] ?? "0x5E4E7C")!
        ColorManager.colorLabelGreenFrom = UIColor(hexString: dict["ColorLabelGreenFrom"] ?? "0x5D7266")!
        ColorManager.colorLabelGreenTo = UIColor(hexString: dict["ColorLabelGreenTo"] ?? "0x3F7477")!
        ColorManager.colorLabelGreyFrom = UIColor(hexString: dict["ColorLabelGreyFrom"] ?? "0x5D6477")!
        ColorManager.colorLabelGreyTo = UIColor(hexString: dict["ColorLabelGreyTo"] ?? "0x46576E")!
        /// cell或者chart背景色
        ColorManager.watchListCellBackgroundColorFrom = UIColor(hexString: dict["WatchListCellBackgroundColorFrom"] ?? "0x2E3750", alpha: cellBgAlpha!)!
        ColorManager.watchListCellBackgroundColorTo = UIColor(hexString: dict["WatchListCellBackgroundColorTo"] ?? "0x212C45", alpha: cellBgAlpha!)!
        /// 字体颜色
        ColorManager.fontColorMain = UIColor(hexString: dict["FontColorMain"] ?? "0xD4D5DD")!
        ColorManager.fontColorSub = UIColor(hexString: dict["FontColorSub"] ?? "0xB5BBD3")!
        ColorManager.fontColorRemark = UIColor(hexString: dict["FontColorRemark"] ?? "0x969DB3")!
        ColorManager.fontColorOnColorLabel = UIColor(hexString: dict["FontColorOnColorLabel"] ?? "0xEAEAEA")!
        ColorManager.fontColorRed = UIColor(hexString: dict["FontColorRed"] ?? "0xDB6F9C")!
        ColorManager.fontColorGreen = UIColor(hexString: dict["FontColorGreen"] ?? "0x37BA6C")!
        ColorManager.fontColorGrey = UIColor(hexString: dict["FontColorGrey"] ?? "0x8791A5")!
        
        /// QuotePage  颜色
        let quoteGradientAlphaFrom = Double(dict["QuotePageGradientAlphaFrom"] ?? "0.3")
        let quoteGradientAlphaTo = Double(dict["QuotePageGradientAlphaTo"] ?? "0.0")
        /// 线条
        ColorManager.quotePageRedLineColorFrom = UIColor(hexString: dict["QuotePageRedLineColorFrom"] ?? "0xFCA086")!
        ColorManager.quotePageRedLineColorTo = UIColor(hexString: dict["QuotePageRedLineColorTo"] ?? "0xFD73A7")!
        ColorManager.quotePageGreenLineColorFrom = UIColor(hexString: dict["QuotePageGreenLineColorFrom"] ?? "0x67B723")!
        ColorManager.quotePageGreenLineColorTo = UIColor(hexString: dict["QuotePageGreenLineColorTo"] ?? "0x30C969")!
        /// 渐变区域
        ColorManager.quoteRedGradientColorFrom = UIColor(hexString: dict["QuotePageRedGradientColor"] ?? "0xDB6F9C", alpha: quoteGradientAlphaFrom!)!
        ColorManager.quoteRedGradientColorTo = UIColor(hexString: dict["QuotePageRedGradientColor"] ?? "0xDB6F9C", alpha: quoteGradientAlphaTo!)!
        ColorManager.quoteGreenGradientColorFrom = UIColor(hexString: dict["QuotePageGreenGradientColor"] ?? "0x37BA6C", alpha: quoteGradientAlphaFrom!)!
        ColorManager.quoteGreenGradientColorTo = UIColor(hexString: dict["QuotePageGreenGradientColor"] ?? "0x37BA6C", alpha: quoteGradientAlphaTo!)!
        /// 背景
        ColorManager.quotePageChartBackgroundColorFrom = UIColor(hexString: dict["QuotePageChartBackgroundColorFrom"] ?? "0x1C2334", alpha: 1)!
        ColorManager.quotePageChartBackgroundColorTo = UIColor(hexString: dict["QuotePageChartBackgroundColorTo"] ?? "0x27304A", alpha: 1)!
        
        // 暂停买卖
        ColorManager.quotePageChartSuspensionColorFrom = UIColor(hexString: dict["QuotePageChartSuspensionColorFrom"] ?? "0xAEAEAE", alpha: 1)!
        ColorManager.quotePageChartSuspensionColorTo = UIColor(hexString: dict["QuotePageChartSuspensionColorTo"] ?? "0xAEAEAE", alpha: 1)!
        ColorManager.updateThemeRedGreenColor()
        
        ColorManager.quotePageStockMarketBackgroundColorFrom = UIColor(hexString: dict["QuotePageStockMarketBackgroundColorFrom"] ?? "0xAEAEAE", alpha: 0.6)!
        ColorManager.quotePageStockMarketBackgroundColorTo = UIColor(hexString: dict["QuotePageStockMarketBackgroundColorTo"] ?? "0xAEAEAE", alpha: 0.6)!
        ColorManager.updateThemeRedGreenColor()
    }
    public func configHsbColor() {
        if currentJson == nil { return }
        var dict = [String: String]()
        if currentTheme == .dark {
            dict = currentJson!["dark"] as! [String: String]
        } else {
            dict = currentJson!["light"] as! [String: String]
        }
        /// hsb 颜色
        ColorManager.primary_colour1 =   UIColor(hexString: newPrimaryColor as? String ??  dict["primary-colour1"] ?? "0x9981EC")!
        
//        UIColor.changeHueColor(hue:primaryColorHue as? CGFloat, bright: primaryColorBright as? CGFloat,color:)
        ColorManager.primary_colour2 =  UIColor(hexString:newPrimaryColor2 as? String ?? dict["primary-colour2"] ?? "0xD977BB")!
        ColorManager.data_up1 = UIColor(hexString: newDataup1 as? String ?? dict["data-up1"] ?? "#628C74")!
        ColorManager.data_up2 = UIColor(hexString: newDataup2 as? String ?? dict["data-up2"] ?? "#3D7D87")!
        ColorManager.data_down1 = UIColor(hexString: newDatadown1 as? String ?? dict["data-down1"] ?? "#996E8D")!
        ColorManager.data_down2 = UIColor(hexString: newDatadown2 as? String ?? dict["data-down2"] ?? "#66518C")!
        //不用变hue
        ColorManager.data_grey1 = UIColor(hexString: dict["data-grey1"] ?? "#959595")!
        ColorManager.data_grey2 = UIColor(hexString: dict["data-grey2"] ?? "#4D4D4D")!
        ColorManager.font1_main = UIColor(hexString: dict["font1-main"] ?? "#DEDEDE")!
        ColorManager.font2_sub = UIColor(hexString: dict["font2-sub"] ?? "#C7C7C7")!
        ColorManager.font3_remark = UIColor(hexString: dict["font3-remark"] ?? "#B8B8B8")!
        ColorManager.font4 = UIColor(hexString: dict["font4"] ?? "#BFBFBF")!
        ColorManager.font_on_label = UIColor(hexString: dict["font-on-label"] ?? "#EAEAEA")!
        //跟随 primaryColor1Hue
        ColorManager.font_hl = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["font-hl"] ?? "0x8C73E6")!)
        ColorManager.font_error = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["font-hl"] ?? "0x8C73E6")!)
        ColorManager.bg_1 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["bg-1"] ?? "#1B1924")!)
        ColorManager.bg_2 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["bg-2"] ?? "#23212E")!)
        ColorManager.bg_3a = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color: UIColor(hexString: dict["bg-3a"] ?? "#2D2A38",alpha: currentTheme == .dark ? 1 : 1)! )
        ColorManager.bg_3b = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["bg-3b"] ?? "#24222E")!)
        ColorManager.bg_4 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["bg-4"] ?? "#353242")!)
        ColorManager.bg_mylisticon = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["bg-mylisticon"] ?? "#48425E")!)
        ColorManager.secondary_color = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["secondary-color"] ?? "##382FF5")!)
        ColorManager.secondary_gradient1 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["secondary-gradient1"] ?? "#8A8894")!)
        ColorManager.secondary_gradient2 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["secondary-gradient2"] ?? "#6B6970")!)
        ColorManager.bg_gradient1 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["bg-gradient1"] ?? "#312D40")!)
        ColorManager.bg_gradient2 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["bg-gradient2"] ?? "#1B1924")!)
        ColorManager.mylist_gradient1 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["mylist-gradient1"] ?? "#312D40")!)
        ColorManager.mylist_gradient2 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["mylist-gradient2"] ?? "#25232B")!)
        ColorManager.mylist_gradient3 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["mylist-gradient3"] ?? "#302D38")!)
        ColorManager.block_line = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["block+line"] ?? "#9B94B3")!)
        ColorManager.remark_btn = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["remark+btn"] ?? "#87819C")!)
        ColorManager.remark_main = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["remark-main"] ?? "#413D4D")!)
        ColorManager.shadow = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["shadow"] ?? "#483E6B")!)
        ColorManager.shadow_2 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["shadow-2"] ?? "#483E6B")!)
        
        ColorManager.shadow_3 = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["shadow-3"] ?? "#BFB8AC")!)
        //下面这几个颜色待定
        ColorManager.alert = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["alert"] ?? "#483E6B")!)
//        ColorManager.icon_star_default = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["icon-star-default"] ?? "#483E6B")!)
//        ColorManager.icon_star_selected = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["icon-star-selected"] ?? "#483E6B")!)
//        ColorManager.icon_star_disable = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["icon-star-disable"] ?? "#483E6B")!)
        ColorManager.icon_heart_default = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["icon-heart-default"] ?? "#483E6B")!)
        ColorManager.icon_heart_selected = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["icon-heart-selected"] ?? "#483E6B")!)
        ColorManager.icon_heart_disable = UIColor.changeOnlyHueColor(hue:primaryColorHue as? CGFloat,color:UIColor(hexString: dict["icon-heart-disable"] ?? "#483E6B")!)
        var  analogouscolour1Hue = primaryColorHue
        var  analogouscolour2Hue = primaryColorHue
        if  primaryColorHue != nil {
            let primaryhue : CGFloat = primaryColorHue as? CGFloat ?? 0
            analogouscolour1Hue = (primaryhue - 20.0 < 0) ?  (primaryhue - 20.0 + 359.0) : (primaryhue - 20.0)
            analogouscolour2Hue = (primaryhue - 10.0 < 0) ?  (primaryhue - 10.0 + 359.0) : (primaryhue - 10.0)
        }
        ColorManager.analogous_colour1 = UIColor.changeOnlyHueColor(hue:analogouscolour1Hue as? CGFloat,color:UIColor(hexString: dict["analogous-colour1"] ?? "#828FED")!)
        ColorManager.analogous_colour2 = UIColor.changeOnlyHueColor(hue:analogouscolour2Hue as? CGFloat,color:UIColor(hexString: dict["analogous-colour2"] ?? "#8882ED")!)
        ColorManager.po_float = UIColor.changeOnlyHueColor(hue:analogouscolour2Hue as? CGFloat,color:UIColor(hexString: dict["po-float"] ?? "#8882ED")!)

        
        //不用变hue
        ColorManager.icon_on_subtle = UIColor(hexString: dict["icon-on-subtle"] ?? "#8074A6")!
        
        ColorManager.icon_on_label = UIColor(hexString: dict["icon-on-label"] ?? "#EAEAEA")!
        ColorManager.icon_on_btn = UIColor(hexString: dict["icon-on-btn"] ?? "#A0A0A0")!
        //跟随 up1Hue
        ColorManager.icon_arrow_up = UIColor.changeOnlyHueColor(hue:Dataup1Hue as? CGFloat,color:UIColor(hexString: dict["icon-arrow-up"] ?? "#AAF2C9")!)
        //跟随 down1Hue
        ColorManager.icon_arrow_down = UIColor.changeOnlyHueColor(hue:Datadown1Hue as? CGFloat,color:UIColor(hexString: dict["icon-arrow-down"] ?? "#F2AADE")!)
    }
    
    public func resetTheFactory() {
        primaryColorHue = nil
        primaryColor2Hue = nil
        Datadown1Hue = nil
        Dataup1Hue  = nil
        newPrimaryColor = nil
        newPrimaryColor2 = nil
        newDataup1 = nil
        newDataup2 = nil
        newDatadown1 = nil
        newDatadown2 = nil
//        primaryColorBright = nil
//        primaryColor2Bright = nil
//        Datadown1Bright = nil
//        Dataup1Bright  = nil
        switchTheme(type:currentTheme)
    }
    
    public func launchConfig(_ json: Any) {
        currentJson = json as! [String: Any]?
        configJson(currentJson!, type: currentTheme)
        if lineColorStyle == .redRise {
            ColorManager.redUpGreenDown()
        }
        if lineColorStyle == .greenRise {
            ColorManager.redDownGreenUp()
        }
    }

    public func switchTheme(type: ThemeType) {
        currentTheme = type
        configJson(currentJson!, type: currentTheme)
        NotificationCenter.default.post(name: ThemeNotifacationName, object: nil, userInfo: ["theme": currentTheme])
    }
    
    public func switchLineColorStyle(type: LineColorStyle) {
        lineColorStyle = type
        if lineColorStyle == .redRise {
            ColorManager.redUpGreenDown()
        }
        if lineColorStyle == .greenRise {
            ColorManager.redDownGreenUp()
        }
        NotificationCenter.default.post(name: ThemeNotifacationName, object: nil, userInfo: ["updowncolor": lineColorStyle])
    }
}
