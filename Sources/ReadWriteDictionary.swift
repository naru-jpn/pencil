//
//  ReadWriteDictionary.swift
//  Pencil
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension Dictionary where Value: ReadWriteElement {

    public static func value(from data: NSData) -> [String: Value]? {
        let value: [String: Value]? = Pencil.read(data)
        return value
    }
    
    public static func devide(data data: NSData) -> [String: NSData]? {
        
        let nameLength: UInt8 = { (data: NSData) -> UInt8 in
            return UInt8(data: data)
        }(data.subdata(from: 0, with: sizeof(UInt8)))
        
        debugPrint("data: \(data), \(nameLength), \(sizeof(UInt8))")
        
        // name
        var index: Int = sizeof(UInt8)
        let name = NSString(data: data.subdata(from: index, with: Int(nameLength)), encoding: NSUTF8StringEncoding) as? String ?? ""
        guard name == self.pencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.pencilName).")
            return nil
        }
        
        // count of pair
        index = index + Int(nameLength)
        let countOfPair: UInt8 = UInt8(data: data.subdata(from: index, with: sizeof(UInt8)))
        
        // lengths of key strings
        index = index + sizeof(UInt8)
        let keyLengths = data.subdata(from: index, with: sizeof(UInt8)*Int(countOfPair)).splited(with: sizeof(UInt8), repeated: Int(countOfPair)).map {
            Int(UInt8(data: $0))
        }
        let totalKeyLength: Int = keyLengths.reduce(0, combine: +)
        // lengths of values
        index = index + sizeof(UInt8)*Int(countOfPair)
        let valueLengths = data.subdata(from: index, with: sizeof(UInt8)*Int(countOfPair)).splited(with: sizeof(UInt8), repeated: Int(countOfPair)).map {
            Int(UInt8(data: $0))
        }
        let totalValueLength: Int = valueLengths.reduce(0, combine: +)
        
        // key strings
        index = index + sizeof(UInt8)*Int(countOfPair)
        let keys: [String] = data.subdata(from: index, with: totalKeyLength).splited(to: keyLengths).map {
            NSString(data: $0, encoding: NSUTF8StringEncoding) as? String ?? ""
        }
        
        // array of value data
        index = index + totalKeyLength
        let values: [NSData] = data.subdata(from: index, with: totalValueLength).splited(to: valueLengths)
        
        var result: [String: NSData] = [:]
        keys.enumerate().forEach { index, key in
            result[key] = values[index]
        }
        return result
    }
    
    public static func read(dictionary: [String: NSData]) -> [String: Value]? {
        
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
    
    public static func value(from data: NSData) -> [String: Value]? {
        let value: [String: Value]? = Pencil.read(data)
        return value
    }
    
    public static func devide(data data: NSData) -> [String: NSData]? {
        
        let nameLength: UInt8 = { (data: NSData) -> UInt8 in
            return UInt8(data: data)
        }(data.subdata(from: 0, with: sizeof(UInt8)))
        
        // name
        var index: Int = sizeof(UInt8)
        let name = NSString(data: data.subdata(from: index, with: Int(nameLength)), encoding: NSUTF8StringEncoding) as? String ?? ""
        guard name == self.pencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.pencilName).")
            return nil
        }
        
        // count of pair
        index = index + Int(nameLength)
        let countOfPair: UInt8 = UInt8(data: data.subdata(from: index, with: sizeof(UInt8)))
        
        // lengths of key strings
        index = index + sizeof(UInt8)
        let keyLengths = data.subdata(from: index, with: sizeof(UInt8)*Int(countOfPair)).splited(with: sizeof(UInt8), repeated: Int(countOfPair)).map {
            Int(UInt8(data: $0))
        }
        let totalKeyLength: Int = keyLengths.reduce(0, combine: +)
        // lengths of values
        index = index + sizeof(UInt8)*Int(countOfPair)
        let valueLengths = data.subdata(from: index, with: sizeof(UInt8)*Int(countOfPair)).splited(with: sizeof(UInt8), repeated: Int(countOfPair)).map {
            Int(UInt8(data: $0))
        }
        let totalValueLength: Int = valueLengths.reduce(0, combine: +)
        
        // key strings
        index = index + sizeof(UInt8)*Int(countOfPair)
        let keys: [String] = data.subdata(from: index, with: totalKeyLength).splited(to: keyLengths).map {
            NSString(data: $0, encoding: NSUTF8StringEncoding) as? String ?? ""
        }
        
        // array of value data
        index = index + totalKeyLength
        let values: [NSData] = data.subdata(from: index, with: totalValueLength).splited(to: valueLengths)
        
        var result: [String: NSData] = [:]
        keys.enumerate().forEach { index, key in
            result[key] = values[index]
        }
        return result
    }
    
    public static func read(dictionary: [String: NSData]) -> [String: Value]? {
        
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
        
        func unwrap(value: Any) -> Any? {
            let mirrored: Mirror = Mirror(reflecting: value)
            if mirrored.displayStyle != .Optional {
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
            return length + element.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        }
        let valuesLength: Int = writable.values.reduce(0) { (length: Int, element: Writable) -> Int in
            let identifierLength: Int = sizeof(UInt8) + element.pencilName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
            return length + identifierLength + element.pencilDataLength
        }
        
        return sizeof(UInt8)*(1 + writable.keys.count*2) + keysLength + valuesLength
    }
    
    public var pencilHead: [NSData] {
        
        let writable = self.writable
        let sortedKeys: [String] = writable.keys.sort()
        let sortedValues: [Writable] = sortedKeys.flatMap { writable[$0] }
        
        let count: NSData = {
            var num: UInt8 = UInt8(writable.keys.count)
            return NSData(bytes: &num, length: sizeof(UInt8))
        }()
        let keys: [NSData] = sortedKeys.map {
            var length: UInt8 = UInt8($0.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            return NSData(bytes: &length, length: sizeof(UInt8))
        }
        let values: [NSData] = sortedValues.map {
            let identifierLength: Int = sizeof(UInt8) + $0.pencilName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
            var length: UInt8 = UInt8(identifierLength + $0.pencilDataLength)
            return NSData(bytes: &length, length: sizeof(UInt8))
        }
        
        return [count] + keys + values
    }
    
    public var pencilBody: [NSData] {
        let writable = self.writable
        let sortedKeys: [String] = writable.keys.sort()
        let sortedValues: [Writable] = sortedKeys.flatMap { writable[$0] }
        return sortedKeys.map { $0.dataUsingEncoding(NSUTF8StringEncoding)! } + sortedValues.map { $0.data }
    }
}
