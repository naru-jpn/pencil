//
//  ReadWriteElement.swift
//  Pencil
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

public protocol ReadWriteElement: ReadWrite { }

extension ReadWriteElement {

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
        
        let length: Int = { (data: Data) -> Int in
            return Int(UInt8(data: data))
        }(data.subdata(from: 0, with: MemoryLayout<UInt8>.size))
        
        let name: String = String(data: data.subdata(from: MemoryLayout<UInt8>.size, with: Int(length)), encoding: .utf8) ?? ""
        guard name == self.sPencilName else {
            debugPrint("pencil: Type of data is \(name) but applying types is \(self.sPencilName).")
            return nil
        }
        
        let index = MemoryLayout<UInt8>.size + length
        let value = data.subdata(from: index, with: (data.count - index))
                
        return Components(dictionary: ["value": value])
    }
}
