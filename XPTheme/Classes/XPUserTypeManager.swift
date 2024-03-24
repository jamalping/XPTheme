//
//  AAUserTypeManager.swift
//  XPTheme
//
//  Created by jinzixin on 2023/3/30.
//

import Foundation

///用户类型 ---免费用户/港股串流用户/港股串流用户 (有期货串流)
public enum UserManagerType: String {
    case normal
    case hkStocks
    case hkFTStocks
}

let UserManagerKey = "UserManagerState"
let UserTypeChangeNotificationName =    NSNotification.Name("userTypeChangeNotification")
public class AAUserTypeManager: NSObject {
    public static let shared = AAUserTypeManager()
    
    
    public var userManagerType: UserManagerType {
        get {
            guard let state = UserDefaults.standard.string(forKey:  UserManagerKey) else {
                return .normal
            }
            return UserManagerType(rawValue: state) ?? .normal
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: UserManagerKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    public func switchUserType(type: UserManagerType) {
        userManagerType = type
        NotificationCenter.default.post(name: UserTypeChangeNotificationName, object: nil, userInfo: ["userTypeChange": userManagerType])
        
    }
}

/// 用户切换
///
/// 
public protocol AAUserManagerTypeChange {
    func userTypeStatusChange()
    func userDidChangeUserType(type: UserManagerType)
}
private var userTokenKey = "userTokenKey"
public extension AAUserManagerTypeChange where Self: NSObject {
    var userManagerToken: NSObjectProtocol? {
        set {
            if let userToken = newValue {
                objc_setAssociatedObject(self, &userTokenKey, NotiProxy.init(userToken), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get {
            return (objc_getAssociatedObject(self, &userTokenKey) as? NotiProxy)?.observer
        }
    }
    func userTypeStatusChange(){
            weak var welf = self
            let observer = NotificationCenter.default.addObserver(forName: UserTypeChangeNotificationName, object: nil, queue: OperationQueue.main) { noti in
                if noti.userInfo?["userTypeChange"] != nil {
                    welf?.userDidChangeUserType(type: noti.userInfo?["userTypeChange"] as! UserManagerType)
                }

            }
        self.userManagerToken = observer
    }
}


