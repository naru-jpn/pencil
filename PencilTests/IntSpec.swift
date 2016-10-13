//
//  IntSpec.swift
//  Pencil
//
//  Created by naru on 2016/10/13.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Pencil

class IntSpec: QuickSpec {

    override func spec() {
        
        describe("Int") {
            
            context("for positive") {
                it("can be encode/decode") {
                    let num: Int = 5
                    let data: Data = num.data
                    expect(Int.value(from: data)).to(equal(num))
                }
            }
            
            context("for negative") {
                it("can be encode/decode") {
                    let num: Int = -5
                    let data: Data = num.data
                    expect(Int.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: Int = 0
                    let data: Data = num.data
                    expect(Int.value(from: data)).to(equal(num))
                }
            }
        }
        
    }
}
