//
//  ReadWriteArray.swift
//  Pencil
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension Array where Element: ReadWriteElement {

    public static func value(from data: NSData) -> [Element]? {
        let value: [Element]? = Pencil.read(data)
        return value
    }
    
    public static func devide(data data: NSData) -> [NSData]? {
        
        // check identifier of data
        let length: Int = { (data: NSData) -> Int in
            return Int(UInt8(data: data))
        }(data.subdata(from: 0, with: sizeof(UInt8)))
        
        let name = NSString(data: data.subdata(from: sizeof(UInt8), with: length), encoding: NSUTF8StringEncoding) as? String ?? ""
        
        guard name == self.pencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.pencilName).")
            return nil
        }
        
        // count of element
        var index = sizeof(UInt8) + length
        let countOfElement: UInt8 = UInt8(data: data.subdata(from: index, with: sizeof(UInt8)))
        
        // lengths of elements
        index = index + sizeof(UInt8)
        let lengths = data.subdata(from: index, with: sizeof(UInt8)*Int(countOfElement)).splited(with: sizeof(UInt8), repeated: Int(countOfElement)).map {
            Int(UInt8(data: $0))
        }
        
        // array of data
        index = index + sizeof(UInt8)*Int(countOfElement)
        let values: [NSData] = data.subdata(from: index, with: data.length - index).splited(to: lengths)
        return values
    }
    
    public static func read(values: [NSData]) -> [Element]? {
                
        let elements = values.flatMap { (data: NSData) -> Element? in
            let element: Element? = Pencil.read(data)
            return element
        }
        return elements
    }
}

extension Array where Element: CustomReadWriteElement {
    
    public static func value(from data: NSData) -> [Element]? {
        let value: [Element]? = Pencil.read(data)
        return value
    }
    
    public static func devide(data data: NSData) -> [NSData]? {
        
        // check identifier of data
        let length: Int = { (data: NSData) -> Int in
            return Int(UInt8(data: data))
        }(data.subdata(from: 0, with: sizeof(UInt8)))
        
        let name = NSString(data: data.subdata(from: sizeof(UInt8), with: length), encoding: NSUTF8StringEncoding) as? String ?? ""
        
        guard name == self.pencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.pencilName).")
            return nil
        }
        
        // count of element
        var index = sizeof(UInt8) + length
        let countOfElement: UInt8 = UInt8(data: data.subdata(from: index, with: sizeof(UInt8)))
        
        // lengths of elements
        index = index + sizeof(UInt8)
        let lengths = data.subdata(from: index, with: sizeof(UInt8)*Int(countOfElement)).splited(with: sizeof(UInt8), repeated: Int(countOfElement)).map {
            Int(UInt8(data: $0))
        }
        
        // array of data
        index = index + sizeof(UInt8)*Int(countOfElement)
        let values: [NSData] = data.subdata(from: index, with: data.length - index).splited(to: lengths)
        return values
    }
    
    public static func read(values: [NSData]) -> [Element]? {
        
        let elements = values.flatMap { (data: NSData) -> Element? in
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
        let elementsLength: Int = packables.reduce(0, combine: {
            $0 + sizeof(UInt8) + $1.pencilName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) + $1.pencilDataLength
        })
        return sizeof(UInt8)*(1+packables.count) + elementsLength
    }
    
    public var pencilHead: [NSData] {
        
        let writables: [Writable] = self.writable()
        
        let count: NSData = {
            var num: UInt8 = UInt8(writables.count)
            return NSData(bytes: &num, length: sizeof(UInt8))
        }()
        
        let data: [NSData] = writables.map { (writable: Writable) -> Int in
            let identifierLength: Int = sizeof(UInt8) + writable.pencilName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
            return identifierLength + writable.pencilDataLength
        }.map { (length: Int) -> NSData  in
            var num: UInt8 = UInt8(length)
            return NSData(bytes: &num, length: sizeof(UInt8))
        }
        
        return [count] + data
    }
    
    public var pencilBody: [NSData] {
        let writables: [Writable] = self.writable()
        let data: [NSData] = writables.map { element in
            return element.data
        }
        return data
    }
}
