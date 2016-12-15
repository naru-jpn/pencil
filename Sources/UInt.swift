//
//  UInt.swift
//  Pencil
//
//  Created by naru on 2016/10/17.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension UInt: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

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
    
    public static func read(from components: Components) -> UInt? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}

extension UInt8: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

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
    
    public static func read(from components: Components) -> UInt8? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}

extension UInt16: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

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
    
    public static func read(from components: Components) -> UInt16? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}

extension UInt32: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

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
    
    public static func read(from components: Components) -> UInt32? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}

extension UInt64: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

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
    
    public static func read(from components: Components) -> UInt64? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}
