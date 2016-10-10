//
//  Readable.swift
//  Pencil
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

/// Protocol to convert data to value
public protocol Readable {
    
    /// Procedure to restore value from mapped dictionary.
    static var read: (Components) -> Self? { get }
}

enum ReadError: Error {
    case notFound
    case cannotRead
}

/// Component return value converted from data with key string
public struct Components {
    let dictionary: [String: Data]
}

// MARK: extension for T
extension Components {

    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String) throws -> T {
    
        guard let data: Data = self.dictionary[key] else {
            throw ReadError.notFound
        }
        
        guard let components: Components = T.devide(data: data), let value: T = T.read(components) else {
            throw ReadError.cannotRead
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String, defaultValue: T) -> T {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let components: Components = T.devide(data: data), let value: T = T.read(components)  else {
            return defaultValue
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: optional ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String) -> T? {
        
        guard let data: Data = self.dictionary[key] else {
            return nil
        }
        
        guard let components: Components = T.devide(data: data), let value: T = T.read(components)  else {
            return nil
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: optional ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String, defaultValue: T) -> T? {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let components: Components = T.devide(data: data), let value: T = T.read(components)  else {
            return defaultValue
        }
        
        return value
    }
}

// MARK: extension for [T]
extension Components {
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String) throws -> [T] {
        
        guard let data: Data = self.dictionary[key] else {
            throw ReadError.notFound
        }
        
        guard let array: [Data] = [T].devide(data: data), let value = [T].read(array) else {
            throw ReadError.cannotRead
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String, defaultValue: [T]) -> [T] {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let array: [Data] = [T].devide(data: data), let value = [T].read(array) else {
            return defaultValue
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: optional ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String) -> [T]? {
        
        guard let data: Data = self.dictionary[key] else {
            return nil
        }
        
        guard let array: [Data] = [T].devide(data: data), let value = [T].read(array) else {
            return nil
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: optional ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String, defaultValue: [T]) -> [T]? {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let array: [Data] = [T].devide(data: data), let value = [T].read(array) else {
            return defaultValue
        }
        
        return value
    }
}

// MARK: extension for [String:T]
extension Components {
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String) throws -> [String:T] {
        
        guard let data: Data = self.dictionary[key] else {
            throw ReadError.notFound
        }
        
        guard let dictionary: [String: Data] = [String:T].devide(data: data), let value = [String:T].read(dictionary) else {
            throw ReadError.cannotRead
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String, defaultValue: [String:T]) -> [String:T] {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let dictionary: [String: Data] = [String:T].devide(data: data), let value = [String:T].read(dictionary) else {
            return defaultValue
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: optional ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String) -> [String:T]? {
        
        guard let data: Data = self.dictionary[key] else {
            return nil
        }
        
        guard let dictionary: [String: Data] = [String:T].devide(data: data), let value = [String:T].read(dictionary) else {
            return nil
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: optional ReadWriteElement value
    public func component<T: ReadWriteElement>(for key: String, defaultValue: [String:T]) -> [String:T]? {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let dictionary: [String: Data] = [String:T].devide(data: data), let value = [String:T].read(dictionary) else {
            return defaultValue
        }
        
        return value
    }
}

// MARK: extension for T (custom)
extension Components {
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String) throws -> T {
        
        guard let data: Data = self.dictionary[key] else {
            throw ReadError.notFound
        }
        
        guard let components: Components = T.devide(data: data), let value: T = T.read(components) else {
            throw ReadError.cannotRead
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String, defaultValue: T) -> T {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let components: Components = T.devide(data: data), let value: T = T.read(components)  else {
            return defaultValue
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: optional CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String) -> T? {
        
        guard let data: Data = self.dictionary[key] else {
            return nil
        }
        
        guard let components: Components = T.devide(data: data), let value: T = T.read(components)  else {
            return nil
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: optional CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String, defaultValue: T) -> T? {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let components: Components = T.devide(data: data), let value: T = T.read(components)  else {
            return defaultValue
        }
        
        return value
    }
}

// MARK: extension for [T] (custom)
extension Components {
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String) throws -> [T] {
        
        guard let data: Data = self.dictionary[key] else {
            throw ReadError.notFound
        }
        
        guard let array: [Data] = [T].devide(data: data), let value = [T].read(array) else {
            throw ReadError.cannotRead
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String, defaultValue: [T]) -> [T] {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let array: [Data] = [T].devide(data: data), let value = [T].read(array) else {
            return defaultValue
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: optional CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String) -> [T]? {
        
        guard let data: Data = self.dictionary[key] else {
            return nil
        }
        
        guard let array: [Data] = [T].devide(data: data), let value = [T].read(array) else {
            return nil
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: optional CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String, defaultValue: [T]) -> [T]? {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let array: [Data] = [T].devide(data: data), let value = [T].read(array) else {
            return defaultValue
        }
        
        return value
    }
}

// MARK: extension for [String:T] (custom)
extension Components {
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String) throws -> [String:T] {
        
        guard let data: Data = self.dictionary[key] else {
            throw ReadError.notFound
        }
        
        guard let dictionary: [String: Data] = [String:T].devide(data: data), let value = [String:T].read(dictionary) else {
            throw ReadError.cannotRead
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String, defaultValue: [String:T]) -> [String:T] {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let dictionary: [String: Data] = [String:T].devide(data: data), let value = [String:T].read(dictionary) else {
            return defaultValue
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - returns: optional CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String) -> [String:T]? {
        
        guard let data: Data = self.dictionary[key] else {
            return nil
        }
        
        guard let dictionary: [String: Data] = [String:T].devide(data: data), let value = [String:T].read(dictionary) else {
            return nil
        }
        
        return value
    }
    
    /// Return value with key string
    /// - parameter for(key): key string
    /// - parameter defaultValue: returned value when no readable value
    /// - returns: optional CustomReadWriteElement value
    public func component<T: CustomReadWriteElement>(for key: String, defaultValue: [String:T]) -> [String:T]? {
        
        guard let data: Data = self.dictionary[key] else {
            return defaultValue
        }
        
        guard let dictionary: [String: Data] = [String:T].devide(data: data), let value = [String:T].read(dictionary) else {
            return defaultValue
        }
        
        return value
    }
}
