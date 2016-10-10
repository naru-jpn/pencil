//
//  Vendor.swift
//  PencilExample
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

public protocol ReadWrite: Writable, Readable { }

public class Pencil {

    public class func read<T: ReadWriteElement>(data: NSData) -> T? {
        guard let components: Components = T.devide(data: data) else {
            return nil
        }
        return T.read(components)
    }
    
    public class func read<T: ReadWriteElement>(data: NSData) -> [T]? {
        guard let array: [NSData] = [T].devide(data: data) else {
            return nil
        }
        return [T].read(array)
    }
    
    public class func read<T: ReadWriteElement>(data: NSData) -> [String: T]? {
        guard let dictionary: [String: NSData] = [String: T].devide(data: data) else {
            return nil
        }
        return [String: T].read(dictionary)
    }

    public class func read<T: CustomReadWriteElement>(data: NSData) -> T? {
        guard let components: Components = T.devide(data: data) else {
            return nil
        }
        return T.read(components)
    }
    
    public class func read<T: CustomReadWriteElement>(data: NSData) -> [T]? {
        guard let array: [NSData] = [T].devide(data: data) else {
            return nil
        }
        return [T].read(array)
    }
    
    public class func read<T: CustomReadWriteElement>(data: NSData) -> [String: T]? {
        guard let dictionary: [String: NSData] = [String: T].devide(data: data) else {
            return nil
        }
        return [String: T].read(dictionary)
    }
}
