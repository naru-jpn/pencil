//
//  CustomReadWriteElement.swift
//  Pencil
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

public protocol CustomReadWriteElement: ReadWrite { }

extension CustomReadWriteElement {

    public static func value(from data: NSData) -> Self? {
        let value: Self? = Pencil.read(data)
        return value
    }
    
    public static func devide(data data: NSData) -> Components? {
        
        let nameLength: UInt8 = { (data: NSData) -> UInt8 in
            return UInt8(data: data)
        }(data.subdata(from: 0, with: sizeof(UInt8)))
        
        // name
        var index: Int = sizeof(UInt8)
        let name = NSString(data: data.subdata(from: index, with: Int(nameLength)), encoding: NSUTF8StringEncoding) as? String ?? ""
        guard name == self.pencilName else {
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
        
        var result: MapData = [:]
        keys.enumerate().forEach { index, key in
            result[key] = values[index]
        }
        return Components(dictionary: result)
    }
    
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
        Mirror(reflecting: self).children.forEach { label, value in
            if let label = label, value = unwrap(value) as? Writable {
                writable[label] = value
            }
        }
        
        return writable
    }
    
    public var pencilDataLength: Int {
        return self.writable.pencilDataLength
    }
    
    public var pencilHead: [NSData] {
        return self.writable.pencilHead
    }
    
    public var pencilBody: [NSData] {
        return self.writable.pencilBody
    }
}

