//
//  StringSpec.swift
//  Pencil
//
//  Created by naru on 2016/10/13.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Pencil

class StringSpec: QuickSpec {

    override func spec() {
        
        describe("String") {
            
            context("containing some characters") {
                it("can be encode/decode") {
                    let string: String = "quick sample"
                    let data: Data = string.data
                    expect(String.value(from: data)).to(equal(string))
                }
            }
            
            context("containing 0 character") {
                it("can be encode/decode") {
                    let string: String = ""
                    let data: Data = string.data
                    expect(String.value(from: data)).to(equal(string))
                }
            }
            
            context("containing emoji") {
                it("can be encode/decode") {
                    let string: String = "😉😉😉"
                    let data: Data = string.data
                    expect(String.value(from: data)).to(equal(string))
                }
            }
        }
    }
}
