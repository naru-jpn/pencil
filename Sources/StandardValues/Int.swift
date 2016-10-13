//
//  Int.swift
//  Pencil
//
//  Created by naru on 2016/10/13.
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
