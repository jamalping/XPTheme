//
//  XPQCChartUIChangeProcols.swift
//  DemoChartGradient
//
//  Created by lixiaoping on 2022/6/21.
//
import Foundation
import UIKit

// MARK: - 监听字体、主题、涨跌颜色风格、语言

/// 主题
public protocol AAQCCharThemeChange {
    var themeToken: NSObjectProtocol? { get set }
    func monitorthemeAndUpdownColorChange()
    func userDidChangeTheme(theme: ThemeType)
    func userDidChangeLineColorStyle(lineColorStyle: LineColorStyle)
}

private var themeTokenKey = "themeTokenKey"
public extension AAQCCharThemeChange where Self: NSObject {
    var themeToken: NSObjectProtocol? {
        set {
            if let themToken = newValue {
                objc_setAssociatedObject(self, &themeTokenKey, NotiProxy.init(themToken), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get {
            return (objc_getAssociatedObject(self, &themeTokenKey) as? NotiProxy)?.observer
        }
    }
    
    func monitorthemeAndUpdownColorChange() {
        weak var welf = self
        let observer = NotificationCenter.default.addObserver(forName: ThemeNotifacationName, object: nil, queue: OperationQueue.main) { noti in
            if noti.userInfo?["theme"] != nil {
                welf?.userDidChangeTheme(theme: noti.userInfo!["theme"] as! ThemeType)
            }

            if noti.userInfo?["updowncolor"] != nil {
                welf?.userDidChangeLineColorStyle(lineColorStyle: noti.userInfo?["updowncolor"] as! LineColorStyle)
            }
        }
        self.themeToken = observer
    }
}

public protocol AAQCChartUIChange: AAQCCharThemeChange  {
}

public extension AAQCChartUIChange where Self: NSObject {
    func monitorUIStatusChange() {
        self.monitorthemeAndUpdownColorChange()
    }
}

/// 观察者管理类（自动释放）
class NotiProxy: NSObject {
    
    weak var observer: NSObjectProtocol?
    
    init(_ observer: NSObjectProtocol) {
        self.observer = observer
    }
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
