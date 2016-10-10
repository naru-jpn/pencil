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
        return MemoryLayout<Int>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: Int = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> Int?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: Int = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<Int>.size)
        return value
    }
}

extension String: ReadWriteElement {

    public var pencilDataLength: Int {
        return MemoryLayout<UInt8>.size + self.lengthOfBytes(using: String.Encoding.utf8)
    }
    
    public var pencilHead: [Data] {
        var count: UInt8 = UInt8(self.lengthOfBytes(using: String.Encoding.utf8))
        return [Data(buffer: UnsafeBufferPointer(start: &count, count: 1))]
    }
    
    public var pencilBody: [Data] {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return [Data()]
        }
        return [data]
    }
    
    public static var read: ((Components) -> String?) = { components in
            
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
            
        let length: UInt8 = UInt8(data: data.subdata(in: 0..<MemoryLayout<UInt8>.size))
        let subdata = data.subdata(from: MemoryLayout<UInt8>.size, with: Int(length))
        return NSString(data: subdata, encoding: String.Encoding.utf8.rawValue) as? String
    }
}
