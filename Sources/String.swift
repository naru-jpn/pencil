//
//  String.swift
//  Pencil
//
//  Created by naru on 2016/10/13.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension String: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

    public var pencilDataLength: Int {
        return MemoryLayout<UInt16>.size + self.lengthOfBytes(using: String.Encoding.utf8)
    }
    
    public var pencilHead: [Data] {
        var count: UInt16 = UInt16(self.lengthOfBytes(using: String.Encoding.utf8))
        return [Data(buffer: UnsafeBufferPointer(start: &count, count: 1))]
    }
    
    public var pencilBody: [Data] {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return [Data()]
        }
        return [data]
    }
    
    public static func read(from components: Components) -> String? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        let length: UInt16 = UInt16(data: data.subdata(in: 0..<MemoryLayout<UInt16>.size))
        let subdata = data.subdata(from: MemoryLayout<UInt16>.size, with: Int(length))
        return NSString(data: subdata, encoding: String.Encoding.utf8.rawValue) as? String
    }
}
