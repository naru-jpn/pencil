//
//  ReadWriteArray.swift
//  Pencil
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension Array where Element: ReadWriteElement {

    public static func value(from url: URL, options: Data.ReadingOptions = []) -> [Element]? {
        do {
            let data: Data = try Data(contentsOf: url, options: options)
            let value: [Element]? = self.value(from: data)
            return value
        } catch {
            return nil
        }
    }
    
    public static func value(from data: Data) -> [Element]? {
        let value: [Element]? = Pencil.read(data)
        return value
    }
    
    public static func devide(data: Data) -> [Data]? {
        
        // check identifier of data
        let length: Int = { (data: Data) -> Int in
            return Int(UInt8(data: data))
        }(data.subdata(from: 0, with: MemoryLayout<UInt8>.size))
        
        let name = NSString(data: data.subdata(from: MemoryLayout<UInt8>.size, with: length), encoding: String.Encoding.utf8.rawValue) as? String ?? ""
        
        guard name == self.sPencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.sPencilName).")
            return nil
        }
        
        // count of element
        var index = MemoryLayout<UInt8>.size + length
        let countOfElement: UInt8 = UInt8(data: data.subdata(from: index, with: MemoryLayout<UInt8>.size))
        
        // lengths of elements
        index = index + MemoryLayout<UInt8>.size
        let lengths = data.subdata(from: index, with: MemoryLayout<UInt8>.size*Int(countOfElement)).splited(with: MemoryLayout<UInt8>.size, repeated: Int(countOfElement)).map {
            Int(UInt8(data: $0))
        }
        
        // array of data
        index = index + MemoryLayout<UInt8>.size*Int(countOfElement)
        let values: [Data] = data.subdata(from: index, with: data.count - index).splited(to: lengths)
        return values
    }
    
    public static func read(_ values: [Data]) -> [Element]? {
                
        let elements = values.flatMap { (data: Data) -> Element? in
            let element: Element? = Pencil.read(data)
            return element
        }
        return elements
    }
}

extension Array where Element: CustomReadWriteElement {
    
    public static func value(from data: Data) -> [Element]? {
        let value: [Element]? = Pencil.read(data)
        return value
    }
    
    public static func devide(data: Data) -> [Data]? {
        
        // check identifier of data
        let length: Int = { (data: Data) -> Int in
            return Int(UInt8(data: data))
        }(data.subdata(from: 0, with: MemoryLayout<UInt8>.size))
        
        let name = NSString(data: data.subdata(from: MemoryLayout<UInt8>.size, with: length), encoding: String.Encoding.utf8.rawValue) as? String ?? ""
        
        guard name == self.sPencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.sPencilName).")
            return nil
        }
        
        // count of element
        var index = MemoryLayout<UInt8>.size + length
        let countOfElement: UInt8 = UInt8(data: data.subdata(from: index, with: MemoryLayout<UInt8>.size))
        
        // lengths of elements
        index = index + MemoryLayout<UInt8>.size
        let lengths = data.subdata(from: index, with: MemoryLayout<UInt8>.size*Int(countOfElement)).splited(with: MemoryLayout<UInt8>.size, repeated: Int(countOfElement)).map {
            Int(UInt8(data: $0))
        }
        
        // array of data
        index = index + MemoryLayout<UInt8>.size*Int(countOfElement)
        let values: [Data] = data.subdata(from: index, with: data.count - index).splited(to: lengths)
        return values
    }
    
    public static func read(_ values: [Data]) -> [Element]? {
        
        let elements = values.flatMap { (data: Data) -> Element? in
            let element: Element? = Pencil.read(data)
            return element
        }
        return elements
    }
}

extension Array: Writable {

    public func writable() -> [Writable] {
        return self.flatMap {
            switch $0 {
            case is Writable:
                return $0 as? Writable
            case is NSNumber:
                return ($0 as! NSNumber).swiftyValue as? Writable
            case is NSString:
                return ($0 as! NSString) as String
            default:
                return nil
            }
        }
    }
    
    public var pencilDataLength: Int {
        let packables: [Writable] = self.writable()
        let elementsLength: Int = packables.reduce(0, {
            $0 + MemoryLayout<UInt8>.size + $1.pencilName.lengthOfBytes(using: String.Encoding.utf8) + $1.pencilDataLength
        })
        return MemoryLayout<UInt8>.size*(1+packables.count) + elementsLength
    }
    
    public var pencilHead: [Data] {
        
        let writables: [Writable] = self.writable()
        
        let count: Data = {
            var num: UInt8 = UInt8(writables.count)
            return Data(buffer: UnsafeBufferPointer(start: &num, count: 1))//Data(bytes: UnsafePointer<UInt8>(&num), count: MemoryLayout<UInt8>.size)
        }()
        
        let data: [Data] = writables.map { (writable: Writable) -> Int in
            let identifierLength: Int = MemoryLayout<UInt8>.size + writable.pencilName.lengthOfBytes(using: String.Encoding.utf8)
            return identifierLength + writable.pencilDataLength
        }.map { (length: Int) -> Data  in
            var num: UInt8 = UInt8(length)
            return Data(buffer: UnsafeBufferPointer(start: &num, count: 1))//Data(bytes: UnsafePointer<UInt8>(&num), count: MemoryLayout<UInt8>.size)
        }
        
        return [count] + data
    }
    
    public var pencilBody: [Data] {
        let writables: [Writable] = self.writable()
        let data: [Data] = writables.map { element in
            return (element.data as Data)
        }
        return data
    }
}
