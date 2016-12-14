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
    
    public static func read(from components: Components) -> Int? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
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
    
    public static func read(from components: Components) -> Int8? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
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
    
    public static func read(from components: Components) -> Int16? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
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
    
    public static func read(from components: Components) -> Int32? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
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
    
    public static func read(from components: Components) -> Int64? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}
