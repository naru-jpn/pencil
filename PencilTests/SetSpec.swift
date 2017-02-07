//
//  SetSpec.swift
//  Pencil
//
//  Created by Naruki Chigira on 2017/02/07.
//  Copyright © 2017年 naru. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Pencil

class SetSpec: QuickSpec {
    
    /// Custom struct for testing `set` containing CustomReadWriteElement
    struct Custom: Hashable, CustomReadWriteElement {
        
        let value: Int
        
        static func read(from components: Components) -> Custom? {
            return Custom(value: components.component(for: "value", defaultValue: 0))
        }
        
        var hashValue: Int {
            return self.value
        }
    }
    
    override func spec() {
        
        describe("Set") {
            
            context("for int element") {
                it("can be encode/decode") {
                    let value: Set<Int> = [1, 5, -2]
                    let data: Data = value.data
                    expect(Set<Int>.value(from: data)).to(equal(value))
                }
            }
            
            context("for double element") {
                it("can be encode/decode") {
                    let value: Set<Double> = [1.0, 5.0, -2.0]
                    let data: Data = value.data
                    expect(Set<Double>.value(from: data)).to(equal(value))
                }
            }
            
            context("for custom element") {
                it("can be encode/decode") {
                    let value: Set<Custom> = [Custom(value: 1), Custom(value: 5), Custom(value: -2)]
                    let data: Data = value.data
                    expect(Set<Custom>.value(from: data)).to(equal(value))
                }
            }
        }
    }
}

internal func ==(left: SetSpec.Custom, right: SetSpec.Custom) -> Bool {
    return left.value == right.value
}
