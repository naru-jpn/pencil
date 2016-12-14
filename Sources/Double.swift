//
//  Double.swift
//  Pencil
//
//  Created by naru on 2016/10/17.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension Double: ReadWriteElement {
    
    public var pencilDataLength: Int {
        return MemoryLayout<Double>.size
    }
    
    public var pencilHead: [Data] {
        return [Data()]
    }
    
    public var pencilBody: [Data] {
        var num: Double = self
        return [Data(buffer: UnsafeBufferPointer(start: &num, count: 1))]
    }
    
    public static func read(from components: Components) -> Double? {
        guard let data: Data = components.dictionary["value"] as Data? else {
            return nil
        }
        return data.withUnsafeBytes{ $0.pointee }
    }
}
