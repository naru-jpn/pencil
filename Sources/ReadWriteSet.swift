//
//  ReadWriteSet.swift
//  Pencil
//
//  Created by Naruki Chigira on 2017/02/07.
//  Copyright © 2017年 naru. All rights reserved.
//

import Foundation

extension Set where Element: ReadWriteElement {
    
    public static func value(from url: URL, options: Data.ReadingOptions = []) -> Set<Element>? {
        do {
            let data: Data = try Data(contentsOf: url, options: options)
            let value: Set<Element>? = self.value(from: data)
            return value
        } catch {
            return nil
        }
    }
    
    public static func value(from data: Data) -> Set<Element>? {
        let value: Set<Element>? = Pencil.read(data)
        return value
    }
    
    public static func devide(data: Data) -> [Data]? {
        
        // check identifier of data
        let length: Int = { (data: Data) -> Int in
            return Int(UInt8(data: data))
        }(data.subdata(from: 0, with: MemoryLayout<UInt8>.size))
        
        let data: Data = data.subdata(from: MemoryLayout<UInt8>.size, with: Int(length))
        let name: String = String(data: data, encoding: .utf8) ?? ""
        
        guard name == self.sPencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.sPencilName).")
            return nil
        }
        
        // count of element
        var index = MemoryLayout<UInt8>.size + length
        let countOfElement: UInt16 = UInt16(data: data.subdata(from: index, with: MemoryLayout<UInt16>.size))
        
        // lengths of elements
        index = index + MemoryLayout<UInt16>.size
        let lengths = data.subdata(from: index, with: MemoryLayout<UInt32>.size*Int(countOfElement)).splited(with: MemoryLayout<UInt32>.size, repeated: Int(countOfElement)).map {
            Int(UInt32(data: $0))
        }
        
        // array of data
        index = index + MemoryLayout<UInt32>.size*Int(countOfElement)
        let values: [Data] = data.subdata(from: index, with: data.count - index).splited(to: lengths)
        return values
    }
    
    public static func read(_ values: [Data]) -> Set<Element>? {
        
        let elements = values.flatMap { (data: Data) -> Element? in
            let element: Element? = Pencil.read(data)
            return element
        }
        return Set(elements)
    }
}

extension Set where Element: CustomReadWriteElement {
    
    public static func value(from url: URL, options: Data.ReadingOptions = []) -> Set<Element>? {
        do {
            let data: Data = try Data(contentsOf: url, options: options)
            let value: Set<Element>? = self.value(from: data)
            return value
        } catch {
            return nil
        }
    }
    
    public static func value(from data: Data) -> Set<Element>? {
        let value: Set<Element>? = Pencil.read(data)
        return value
    }
    
    public static func devide(data: Data) -> [Data]? {
        
        // check identifier of data
        let length: Int = { (data: Data) -> Int in
            return Int(UInt8(data: data))
        }(data.subdata(from: 0, with: MemoryLayout<UInt8>.size))
        let data: Data = data.subdata(from: MemoryLayout<UInt8>.size, with: Int(length))
        let name: String = String(data: data, encoding: .utf8) ?? ""
        
        guard name == self.sPencilName else {
            debugPrint("pencil: Type of data is \(name) but applying type is \(self.sPencilName).")
            return nil
        }
        
        // count of element
        var index = MemoryLayout<UInt8>.size + length
        let countOfElement: UInt16 = UInt16(data: data.subdata(from: index, with: MemoryLayout<UInt16>.size))
        
        // lengths of elements
        index = index + MemoryLayout<UInt16>.size
        let lengths = data.subdata(from: index, with: MemoryLayout<UInt32>.size*Int(countOfElement)).splited(with: MemoryLayout<UInt32>.size, repeated: Int(countOfElement)).map {
            Int(UInt32(data: $0))
        }
        
        // array of data
        index = index + MemoryLayout<UInt32>.size*Int(countOfElement)
        let values: [Data] = data.subdata(from: index, with: data.count - index).splited(to: lengths)
        return values
    }
    
    public static func read(_ values: [Data]) -> Set<Element>? {
        
        let elements = values.flatMap { (data: Data) -> Element? in
            let element: Element? = Pencil.read(data)
            return element
        }
        return Set(elements)
    }
}

extension Set: Writable {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }
    
    public func writable() -> [Writable] {
        return self.flatMap {
            return $0 as? Writable
        }
    }
    
    public var pencilDataLength: Int {
        let writables: [Writable] = self.writable()
        let elementsLength: Int = writables.reduce(0, {
            $0 + MemoryLayout<UInt8>.size + $1.pencilName.lengthOfBytes(using: String.Encoding.utf8) + $1.pencilDataLength
        })
        return MemoryLayout<UInt16>.size + MemoryLayout<UInt32>.size*writables.count + elementsLength
    }
    
    public var pencilHead: [Data] {
        
        let writables: [Writable] = self.writable()
        
        let count: Data = {
            var num: UInt16 = UInt16(writables.count)
            return Data(buffer: UnsafeBufferPointer(start: &num, count: 1))
        }()
        
        let data: [Data] = writables.map { (writable: Writable) -> Int in
            let identifierLength: Int = MemoryLayout<UInt8>.size + writable.pencilName.lengthOfBytes(using: String.Encoding.utf8)
            return identifierLength + writable.pencilDataLength
            }.map { (length: Int) -> Data  in
                var num: UInt32 = UInt32(length)
                return Data(buffer: UnsafeBufferPointer(start: &num, count: 1))
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
