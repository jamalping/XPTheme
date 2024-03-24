//
//  XPProjectResourceable.swift
//  XPTheme
//
//  Created by jamalping on 2024/3/24.
//

import Foundation
/// 项目资源
public protocol XPProjectResourceable {}
 
public extension XPProjectResourceable where Self: NSObject {
    
    /// 当前对象所在的bundle
    var bundle: Bundle {
        return Bundle.init(for: self.classForCoder)
    }
    
    /// 工程名
    var projectName: String? {
        return self.bundle.infoDictionary?["CFBundleExecutable"] as? String
    }
    
    
    /// 获取资源包Bundle （resourceBundlePath 不传，则取当前工程名为包名的资源包）
    /// - Parameter resourceBundlePath: 资源包路径
    /// -eg: UIImage.init(named: "imageName", in: self.getResourceBundle(), compatibleWith: nil)
    func getResourceBundle(_ resourceBundlePath: String? = nil) -> Bundle? {

        if let resourceBundlePath = resourceBundlePath, let vResourceBundlePath = self.getResourceBundlePath(resourceBundlePath) {
            return Bundle.init(path: vResourceBundlePath)
        }
        if let resourceBundlePath = self.getResourceBundlePath() {
            return Bundle.init(path: resourceBundlePath)
        }
        return nil
    }
    
    
    /// 获取资源包路径 （bundleName 不传 则取当前工程名）
    /// - Parameter bundleName: 资源包名
    func getResourceBundlePath(_ bundleName: String? = nil) -> String? {

        if let bundleName = bundleName {
            return "\(bundle.bundlePath)/\(bundleName).bundle"
        }
        if let projectName = projectName {
            return "\(bundle.bundlePath)/\(projectName).bundle"
        }
        return nil
    }
    
    
    
}

extension NSObject: XPProjectResourceable {
    /// 加载本地图片
    public func loadLocalIamge(name: String) -> UIImage? {
        return UIImage.init(named: name, in: getResourceBundle(), compatibleWith: nil)
    }
    
}

