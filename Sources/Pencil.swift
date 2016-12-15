//
//  Vendor.swift
//  PencilExample
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

public protocol ReadWrite: Writable, Readable { }

open class Pencil {

    open class func read<T: ReadWriteElement>(_ data: Data) -> T? {
        guard let components: Components = T.devide(data: data) else {
            return nil
        }
        return T.read(from: components)
    }
    
    open class func read<T: ReadWriteElement>(_ data: Data) -> [T]? {
        guard let array: [Data] = [T].devide(data: data) else {
            return nil
        }
        return [T].read(array)
    }
    
    open class func read<T: ReadWriteElement>(_ data: Data) -> [String: T]? {
        guard let dictionary: [String: Data] = [String: T].devide(data: data) else {
            return nil
        }
        return [String: T].read(dictionary)
    }

    open class func read<T: CustomReadWriteElement>(_ data: Data) -> T? {
        guard let components: Components = T.devide(data: data) else {
            return nil
        }
        return T.read(from: components)
    }
    
    open class func read<T: CustomReadWriteElement>(_ data: Data) -> [T]? {
        guard let array: [Data] = [T].devide(data: data) else {
            return nil
        }
        return [T].read(array)
    }
    
    open class func read<T: CustomReadWriteElement>(_ data: Data) -> [String: T]? {
        guard let dictionary: [String: Data] = [String: T].devide(data: data) else {
            return nil
        }
        return [String: T].read(dictionary)
    }
    
    open class func read<T: RawRepresentable>(_ data: Data) -> T? where T.RawValue: ReadWriteElement {
        guard let components: Components = T.RawValue.devide(data: data) else {
            return nil
        }
        return T.read(from: components)
    }

}
