//
//  Enum.swift
//  Pencil
//
//  Created by naru on 2016/12/14.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

extension RawRepresentable where RawValue: ReadWriteElement {
    
    public static var sPencilName: String {
        return "\(RawValue.self)"
    }

    public var pencilName: String {
        return "\(Mirror(reflecting: self.rawValue).subjectType)"
    }
    
    public var pencilDataLength: Int {
        return self.rawValue.pencilDataLength
    }
    
    public var pencilHead: [Data] {
        return self.rawValue.pencilHead
    }
    
    public var pencilBody: [Data] {
        return self.rawValue.pencilBody
    }
        
    public static func read(from components: Components) -> Self? {
        guard let rawValue: RawValue = RawValue.read(from: components) else {
            return nil
        }
        return self.init(rawValue: rawValue)
    }
}

extension RawRepresentable where RawValue: CustomReadWriteElement {
    
    public static var sPencilName: String {
        return "\(RawValue.self)"
    }
    
    public var pencilName: String {
        return "\(Mirror(reflecting: self.rawValue).subjectType)"
    }
    
    public var pencilDataLength: Int {
        return self.rawValue.pencilDataLength
    }
    
    public var pencilHead: [Data] {
        return self.rawValue.pencilHead
    }
    
    public var pencilBody: [Data] {
        return self.rawValue.pencilBody
    }
    
    public static func read(from components: Components) -> Self? {
        guard let rawValue: RawValue = RawValue.read(from: components) else {
            return nil
        }
        return self.init(rawValue: rawValue)
    }
}
