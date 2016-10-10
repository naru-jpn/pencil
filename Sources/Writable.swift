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
    var pencilHead: [NSData] { get }
    
    /// Body data for the written data.
    var pencilBody: [NSData] { get }

    /// The whole of written data. (Implemented default behavior.)
//    var writerData: NSData { get }
}

// Default implementations for the Writable.
public extension Writable {
    
    /// name of type
    public static var pencilName: String {
        return "\(self)"
    }
    
    /// name of type
    public var pencilName: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }
    
    /// Identifier of data
    public var pencilIdentifier: NSData {
        // count
        let name: String = self.pencilName
        var count: UInt8 = UInt8(name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        // + identifier string
        let identifierData: NSMutableData = NSMutableData(bytes: &count, length: sizeof(UInt8))
        if let data = name.dataUsingEncoding(NSUTF8StringEncoding) {
            identifierData.appendData(data)
        }
        return identifierData
    }
    
    /// Whole of written data
    public var data: NSData {
        let data: NSMutableData = NSMutableData(data: self.pencilIdentifier)
        for subdata in self.pencilHead + self.pencilBody {
            data.appendData(subdata)
        }
        return NSData(data: data)
    }
}
