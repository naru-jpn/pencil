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
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

    public static func value(from url: URL, options: Data.ReadingOptions = []) -> Self? {
        do {
            let data: Data = try Data(contentsOf: url, options: options)
            let value: Self? = self.value(from: data)
            return value
        } catch {
            return nil
        }
    }

    public static func value(from data: Data) -> Self? {
        let value: Self? = Pencil.read(data)
        return value
    }
    
    public static func devide(data: Data) -> Components? {
        
        let nameLength: UInt8 = { (data: Data) -> UInt8 in
            return UInt8(data: data)
        }(data.subdata(from: 0, with: MemoryLayout<UInt8>.size))
        
        // name
        var index: Int = MemoryLayout<UInt8>.size
        let data: Data = data.subdata(from: index, with: Int(nameLength))
        let name: String = String(data: data, encoding: .utf8) ?? ""
        guard name == self.sPencilName else {
            return nil
        }
        
        // count of pair
        index = index + Int(nameLength)
        let countOfPair: UInt16 = UInt16(data: data.subdata(from: index, with: MemoryLayout<UInt16>.size))
        
        // lengths of key strings
        index = index + MemoryLayout<UInt16>.size
        let keyLengths = data.subdata(from: index, with: MemoryLayout<UInt32>.size*Int(countOfPair)).splited(with: MemoryLayout<UInt32>.size, repeated: Int(countOfPair)).map {
            Int(UInt32(data: $0))
        }
        let totalKeyLength: Int = keyLengths.reduce(0, +)
        // lengths of values
        index = index + MemoryLayout<UInt32>.size*Int(countOfPair)
        let valueLengths = data.subdata(from: index, with: MemoryLayout<UInt32>.size*Int(countOfPair)).splited(with: MemoryLayout<UInt32>.size, repeated: Int(countOfPair)).map {
            Int(UInt32(data: $0))
        }
        let totalValueLength: Int = valueLengths.reduce(0, +)
        
        // key strings
        index = index + MemoryLayout<UInt32>.size*Int(countOfPair)
        let keys: [String] = data.subdata(from: index, with: totalKeyLength).splited(to: keyLengths).map {
            String(data: $0, encoding: .utf8) ?? ""
        }
        
        // array of value data
        index = index + totalKeyLength
        let values: [Data] = data.subdata(from: index, with: totalValueLength).splited(to: valueLengths)
        
        var result: [String: Data] = [:]
        keys.enumerated().forEach { index, key in
            result[key] = values[index]
        }
        return Components(dictionary: result)
    }
    
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
        Mirror(reflecting: self).children.forEach { label, value in
            if let label = label, let value = unwrap(value) as? Writable {
                writable[label] = value
            }
        }
        
        return writable
    }
    
    public var pencilDataLength: Int {
        return self.writable.pencilDataLength
    }
    
    public var pencilHead: [Data] {
        return self.writable.pencilHead as [Data]
    }
    
    public var pencilBody: [Data] {
        return self.writable.pencilBody as [Data]
    }
}

