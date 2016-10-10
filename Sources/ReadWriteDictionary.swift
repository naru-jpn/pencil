//
//  ReadWriteDictionary.swift
//  Pencil
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension Dictionary where Value: ReadWriteElement {

    public static func value(from data: Data) -> [String: Value]? {
        let value: [String: Value]? = Pencil.read(data)
        return value
    }
    
    public static func devide(data: Data) -> [String: Data]? {
        
        let nameLength: UInt8 = { (data: Data) -> UInt8 in
            return UInt8(data: data)
        }(data.subdata(from: 0, with: MemoryLayout<UInt8>.size))
                
        // name
        var index: Int = MemoryLayout<UInt8>.size
        let name = NSString(data: data.subdata(from: index, with: Int(nameLength)), encoding: String.Encoding.utf8.rawValue) as? String ?? ""
        guard name == self.sPencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.sPencilName).")
            return nil
        }
        
        // count of pair
        index = index + Int(nameLength)
        let countOfPair: UInt8 = UInt8(data: data.subdata(from: index, with: MemoryLayout<UInt8>.size))
        
        // lengths of key strings
        index = index + MemoryLayout<UInt8>.size
        let keyLengths = data.subdata(from: index, with: MemoryLayout<UInt8>.size*Int(countOfPair)).splited(with: MemoryLayout<UInt8>.size, repeated: Int(countOfPair)).map {
            Int(UInt8(data: $0))
        }
        let totalKeyLength: Int = keyLengths.reduce(0, +)
        // lengths of values
        index = index + MemoryLayout<UInt8>.size*Int(countOfPair)
        let valueLengths = data.subdata(from: index, with: MemoryLayout<UInt8>.size*Int(countOfPair)).splited(with: MemoryLayout<UInt8>.size, repeated: Int(countOfPair)).map {
            Int(UInt8(data: $0))
        }
        let totalValueLength: Int = valueLengths.reduce(0, +)
        
        // key strings
        index = index + MemoryLayout<UInt8>.size*Int(countOfPair)
        let keys: [String] = data.subdata(from: index, with: totalKeyLength).splited(to: keyLengths).map {
            NSString(data: $0, encoding: String.Encoding.utf8.rawValue) as? String ?? ""
        }
        
        // array of value data
        index = index + totalKeyLength
        let values: [Data] = data.subdata(from: index, with: totalValueLength).splited(to: valueLengths)
        
        var result: [String: Data] = [:]
        keys.enumerated().forEach { index, key in
            result[key] = values[index]
        }
        return result
    }
    
    public static func read(_ dictionary: [String: Data]) -> [String: Value]? {
        
        var result: [String: Value] = [:]
        dictionary.forEach { key, data in
            if let element: Value = Pencil.read(data) {
                result[key] = element
            }
        }
        return result
    }
}

extension Dictionary where Value: CustomReadWriteElement {
    
    public static func value(from data: Data) -> [String: Value]? {
        let value: [String: Value]? = Pencil.read(data)
        return value
    }
    
    public static func devide(data: Data) -> [String: Data]? {
        
        let nameLength: UInt8 = { (data: Data) -> UInt8 in
            return UInt8(data: data)
        }(data.subdata(from: 0, with: MemoryLayout<UInt8>.size))
        
        // name
        var index: Int = MemoryLayout<UInt8>.size
        let name = NSString(data: data.subdata(from: index, with: Int(nameLength)), encoding: String.Encoding.utf8.rawValue) as? String ?? ""
        guard name == self.sPencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.sPencilName).")
            return nil
        }
        
        // count of pair
        index = index + Int(nameLength)
        let countOfPair: UInt8 = UInt8(data: data.subdata(from: index, with: MemoryLayout<UInt8>.size))
        
        // lengths of key strings
        index = index + MemoryLayout<UInt8>.size
        let keyLengths = data.subdata(from: index, with: MemoryLayout<UInt8>.size*Int(countOfPair)).splited(with: MemoryLayout<UInt8>.size, repeated: Int(countOfPair)).map {
            Int(UInt8(data: $0))
        }
        let totalKeyLength: Int = keyLengths.reduce(0, +)
        // lengths of values
        index = index + MemoryLayout<UInt8>.size*Int(countOfPair)
        let valueLengths = data.subdata(from: index, with: MemoryLayout<UInt8>.size*Int(countOfPair)).splited(with: MemoryLayout<UInt8>.size, repeated: Int(countOfPair)).map {
            Int(UInt8(data: $0))
        }
        let totalValueLength: Int = valueLengths.reduce(0, +)
        
        // key strings
        index = index + MemoryLayout<UInt8>.size*Int(countOfPair)
        let keys: [String] = data.subdata(from: index, with: totalKeyLength).splited(to: keyLengths).map {
            NSString(data: $0, encoding: String.Encoding.utf8.rawValue) as? String ?? ""
        }
        
        // array of value data
        index = index + totalKeyLength
        let values: [Data] = data.subdata(from: index, with: totalValueLength).splited(to: valueLengths)
        
        var result: [String: Data] = [:]
        keys.enumerated().forEach { index, key in
            result[key] = values[index]
        }
        return result
    }
    
    public static func read(_ dictionary: [String: Data]) -> [String: Value]? {
        
        var result: [String: Value] = [:]
        dictionary.forEach { key, data in
            if let element: Value = Pencil.read(data) {
                result[key] = element
            }
        }
        return result
    }
}

extension Dictionary: Writable {

    public var writable: [String: Writable] {
        
        func unwrap(_ value: Any) -> Any? {
            let mirrored: Mirror = Mirror(reflecting: value)
            if mirrored.displayStyle != .optional {
                return value
            } else {
                if mirrored.children.count == 0 {
                    return nil
                } else {
                    return unwrap(mirrored.children.first!.value)
                }
            }
        }
        
        var writable: [String: Writable] = [:]
        for (key, value) in self {
            if let key = key as? String, let value = unwrap(value) as? Writable {
                writable[key] = value
            }
        }
        return writable
    }
    
    public var pencilDataLength: Int {
        
        let writable = self.writable
        
        let keysLength: Int = writable.keys.reduce(0) { (length: Int, element: String) -> Int in
            return length + element.lengthOfBytes(using: String.Encoding.utf8)
        }
        let valuesLength: Int = writable.values.reduce(0) { (length: Int, element: Writable) -> Int in
            let identifierLength: Int = MemoryLayout<UInt8>.size + element.pencilName.lengthOfBytes(using: String.Encoding.utf8)
            return length + identifierLength + element.pencilDataLength
        }
        
        return MemoryLayout<UInt8>.size*(1 + writable.keys.count*2) + keysLength + valuesLength
    }
    
    public var pencilHead: [Data] {
        
        let writable = self.writable
        let sortedKeys: [String] = writable.keys.sorted()
        let sortedValues: [Writable] = sortedKeys.flatMap { writable[$0] }
        
        let count: Data = {
            var num: UInt8 = UInt8(writable.keys.count)
            return Data(buffer: UnsafeBufferPointer(start: &num, count: 1))//Data(bytes: UnsafePointer<UInt8>(&num), count: MemoryLayout<UInt8>.size)
        }()
        let keys: [Data] = sortedKeys.map {
            var length: UInt8 = UInt8($0.lengthOfBytes(using: String.Encoding.utf8))
            return Data(buffer: UnsafeBufferPointer(start: &length, count: 1))//Data(bytes: UnsafePointer<UInt8>(&length), count: MemoryLayout<UInt8>.size)
        }
        let values: [Data] = sortedValues.map {
            let identifierLength: Int = MemoryLayout<UInt8>.size + $0.pencilName.lengthOfBytes(using: String.Encoding.utf8)
            var length: UInt8 = UInt8(identifierLength + $0.pencilDataLength)
            return Data(buffer: UnsafeBufferPointer(start: &length, count: 1))//Data(bytes: UnsafePointer<UInt8>(&length), count: MemoryLayout<UInt8>.size)
        }
        
        return [count] + keys + values
    }
    
    public var pencilBody: [Data] {
        let writable = self.writable
        let sortedKeys: [String] = writable.keys.sorted()
        let sortedValues: [Writable] = sortedKeys.flatMap { writable[$0] }
        return sortedKeys.map { $0.data(using: String.Encoding.utf8)! } + sortedValues.map { ($0.data as Data) }
    }
}
