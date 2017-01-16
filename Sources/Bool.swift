//
//  Bool.swift
//  Pencil
//
//  Created by naru on 2017/01/16.
//  Copyright © 2017年 naru. All rights reserved.
//

import Foundation

extension Bool: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }
    
    public var pencilDataLength: Int {
        return MemoryLayout<Bool>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var value: Bool = self
        return [Data(buffer: UnsafeBufferPointer(start: &value, count: 1))]
    }
    
    public static func read(from components: Components) -> Bool? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}
