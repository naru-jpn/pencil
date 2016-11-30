//
//  Operators.swift
//  PencilExample
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

precedencegroup CurringPrecedence {
    associativity: left
}

precedencegroup CurringDefaultAdoptivePrecedence {
    associativity: left
    higherThan: CurringPrecedence
}

precedencegroup CurringAdoptivePrecedence {
    associativity: left
    higherThan: CurringDefaultAdoptivePrecedence
}

infix operator =<>: CurringPrecedence

infix operator -<>: CurringPrecedence

infix operator <<>: CurringAdoptivePrecedence

infix operator ?<>: CurringDefaultAdoptivePrecedence

// MARK: =<> / Currying & Apply

public func =<><T1, R>(f: (T1) -> R, value: T1) -> R {
    return f(value)
}

public func =<><T1, T2, R>(f: @escaping (T1, T2) -> R, value: T1) -> (T2) -> R {
    return { t1 in { t2 in f(t1, t2) } }(value)
}

public func =<><T1, T2, T3, R>(f: @escaping (T1, T2, T3) -> R, value: T1) -> (T2) -> (T3) -> R {
    return { t1 in { t2 in { t3 in f(t1, t2, t3) } } }(value)
}

public func =<><T1, T2, T3, T4, R>(f: @escaping (T1, T2, T3, T4) -> R, value: T1) -> (T2) -> (T3) -> (T4) -> R {
    return { t1 in { t2 in { t3 in { t4 in f(t1, t2, t3, t4) } } } }(value)
}

// MARK: -<> / Apply

public func -<> <T1, R>(f: (T1) -> R, value: T1) -> R {
    return f(value)
}

public func -<> <T1, T2, R>(f: (T1) -> (T2) -> R, value: T1) -> (T2) -> R {
    return f(value)
}

public func -<> <T1, T2, T3, R>(f: (T1) -> (T2) -> (T3) -> R, value: T1) -> (T2) -> (T3) -> R {
    return f(value)
}

// MARK: <<> / Read Data with Key String

public func <<> <T: ReadWriteElement>(components: Components, name: String) throws -> T {
    return try components.component(for: name)
}

public func <<> <T: ReadWriteElement>(components: Components, name: String) -> T? {
    return components.component(for: name)
}

public func <<> <T: ReadWriteElement>(components: Components, name: String) throws -> [T] {
    return try components.component(for: name)
}

public func <<> <T: ReadWriteElement>(components: Components, name: String) -> [T]? {
    return components.component(for: name)
}

public func <<> <T: ReadWriteElement>(components: Components, name: String) throws -> [String: T] {
    return try components.component(for: name)
}

public func <<> <T: ReadWriteElement>(components: Components, name: String) -> [String: T]? {
    return components.component(for: name)
}

public func <<> <T: CustomReadWriteElement>(components: Components, name: String) throws -> T {
    return try components.component(for: name)
}

public func <<> <T: CustomReadWriteElement>(components: Components, name: String) -> T? {
    return components.component(for: name)
}

public func <<> <T: CustomReadWriteElement>(components: Components, name: String) throws -> [T] {
    return try components.component(for: name)
}

public func <<> <T: CustomReadWriteElement>(components: Components, name: String) -> [T]? {
    return components.component(for: name)
}

public func <<> <T: CustomReadWriteElement>(components: Components, name: String) throws -> [String: T] {
    return try components.component(for: name)
}

public func <<> <T: CustomReadWriteElement>(components: Components, name: String) -> [String: T]? {
    return components.component(for: name)
}

// MARK: ?<> / Default Value

public func ?<> <T: ReadWriteElement>(lhs: T?, rhs: T) -> T {
    guard let lhs = lhs else {
        return rhs
    }
    return lhs
}

public func ?<> <T: ReadWriteElement>(lhs: [T]?, rhs: [T]) -> [T] {
    guard let lhs = lhs else {
        return rhs
    }
    return lhs
}

public func ?<> <T: ReadWriteElement>(lhs: [String: T]?, rhs: [String: T]) -> [String: T] {
    guard let lhs = lhs else {
        return rhs
    }
    return lhs
}

public func ?<> <T: CustomReadWriteElement>(lhs: T?, rhs: T) -> T {
    guard let lhs = lhs else {
        return rhs
    }
    return lhs
}
