//
//  DoubleSpec.swift
//  Pencil
//
//  Created by naru on 2016/10/17.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Pencil

class DoubleSpec: QuickSpec {
    
    override func spec() {
        
        describe("Double") {
            
            context("for positive") {
                it("can be encode/decode") {
                    let num: Double = 5.0
                    let data: Data = num.data
                    expect(Double.value(from: data)).to(equal(num))
                }
            }
            
            context("for negative") {
                it("can be encode/decode") {
                    let num: Double = -5.0
                    let data: Data = num.data
                    expect(Double.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: Double = 0.0
                    let data: Data = num.data
                    expect(Double.value(from: data)).to(equal(num))
                }
            }
            
            context("for greatest finite number") {
                it("can be encode/decode") {
                    let num: Double = Double.greatestFiniteMagnitude
                    let data: Data = num.data
                    expect(Double.value(from: data)).to(equal(num))
                }
            }
            
            context("for least positive number") {
                it("can be encode/decode") {
                    let num: Double = Double.leastNonzeroMagnitude
                    let data: Data = num.data
                    expect(Double.value(from: data)).to(equal(num))
                }
            }
        }
    }
}
