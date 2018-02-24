//
//  NSNumber+SwiftyValue.swift
//  Writer
//
//  Created by naru on 2016/09/12.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

internal extension NSNumber {
    
    // Reference: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
    
    /// Return converted value to swifty value
    var swiftyValue: Any? {
        
        let objCType: String = String(cString: self.objCType)
        
        switch objCType {
        case "q":
            return self as! Int
        case "Q":
            return self as! UInt
        case "f":
            return self as! Float
        case "d":
            return self as! Double
        default:
            return nil
        }
    }
}
