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

extension Int8: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<Int8>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: Int8 = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> Int8?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: Int8 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<Int8>.size)
        return value
    }
}

extension Int16: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<Int16>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: Int16 = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> Int16?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: Int16 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<Int16>.size)
        return value
    }
}

extension Int32: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<Int32>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: Int32 = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> Int32?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: Int32 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<Int32>.size)
        return value
    }
}

extension Int64: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<Int64>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: Int64 = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static var read: ((Components) -> Int64?) = { components in
        
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        
        var value: Int64 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<Int64>.size)
        return value
    }
}
