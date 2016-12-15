//
//  Float.swift
//  Pencil
//
//  Created by naru on 2016/10/17.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension Float: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

    public var pencilDataLength: Int {
        return MemoryLayout<Float>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: Float = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static func read(from components: Components) -> Float? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}
