//
//  BoolSpec.swift
//  Pencil
//
//  Created by naru on 2017/01/16.
//  Copyright © 2017年 naru. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Pencil

class BoolSpec: QuickSpec {
    
    override func spec() {
        
        describe("Bool") {
            
            context("for true") {
                it("can be encode/decode") {
                    let value: Bool = true
                    let data: Data = value.data
                    expect(Bool.value(from: data)).to(equal(value))
                }
            }
            
            context("for false") {
                it("can be encode/decode") {
                    let value: Bool = false
                    let data: Data = value.data
                    expect(Bool.value(from: data)).to(equal(value))
                }
            }
        }
    }
}


