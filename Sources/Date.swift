//
//  Date.swift
//  Pencil
//
//  Created by naru on 2017/01/16.
//  Copyright © 2017年 naru. All rights reserved.
//

import Foundation

extension Date: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }
    
    public var pencilDataLength: Int {
        return MemoryLayout<Date>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var value: Date = self
        return [Data(buffer: UnsafeBufferPointer(start: &value, count: 1))]
    }
    
    public static func read(from components: Components) -> Date? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}
