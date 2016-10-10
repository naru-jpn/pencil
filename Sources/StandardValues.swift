//
//  StandardValues.swift
//  Pencil
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension Int: ReadWriteElement {

    public var pencilDataLength: Int {
        return sizeof(Int)
    }
    
    public var pencilHead: [NSData] {
        return [NSData()]
    }
    
    public var pencilBody: [NSData] {
        var num: Int = self
        return [NSData(bytes: &num, length: sizeof(Int))]
    }
    
    public static var read: (Components -> Int?) = { components in
        
        guard let data: NSData = components.dictionary["value"] else {
            return nil
        }
        
        var value: Int = 0
        data.getBytes(&value, length: sizeof(Int))
        return value
    }
}

extension String: ReadWriteElement {

    public var pencilDataLength: Int {
        return sizeof(UInt8) + self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }
    
    public var pencilHead: [NSData] {
        var count: UInt8 = UInt8(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        return [NSData(bytes: &count, length: sizeof(UInt8))]
    }
    
    public var pencilBody: [NSData] {
        guard let data = self.dataUsingEncoding(NSUTF8StringEncoding) else {
            return [NSData()]
        }
        return [data]
    }
    
    public static var read: (Components -> String?) = { components in
            
        guard let data: NSData = components.dictionary["value"] else {
            return nil
        }
            
        let length: UInt8 = UInt8(data: data.subdataWithRange(NSMakeRange(0, sizeof(UInt8))))
        let subdata = data.subdata(from: sizeof(UInt8), with: Int(length))
        return NSString(data: subdata, encoding: NSUTF8StringEncoding) as? String
    }
}
