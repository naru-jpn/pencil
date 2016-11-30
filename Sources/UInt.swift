//
//  UInt.swift
//  Pencil
//
//  Created by naru on 2016/10/17.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension UInt: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<UInt>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: UInt = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> UInt?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: UInt = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<UInt>.size)
        return value
    }
}

extension UInt8: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<UInt8>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: UInt8 = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> UInt8?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: UInt8 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<UInt8>.size)
        return value
    }
}

extension UInt16: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<UInt16>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: UInt16 = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> UInt16?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: UInt16 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<UInt16>.size)
        return value
    }
}

extension UInt32: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<UInt32>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: UInt32 = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> UInt32?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: UInt32 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<UInt32>.size)
        return value
    }
}

extension UInt64: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<UInt64>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: UInt64 = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> UInt64?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: UInt64 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<UInt64>.size)
        return value
    }
}
