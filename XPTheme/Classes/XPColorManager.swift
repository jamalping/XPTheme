//
//  XPColorManager.swift
//  DemoChartGradient
//
//  Created by lixiaoping on 2022/6/8.
//

import Foundation
import UIKit

/**************************深色******************/
/// Watchlist Chart
/// 线渐变红
let darkRedColor1 = UIColor.rgbFromHex(0xFCA086)
let darkRedColor2 = UIColor.rgbFromHex(0xFD73A7)
/// 区域渐变红
let darkAreaRedColor1 = UIColor.rgb(r: 249, 107, 138, alpha: 0.2)
let darkAreaRedColor2 = UIColor.rgb(r: 249, 107, 138, alpha: 0.0)
/// 线渐变绿
let darkGreenColor1 = UIColor.rgbFromHex(0x67B723)
let darkGreenColor2 = UIColor.rgbFromHex(0x30C969)
/// 区域渐变绿
let darkAreaGreenColor1 = UIColor.rgb(r: 49, 175, 89, alpha: 0.2)
let darkAreaGreenColor2 = UIColor.rgb(r: 49, 175, 89, alpha: 0.0)
/// 灰色线
let darklineGrayColor1 = UIColor.rgbFromHex(0x8D99BA)
let darklineGrayColor2 = UIColor.rgbFromHex(0x6677A2)
/// 区域渐变灰色
let darkAreaGrayColor1 = UIColor.rgb(r: 135, 145, 165, alpha: 0.2)
let darkAreaGrayColor2 = UIColor.rgb(r: 135, 145, 165, alpha: 0.0)
///  cellbg
let darkCellbgColor = UIColor.rgb(r: 29, 35, 51, alpha: 1)
let darkChartbgColor = UIColor.rgb(r: 38, 44, 66, alpha: 1)
/// 字体颜色
let darkFontMainColor = UIColor.rgbFromHex(0xD4D5DD)
let darkFontSubColor = UIColor.rgbFromHex(0xB5BBD3)
let darkFontRemarkColor = UIColor.rgbFromHex(0x969DB3)
let darkOncolourLabColor = UIColor.rgbFromHex(0xEAEAEA)
/// 百分比背景渐色
let darkPercentBgRedColor1: UIColor = UIColor.rgbFromHex(0x7A7090)
let darkPercentBgRedColor2: UIColor = UIColor.rgbFromHex(0x5E4E7C)
let darkPercentBgGreenColor1: UIColor = UIColor.rgbFromHex(0x5D7266)
let darkPercentBgGreenColor2: UIColor = UIColor.rgbFromHex(0x3F7477)
let darkPercentBggrayColor1: UIColor = UIColor.rgbFromHex(0x5D6477)
let darkPercentBggrayColor2: UIColor = UIColor.rgbFromHex(0x46576E)

/**************************custom alert color******************/
///  字体颜色
let greyishBrownFontColor = UIColor.rgb(r: 77, 77, 77, alpha: 1)
let dustyOrangeFontColor = UIColor.rgb(r: 239, 106, 57, alpha: 1)
let blackColor = UIColor.rgb(r: 51, 51, 51, alpha: 1)
let whiteColor = UIColor.rgb(r: 255, 252, 252, alpha: 1)
let sandBrownColor = UIColor.rgb(r: 217, 164, 85, alpha: 1)

/// 背景色
let paleOrangeBgColor = UIColor.rgb(r: 245, 185, 95, alpha: 1)
let lightTanBgColor = UIColor.rgb(r: 248, 228, 158, alpha: 1)
let warmGreyBgColor = UIColor.rgb(r: 140, 139, 137, alpha: 1)
let dustyOrangeBgColor = UIColor.rgb(r: 239, 106, 57, alpha: 1)


/** 其他颜色**/
/// 灰色背景、或者百分比为0的灰色虚线
let bgGrayColor = UIColor.rgbFromHex(0xAEAEAE)

public struct ColorManager {
    /******************************** hsb 颜色**********************/
    public static var primary_colour1 = darkFontMainColor
    public static var primary_colour2 = darkFontMainColor
    public static var data_up1 = darkFontMainColor
    public static var data_up2 = darkFontMainColor
    public static var data_down1 = darkFontMainColor
    public static var data_down2 = darkFontMainColor
    public static var data_grey1 = darkFontMainColor
    public static var data_grey2 = darkFontMainColor
    public static var font1_main = darkFontMainColor
    public static var font2_sub = darkFontMainColor
    public static var font3_remark = darkFontMainColor
    public static var font4 = darkFontMainColor
    public static var font_on_label = darkFontMainColor
    public static var font_hl = darkFontMainColor
    public static var font_error = darkFontMainColor
    public static var bg_1 = darkFontMainColor
    public static var bg_2 = darkFontMainColor
    public static var bg_3a = darkFontMainColor
    public static var bg_3b = darkFontMainColor
    public static var bg_4 = darkFontMainColor
    public static var bg_mylisticon = darkFontMainColor
    public static var icon_on_subtle = darkFontMainColor
    public static var icon_on_label = darkFontMainColor
    public static var icon_on_btn = darkFontMainColor
    public static var icon_arrow_up = darkFontMainColor
    public static var icon_arrow_down = darkFontMainColor
    public static var secondary_color = darkFontMainColor
    public static var secondary_gradient1  = darkFontMainColor
    public static var secondary_gradient2 = darkFontMainColor
    public static var bg_gradient1 = darkFontMainColor
    public static var bg_gradient2 = darkFontMainColor
    public static var mylist_gradient1 = darkFontMainColor
    public static var mylist_gradient2 = darkFontMainColor
    public static var mylist_gradient3 = darkFontMainColor
    public static var block_line = darkFontMainColor
    public static var remark_btn = darkFontMainColor
    public static var remark_main = darkFontMainColor
    public static var shadow = darkFontMainColor
    public static var shadow_2 = darkFontMainColor
    public static var shadow_3 = darkFontMainColor
    public static var alert = darkFontMainColor
    //暂时不用了
//    public static var icon_star_default = darkFontMainColor
//    public static var icon_star_selected = darkFontMainColor
//    public static var icon_star_disable = darkFontMainColor
    public static var icon_heart_default = darkFontMainColor
    public static var icon_heart_selected = darkFontMainColor
    public static var icon_heart_disable = darkFontMainColor
    public static var analogous_colour1 = darkFontMainColor
    public static var analogous_colour2 = darkFontMainColor
    public static var po_float = darkFontMainColor
    
    
    /******************************** Watchlist**********************/
    /// 整个背景色
    public static var tableviewBackgroundColorLayer1 = darkCellbgColor
    public static var tableviewBackgroundColorLayer2 = darkCellbgColor
    public static var tableviewBackgroundColorLayer3 = darkCellbgColor
    /// Watchlist Chart  颜色
    public static var watchListRedLineColorFrom = darkRedColor1
    public static var watchListRedLineColorTo = darkRedColor2
    public static var watchListGreenLineColorFrom = darkGreenColor1
    public static var watchListGreenLineColorTo = darkGreenColor2
    public static var watchListGreyLineColorFrom = darklineGrayColor1
    public static var watchListGreyLineColorTo = darklineGrayColor2
    public static var watchListCellBackgroundColorFrom = darkCellbgColor
    public static var watchListCellBackgroundColorTo = darkCellbgColor
    /// 线条下方渐变色
    public static var watchListRedGradientColorFrom = darkAreaRedColor1
    public static var watchListRedGradientColorTo = darkAreaRedColor2
    public static var watchListGreenGradientColorFrom = darkAreaGreenColor1
    public static var watchListGreenGradientColorTo = darkAreaGreenColor2
    public static var watchListGreyGradientColorFrom = darkAreaGrayColor1
    public static var watchListGreyGradientColorTo = darkAreaGrayColor2
    /// 百分比背景渐变色
    public static var colorLabelRedFrom = darkPercentBgRedColor1
    public static var colorLabelRedTo = darkPercentBgRedColor2
    public static var colorLabelGreenFrom = darkPercentBgGreenColor1
    public static var colorLabelGreenTo = darkPercentBgGreenColor2
    public static var colorLabelGreyFrom = darkPercentBggrayColor1
    public static var colorLabelGreyTo = darkPercentBggrayColor2
    /// 涨跌线条颜色
    public static var upZeroColor1: UIColor = watchListRedLineColorFrom
    public static var upZeroColor2: UIColor = watchListRedLineColorTo
    public static var downZeroColor1: UIColor = watchListGreenLineColorFrom
    public static var downZeroColor2: UIColor = watchListGreenLineColorTo
    /// 涨跌渐变色
    public static var upGradientZeroColor1: UIColor = watchListRedGradientColorFrom
    public static var upGradientZeroColor2: UIColor = watchListRedGradientColorTo
    public static var downGradientZeroColor1: UIColor = watchListGreenGradientColorFrom
    public static var downGradientZeroColor2: UIColor = watchListGreenGradientColorTo
    /// 百分比背景渐变色
    public static var upGradientPercentColor1: UIColor = colorLabelRedFrom
    public static var upGradientPercentColor2: UIColor = colorLabelRedTo
    public static var downGradientPercentColor1: UIColor = colorLabelGreenFrom
    public static var downGradientPercentColor2: UIColor = colorLabelGreenTo
    /// 字体颜色
    public static var fontColorMain = darkFontMainColor
    public static var fontColorSub = darkFontSubColor
    public static var fontColorRemark = darkFontRemarkColor
    public static var fontColorOnColorLabel = darkOncolourLabColor
    public static var fontColorRed = darkRedColor1
    public static var fontColorGreen = darkGreenColor1
    public static var fontColorGrey = darklineGrayColor1

    /******************************** QuotePage**********************/
    // QuotePage  颜色
    public static var quotePageGreenLineColorFrom = darkGreenColor1
    public static var quotePageGreenLineColorTo = darkGreenColor2
    public static var quotePageRedLineColorFrom = darkRedColor1
    public static var quotePageRedLineColorTo = darkRedColor2
    public static var quoteRedGradientColorFrom = darkAreaRedColor1
    public static var quoteRedGradientColorTo = darkAreaRedColor2
    public static var quoteGreenGradientColorFrom = darkAreaGreenColor1
    public static var quoteGreenGradientColorTo = darkAreaGreenColor2
    public static var quotePageChartBackgroundColorFrom = UIColor(hexString: "0x1C2334")
    public static var quotePageChartBackgroundColorTo = UIColor(hexString: "0x27304A")

    public static var quotePageChartSuspensionColorFrom = UIColor(hexString: "0xAEAEAE")
    public static var quotePageChartSuspensionColorTo = UIColor(hexString: "0xAEAEAE")

    public static var quotePageStockMarketBackgroundColorFrom = UIColor(hexString: "0xFFFFFF")
    public static var quotePageStockMarketBackgroundColorTo = UIColor(hexString: "0xFFFFFF")

    /// 涨跌线条颜色
    public static var quoteUpZeroColor1 = quotePageRedLineColorFrom
    public static var quoteUpZeroColor2 = quotePageRedLineColorTo
    public static var quoteDownZeroColor1 = quotePageGreenLineColorFrom
    public static var quoteDownZeroColor2 = quotePageGreenLineColorTo
    /// 涨跌渐变色
    public static var quoteupGradientZeroColor1 = quoteRedGradientColorFrom
    public static var quoteUpGradientZeroColor2 = quoteRedGradientColorTo
    public static var quoteDownGradientZeroColor1 = quoteGreenGradientColorFrom
    public static var quoteDownGradientZeroColor2 = quoteGreenGradientColorTo
    /// 三角箭头色
    public static var arrowUpColor = UIColor.white
    public static var arrowDownColor = UIColor.white
    
    /**************************custom alert color******************/
    ///  字体颜色
    public static var customAlertGreyishBrownFontColor = greyishBrownFontColor
    public static var customAlertDustyOrangeFontColor = dustyOrangeFontColor
    public static var customAlertBlackColor = blackColor
    public static var customAlertWhiteColor = whiteColor
    public static var customAlertsandBrownColor = sandBrownColor
    /// 背景色
    public static var customAlertPaleOrangeBgColor = paleOrangeBgColor
    public static var customAlertLightTanBgColor = lightTanBgColor
    public static var customAlertWarmGreyBgColor = warmGreyBgColor
    public static var customAlertDustyOrangeBgColor = dustyOrangeBgColor
    
    public static func redUpGreenDown() {
        /******************************** watchlist**********************/
        // 线条颜色
        upZeroColor1 = watchListRedLineColorFrom
        upZeroColor2 = watchListRedLineColorTo
        downZeroColor1 = watchListGreenLineColorFrom
        downZeroColor2 = watchListGreenLineColorTo
        // 线条下方渐变区域
        upGradientZeroColor1 = watchListRedGradientColorFrom
        upGradientZeroColor2 = watchListRedGradientColorTo
        downGradientZeroColor1 = watchListGreenGradientColorFrom
        downGradientZeroColor2 = watchListGreenGradientColorTo
        /// 百分比背景渐变色
        upGradientPercentColor1 = colorLabelRedFrom
        upGradientPercentColor2 = colorLabelRedTo
        downGradientPercentColor1 = colorLabelGreenFrom
        downGradientPercentColor2 = colorLabelGreenTo
        /// 三角箭头色
        arrowUpColor = icon_arrow_down
        arrowDownColor = icon_arrow_up
        
        /******************************** QuotePage**********************/
        quoteUpZeroColor1 = quotePageRedLineColorFrom
        quoteUpZeroColor2 = quotePageRedLineColorTo
        quoteDownZeroColor1 = quotePageGreenLineColorFrom
        quoteDownZeroColor2 = quotePageGreenLineColorTo

        quoteupGradientZeroColor1 = quoteRedGradientColorFrom
        quoteUpGradientZeroColor2 = quoteRedGradientColorTo
        quoteDownGradientZeroColor1 = quoteGreenGradientColorFrom
        quoteDownGradientZeroColor2 = quoteGreenGradientColorTo
    }

    public static func redDownGreenUp() {
        /******************************** watchlist**********************/
        // 线条颜色
        upZeroColor1 = watchListGreenLineColorFrom
        upZeroColor2 = watchListGreenLineColorTo
        downZeroColor1 = watchListRedLineColorFrom
        downZeroColor2 = watchListRedLineColorTo
        // 线条下方渐变区域
        upGradientZeroColor1 = watchListGreenGradientColorFrom
        upGradientZeroColor2 = watchListGreenGradientColorTo
        downGradientZeroColor1 = watchListRedGradientColorFrom
        downGradientZeroColor2 = watchListRedGradientColorTo
        /// 百分比背景渐变色
        upGradientPercentColor1 = colorLabelGreenFrom
        upGradientPercentColor2 = colorLabelGreenTo
        downGradientPercentColor1 = colorLabelRedFrom
        downGradientPercentColor2 = colorLabelRedTo
        /// 三角箭头色
        arrowUpColor = icon_arrow_up
        arrowDownColor = icon_arrow_down

        /******************************** QuotePage**********************/
        quoteUpZeroColor1 = quotePageGreenLineColorFrom
        quoteUpZeroColor2 = quotePageGreenLineColorTo
        quoteDownZeroColor1 = quotePageRedLineColorFrom
        quoteDownZeroColor2 = quotePageRedLineColorTo

        quoteupGradientZeroColor1 = quoteGreenGradientColorFrom
        quoteUpGradientZeroColor2 = quoteGreenGradientColorTo
        quoteDownGradientZeroColor1 = quoteRedGradientColorFrom
        quoteDownGradientZeroColor2 = quoteRedGradientColorTo
    }

    /* watchlist */
     public static func getUpColors() -> [UIColor] {
         let colors = AAQCChartUIManager.shared.lineColorStyle == .redRise ? [ColorManager.data_down2, ColorManager.data_down1] : [ColorManager.data_up2, ColorManager.data_up1]
         return colors
     }

     public static func getDownColors() -> [UIColor] {
         let colors = AAQCChartUIManager.shared.lineColorStyle == .greenRise ? [ColorManager.data_down2, ColorManager.data_down1] : [ColorManager.data_up2, ColorManager.data_up1]
         return colors
     }
     
     /// 当前主题灰色线颜色
     public static func getGrayLineColor() -> [UIColor] {
         return [ColorManager.data_grey2, ColorManager.data_grey1]
     }

     /// 当前主题线下方区域渐变灰色
     public static func getGrayAreaColor() -> [CGColor] {
         return [ColorManager.data_grey1.withAlphaComponent(0.2).cgColor, ColorManager.data_grey2.withAlphaComponent(0.0).cgColor]
     }

    /// 百分比背景渐变灰色
    public static func getPercentBgGrayColor() -> [UIColor] {
        return [colorLabelGreyFrom, colorLabelGreyTo]
    }

    /// 当前主题cell背景
    public static func getCellBgColor() -> [UIColor] {
        return [watchListCellBackgroundColorFrom, watchListCellBackgroundColorTo]
    }

    /* quotePage */
    public static func getQuoteUpColors() -> [UIColor] {
//        return [quoteUpZeroColor1, quoteUpZeroColor2]
        let colors = AAQCChartUIManager.shared.lineColorStyle == .redRise ? [ColorManager.data_down2, ColorManager.data_down1] : [ColorManager.data_up2, ColorManager.data_up1]
        return colors
    }

    public static func getQuoteDownColors() -> [UIColor] {
//        return [quoteDownZeroColor1, quoteDownZeroColor2]
        let colors = AAQCChartUIManager.shared.lineColorStyle == .greenRise ? [ColorManager.data_down2, ColorManager.data_down1] : [ColorManager.data_up2, ColorManager.data_up1]
        return colors
    }

    /// 获取涨幅的渐变数组
    /// bgColor：背景颜色
    public static func getRiseStateGradientColor(bgColor: UIColor) -> [CGColor] {
        let gradientRedColors = [ColorManager.quoteupGradientZeroColor1.cgColor, ColorManager.quoteUpGradientZeroColor2.cgColor, bgColor.withAlphaComponent(0).cgColor]
        return gradientRedColors
    }

    /// 获取跌幅的渐变颜色
    public static func getFallStateGradientColor(bgColor: UIColor) -> [CGColor] {
        let gradientRedColors = [ColorManager.quoteDownGradientZeroColor1.cgColor, ColorManager.quoteDownGradientZeroColor2.cgColor, bgColor.withAlphaComponent(0).cgColor]
        return gradientRedColors
    }

    public static func bgColor() -> UIColor {
        if AAQCChartUIManager.shared.currentTheme == .dark {
            return UIColor.rgbFromHex(0x1C2334)
        }
        return UIColor.rgbFromHex(0xF4F4F4)
    }

    public static func closeLineColor() -> UIColor {
        if AAQCChartUIManager.shared.currentTheme == .dark {
            return UIColor.white
        }
        return UIColor.black
    }
    
    public static func maxMinPriceBgColor() -> UIColor {
        if AAQCChartUIManager.shared.currentTheme == .dark {
            return UIColor.rgbFromHex(0x232C42)
        }
        return UIColor.rgbFromHex(0xE0E1E0)
    }
    
    public static func closePriceBgColor() -> UIColor {
        if AAQCChartUIManager.shared.currentTheme == .dark {
            return UIColor.rgbFromHex(0x7f90bf25)
        }
        return UIColor.rgbFromHex(0x91918c25)
    }

    public static func closePriceColor() -> UIColor {
        if AAQCChartUIManager.shared.currentTheme == .dark {
            return UIColor.rgbFromHex(0x848BA5)
        }
        return UIColor.rgbFromHex(0x6C6B6B)
    }

    public static func updateThemeRedGreenColor() {
        if AAQCChartUIManager.shared.lineColorStyle == .redRise {
            redUpGreenDown()
        }
        if AAQCChartUIManager.shared.lineColorStyle == .greenRise {
            redDownGreenUp()
        }
    }
}

extension ColorManager {
    static func export() -> [String: [String: Any]] {
        var result = [String: [String: Any]]()
        let colorDict = ["TableviewBackgroundColorLayer1": tableviewBackgroundColorLayer1,
                         "TableviewBackgroundColorLayer2": tableviewBackgroundColorLayer2,
                         "TableviewBackgroundColorLayer3": tableviewBackgroundColorLayer3,
                         "watchListRedLineColorFrom": watchListRedLineColorFrom,
                         "watchListRedLineColorTo": watchListRedLineColorTo,
                         "watchListGreenLineColorFrom": watchListGreenLineColorFrom,
                         "watchListGreenLineColorTo": watchListGreenLineColorTo,
                         "watchListGreyLineColorFrom": watchListGreyLineColorFrom,
                         "watchListGreyLineColorTo": watchListGreyLineColorTo,
                         "watchListCellBackgroundColorFrom": watchListCellBackgroundColorFrom,
                         "watchListCellBackgroundColorTo": watchListCellBackgroundColorTo,
                         "watchListRedGradientColorFrom": watchListRedGradientColorFrom,
                         "watchListRedGradientColorTo": watchListRedGradientColorTo,
                         "watchListGreenGradientColorFrom": watchListGreenGradientColorFrom,
                         "watchListGreenGradientColorTo": watchListGreenGradientColorTo,
                         "watchListGreyGradientColorFrom": watchListGreyGradientColorFrom,
                         "watchListGreyGradientColorTo": watchListGreyGradientColorTo,
                         "colorLabelRedFrom": colorLabelRedFrom,
                         "colorLabelRedTo": colorLabelRedTo,
                         "colorLabelGreenFrom": colorLabelGreenFrom,
                         "colorLabelGreenTo": colorLabelGreenTo,
                         "colorLabelGreyFrom": colorLabelGreyFrom,
                         "colorLabelGreyTo": colorLabelGreyTo,
                         "upZeroColor1": upZeroColor1,
                         "upZeroColor2": upZeroColor2,
                         "downZeroColor1": downZeroColor1,
                         "downZeroColor2": downZeroColor2,
                         "upGradientZeroColor1": upGradientZeroColor1,
                         "upGradientZeroColor2": upGradientZeroColor2,
                         "downGradientZeroColor1": downGradientZeroColor1,
                         "downGradientZeroColor2": downGradientZeroColor2,
                         "upGradientPercentColor1": upGradientPercentColor1,
                         "upGradientPercentColor2": upGradientPercentColor2,
                         "downGradientPercentColor1": downGradientPercentColor1,
                         "downGradientPercentColor2": downGradientPercentColor2,
                         "fontColorMain": fontColorMain,
                         "fontColorSub": fontColorSub,
                         "fontColorRemark": fontColorRemark,
                         "fontColorOnColorLabel": fontColorOnColorLabel,
                         "fontColorRed": fontColorRed,
                         "fontColorGreen": fontColorGreen,
                         "fontColorGrey": fontColorGrey,
        ]
        result["ColorManager"] = colorDict
        return result
    }
}
