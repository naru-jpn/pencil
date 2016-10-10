//
//  Writable.swift
//  Pencil
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

/// Protocol to convert value to data
public protocol Writable {
    
    /// Name. (Implemented default behavior.)
//    static var pencilName: String { get }
    
    /// Name. (Implemented default behavior.)
//    var pencilName: String { get }
    
    /// Number of bytes of the whole written data.
    var pencilDataLength: Int { get }
    
    /// Identifier of data.
//    public var pencilIdentifier: NSData { get }
    
    /// Metadata for the written data.
    var pencilHead: [Data] { get }
    
    /// Body data for the written data.
    var pencilBody: [Data] { get }

    /// The whole of written data. (Implemented default behavior.)
//    var writerData: NSData { get }
}

// Default implementations for the Writable.
public extension Writable {
    
    /// name of type
    public static var sPencilName: String {
        return "\(self)"
    }
    
    /// name of type
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }
    
    /// Identifier of data
    public var pencilIdentifier: Data {
        // count
        let name: String = self.pencilName
        var count: UInt8 = UInt8(name.lengthOfBytes(using: String.Encoding.utf8))
        // + identifier string
        let identifierData: NSMutableData = NSMutableData(bytes: &count, length: MemoryLayout<UInt8>.size)
        if let data = name.data(using: String.Encoding.utf8) {
            identifierData.append(data)
        }
        return identifierData as Data
    }
    
    /// Whole of written data
    public var data: Data {
        let data: NSMutableData = NSMutableData(data: self.pencilIdentifier)
        for subdata in self.pencilHead + self.pencilBody {
            data.append(subdata)
        }
        return NSData(data: data as Data) as Data
    }
}
