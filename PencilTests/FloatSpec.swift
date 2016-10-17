//
//  FloatSpec.swift
//  Pencil
//
//  Created by naru on 2016/10/17.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Pencil

class FloatSpec: QuickSpec {
    
    override func spec() {
        
        describe("Float") {
            
            context("for positive") {
                it("can be encode/decode") {
                    let num: Float = 5.0
                    let data: Data = num.data
                    expect(Float.value(from: data)).to(equal(num))
                }
            }
            
            context("for negative") {
                it("can be encode/decode") {
                    let num: Float = -5.0
                    let data: Data = num.data
                    expect(Float.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: Float = 0.0
                    let data: Data = num.data
                    expect(Float.value(from: data)).to(equal(num))
                }
            }
            
            context("for greatest finite number") {
                it("can be encode/decode") {
                    let num: Float = Float.greatestFiniteMagnitude
                    let data: Data = num.data
                    expect(Float.value(from: data)).to(equal(num))
                }
            }
            
            context("for least positive number") {
                it("can be encode/decode") {
                    let num: Float = Float.leastNonzeroMagnitude
                    let data: Data = num.data
                    expect(Float.value(from: data)).to(equal(num))
                }
            }
        }
    }
}
