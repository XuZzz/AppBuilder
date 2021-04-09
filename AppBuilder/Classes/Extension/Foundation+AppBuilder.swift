//
//  Foundation+AppBuilder.swift
//  AppBuilder
//
//  Created by 许朕 on 2021/4/9.
//

import Foundation


var is_iPhoneX: Bool {
    var isMore:Bool = false
    if #available(iOS 11.0, *) {
        if let window = UIApplication.shared.windows.first {
            isMore = window.safeAreaInsets.bottom > 0.0
        }
    }
    return isMore
}

extension CGFloat {
    static var tabbarHeight: CGFloat {
        if is_iPhoneX {
            return 82
        }else {
            return 49
        }
    }
}

extension Dictionary {
    
    var jsonData: Data? {
        if !JSONSerialization.isValidJSONObject(self) {
            print("is not a valid json object")
            return nil
        }
        
        let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        let string = String(data: data!, encoding: .utf8)
        
        print("JsonString: \(string ?? "")")
        return data
    }
    
}

extension UIScreen {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}
