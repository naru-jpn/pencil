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
            
            context("for max") {
                it("can be encode/decode") {
                    let num: Int = Int.max
                    let data: Data = num.data
                    expect(Int.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: Int = Int.min
                    let data: Data = num.data
                    expect(Int.value(from: data)).to(equal(num))
                }
            }
        }
        
        describe("Int8") {
            
            context("for positive") {
                it("can be encode/decode") {
                    let num: Int8 = 5
                    let data: Data = num.data
                    expect(Int8.value(from: data)).to(equal(num))
                }
            }
            
            context("for negative") {
                it("can be encode/decode") {
                    let num: Int8 = -5
                    let data: Data = num.data
                    expect(Int8.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: Int8 = 0
                    let data: Data = num.data
                    expect(Int8.value(from: data)).to(equal(num))
                }
            }
            
            context("for max") {
                it("can be encode/decode") {
                    let num: Int8 = Int8.max
                    let data: Data = num.data
                    expect(Int8.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: Int8 = Int8.min
                    let data: Data = num.data
                    expect(Int8.value(from: data)).to(equal(num))
                }
            }
        }
        
        describe("Int16") {
            
            context("for positive") {
                it("can be encode/decode") {
                    let num: Int16 = 5
                    let data: Data = num.data
                    expect(Int16.value(from: data)).to(equal(num))
                }
            }
            
            context("for negative") {
                it("can be encode/decode") {
                    let num: Int16 = -5
                    let data: Data = num.data
                    expect(Int16.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: Int16 = 0
                    let data: Data = num.data
                    expect(Int16.value(from: data)).to(equal(num))
                }
            }
            
            context("for max") {
                it("can be encode/decode") {
                    let num: Int16 = Int16.max
                    let data: Data = num.data
                    expect(Int16.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: Int16 = Int16.min
                    let data: Data = num.data
                    expect(Int16.value(from: data)).to(equal(num))
                }
            }
        }

        describe("Int32") {
            
            context("for positive") {
                it("can be encode/decode") {
                    let num: Int32 = 5
                    let data: Data = num.data
                    expect(Int32.value(from: data)).to(equal(num))
                }
            }
            
            context("for negative") {
                it("can be encode/decode") {
                    let num: Int32 = -5
                    let data: Data = num.data
                    expect(Int32.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: Int32 = 0
                    let data: Data = num.data
                    expect(Int32.value(from: data)).to(equal(num))
                }
            }
            
            context("for max") {
                it("can be encode/decode") {
                    let num: Int32 = Int32.max
                    let data: Data = num.data
                    expect(Int32.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: Int32 = Int32.min
                    let data: Data = num.data
                    expect(Int32.value(from: data)).to(equal(num))
                }
            }
        }
        
        describe("Int64") {
            
            context("for positive") {
                it("can be encode/decode") {
                    let num: Int64 = 5
                    let data: Data = num.data
                    expect(Int64.value(from: data)).to(equal(num))
                }
            }
            
            context("for negative") {
                it("can be encode/decode") {
                    let num: Int64 = -5
                    let data: Data = num.data
                    expect(Int64.value(from: data)).to(equal(num))
                }
            }
            
            context("for zero") {
                it("can be encode/decode") {
                    let num: Int64 = 0
                    let data: Data = num.data
                    expect(Int64.value(from: data)).to(equal(num))
                }
            }
            
            context("for max") {
                it("can be encode/decode") {
                    let num: Int64 = Int64.max
                    let data: Data = num.data
                    expect(Int64.value(from: data)).to(equal(num))
                }
            }
            
            context("for min") {
                it("can be encode/decode") {
                    let num: Int64 = Int64.min
                    let data: Data = num.data
                    expect(Int64.value(from: data)).to(equal(num))
                }
            }
        }
    }
}
