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
    
    /// Name.
    static var sPencilName: String { get }
    
    /// Name.
    var pencilName: String { get }
    
    /// Number of bytes of the whole written data.
    var pencilDataLength: Int { get }
    
    /// Identifier of data.
    var pencilIdentifier: Data { get }
    
    /// Metadata for the written data.
    var pencilHead: [Data] { get }
    
    /// Body data for the written data.
    var pencilBody: [Data] { get }

    /// The whole of written data. (Implemented default behavior.)
    var data: Data { get }
}

// Default implementations for the Writable.
public extension Writable {
    
    /// write
    @discardableResult
    public func write(to url: URL, options: Data.WritingOptions = []) -> Bool {
        do {
            try self.data.write(to: url, options: options)
            return true
        } catch {
            debugPrint("Failed to write data to file: \(error.localizedDescription)")
            return false
        }
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
