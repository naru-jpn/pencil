//
//  EnumSpec.swift
//  Pencil
//
//  Created by naru on 2016/12/14.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Pencil

class EnumSpec: QuickSpec {
    
    override func spec() {
        
        describe("Enum") {
            
            context("with Int rawValue") {
                
                enum EnumInt: Int, ReadWriteElement {
                    case value1 = 1
                    case value2 = 2
                }
                
                it("can be encode/decode") {
                    let value: EnumInt = .value1
                    let data: Data = value.data
                    expect(EnumInt.value(from: data)).to(equal(value))
                }
            }
         
            context("with String rawValue") {
                
                enum EnumString: String, ReadWriteElement {
                    case value1 = "value1"
                    case value2 = "value2"
                }
                
                it("can be encode/decode") {
                    let value: EnumString = .value1
                    let data: Data = value.data
                    expect(EnumString.value(from: data)).to(equal(value))
                }
            }
        }
    }
}
