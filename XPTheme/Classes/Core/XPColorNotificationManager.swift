//
//  XPColorNotificationManager.swift
//  XPTheme
//
//  Created by lixiaoping on 2022/10/17.
//

import Foundation

/// 通知管理类，自动移除通知
class XPColorNotificationManager {
    var selectorToBoolMap: [Selector: Bool] = [:]
    
    weak var observer: NSObject?
    
    init(observer: NSObject) {
        self.observer = observer
    }
    
    deinit {
        if let observer = observer {
            debugPrint("移除观察者")
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
 
extension NSObject {
    
    struct Key {
        static var notificationManageKey = "notificationManageKey"
    }
    
    var noti: XPColorNotificationManager {
        get {
            if let manage =
                objc_getAssociatedObject(self, &Key.notificationManageKey) as? XPColorNotificationManager {
                return manage
            }
            let notificationManage = XPColorNotificationManager.init(observer: self)

            objc_setAssociatedObject(self, &Key.notificationManageKey, notificationManage, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return notificationManage
        }
        set {
            objc_setAssociatedObject(self, &Key.notificationManageKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addObserver(_ selector: Selector) {
        /// 已经存在就不加了
        if let bool = noti.selectorToBoolMap[selector] {
            if bool {
                return
            }
        }else {
            noti.selectorToBoolMap[selector] = true
            NotificationCenter.default.addObserver(self, selector: selector, name: ThemeNotifacationName, object: nil)
            
        }
    }
}

