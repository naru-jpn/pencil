//
//  UIntSpec.swift
//  Pencil
//
//  Created by naru on 2016/10/17.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Pencil

class UIntSpec: QuickSpec {
    
    override func spec() {
        
        describe("UInt") {
            
            context("for some value") {
                it("can be encode/decode") {
                    let num: UInt = 5
                    let data: Data = num.data
                    expect(UInt.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: UInt = 0
                    let data: Data = num.data
                    expect(UInt.value(from: data)).to(equal(num))
                }
            }
            
            context("for max") {
                it("can be encode/decode") {
                    let num: UInt = UInt.max
                    let data: Data = num.data
                    expect(UInt.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: UInt = UInt.min
                    let data: Data = num.data
                    expect(UInt.value(from: data)).to(equal(num))
                }
            }
        }
        
        describe("UInt8") {
            
            context("for some value") {
                it("can be encode/decode") {
                    let num: UInt8 = 5
                    let data: Data = num.data
                    expect(UInt8.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: UInt8 = 0
                    let data: Data = num.data
                    expect(UInt8.value(from: data)).to(equal(num))
                }
            }
            
            context("for max") {
                it("can be encode/decode") {
                    let num: UInt8 = UInt8.max
                    let data: Data = num.data
                    expect(UInt8.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: UInt8 = UInt8.min
                    let data: Data = num.data
                    expect(UInt8.value(from: data)).to(equal(num))
                }
            }
        }
        
        describe("UInt16") {
            
            context("for some value") {
                it("can be encode/decode") {
                    let num: UInt16 = 5
                    let data: Data = num.data
                    expect(UInt16.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: UInt16 = 0
                    let data: Data = num.data
                    expect(UInt16.value(from: data)).to(equal(num))
                }
            }
            
            context("for max") {
                it("can be encode/decode") {
                    let num: UInt16 = UInt16.max
                    let data: Data = num.data
                    expect(UInt16.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: UInt16 = UInt16.min
                    let data: Data = num.data
                    expect(UInt16.value(from: data)).to(equal(num))
                }
            }
        }
        
        describe("UInt32") {
            
            context("for some value") {
                it("can be encode/decode") {
                    let num: UInt32 = 5
                    let data: Data = num.data
                    expect(UInt32.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: UInt32 = 0
                    let data: Data = num.data
                    expect(UInt32.value(from: data)).to(equal(num))
                }
            }
            
            context("for max") {
                it("can be encode/decode") {
                    let num: UInt32 = UInt32.max
                    let data: Data = num.data
                    expect(UInt32.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: UInt32 = UInt32.min
                    let data: Data = num.data
                    expect(UInt32.value(from: data)).to(equal(num))
                }
            }
        }
        
        describe("UInt64") {
            
            context("for some value") {
                it("can be encode/decode") {
                    let num: UInt64 = 5
                    let data: Data = num.data
                    expect(UInt64.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: UInt64 = 0
                    let data: Data = num.data
                    expect(UInt64.value(from: data)).to(equal(num))
                }
            }
            
            context("for max") {
                it("can be encode/decode") {
                    let num: UInt64 = UInt64.max
                    let data: Data = num.data
                    expect(UInt64.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: UInt64 = UInt64.min
                    let data: Data = num.data
                    expect(UInt64.value(from: data)).to(equal(num))
                }
            }
        }
    }
}

