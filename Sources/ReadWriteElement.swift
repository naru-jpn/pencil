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

    public static func value(from data: NSData) -> Self? {
        let value: Self? = Pencil.read(data)
        return value
    }
    
    public func write(to filePath: String, atomically: Bool) -> Bool {
        let data: NSData = self.data
        return data.writeToFile(filePath, atomically: atomically)
    }
    
    public static func devide(data data: NSData) -> Components? {
        
        let length: Int = { (data: NSData) -> Int in
            return Int(UInt8(data: data))
        }(data.subdata(from: 0, with: sizeof(UInt8)))
        
        let name = NSString(data: data.subdata(from: sizeof(UInt8), with: length), encoding: NSUTF8StringEncoding) as? String ?? ""
        
        guard name == self.pencilName else {
            debugPrint("pencil: Type of data is \(name) but applying types is \(self.pencilName).")
            return nil
        }
        
        let index = sizeof(UInt8) + length
        let value = data.subdata(from: index, with: (data.length - index))
                
        return Components(dictionary: ["value": value])
    }
}
