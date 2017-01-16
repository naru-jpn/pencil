//
//  DateSpec.swift
//  Pencil
//
//  Created by naru on 2017/01/16.
//  Copyright © 2017年 naru. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Pencil

class DateSpec: QuickSpec {
    
    override func spec() {
        
        describe("Date") {
            
            context("for now") {
                it("can be encode/decode") {
                    let value: Date = Date()
                    let data: Data = value.data
                    expect(Date.value(from: data)).to(equal(value))
                }
            }
            
            context("at specific timestamp") {
                it("can be encode/decode") {
                    let value: Date = Date(timeIntervalSince1970: 100000)
                    let data: Data = value.data
                    expect(Date.value(from: data)).to(equal(value))
                }
            }
        }
    }
}

