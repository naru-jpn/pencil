//
//  UInt32+Data.swift
//  PencilExample
//
//  Created by naru on 2016/11/06.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

internal extension UInt32 {
    
    init(data: Data) {
        var value: UInt32 = 0
        (data as NSData).getBytes(&value, length: MemoryLayout<UInt32>.size)
        self = value
    }
}
