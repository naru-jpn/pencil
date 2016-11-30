//
//  Float.swift
//  Pencil
//
//  Created by naru on 2016/10/17.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension Float: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<Float>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: Float = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> Float?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: Float = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<Float>.size)
        return value
    }
}
