//
//  NSData+Split.swift
//  Writer
//
//  Created by naru on 2016/09/12.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

internal extension NSData {
    
    typealias SplitData = (former: NSData, latter: NSData)
    
    func split(length length: Int) -> SplitData {
        let former: NSData = self.subdataWithRange(NSMakeRange(0, length))
        let latter: NSData = self.subdataWithRange(NSMakeRange(length, self.length - length))
        return (former: former, latter: latter)
    }
    
    func splitIntoSubdata(lengths lengths: [Int]) -> [NSData] {
        
        let data: NSData = NSData(data: self)
        var result: [NSData] = [NSData]()
        
        var position: Int = 0
        for length in lengths {
            let range: NSRange = NSMakeRange(position, length)
            result.append(data.subdataWithRange(range))
            position = position + length
        }
        return result
    }
    
    func splited(to lengths: [Int]) -> [NSData] {
    
        let indexies: [Int] = lengths.enumerate().map { i, _ in
            switch i {
            case 0:
                return 0
            default:
                return(0...(i-1)).map{ lengths[$0] }.reduce(0) {
                    $0 + $1
                }
            }
        }
        return indexies.enumerate().map { i, element in
            return self.subdata(from: element, with: lengths[i])
        }
    }
    
    func splited(with length: Int, repeated count: Int) -> [NSData] {
        return (0..<count).map { (i: Int) -> NSData in
            self.subdata(from: length*i, with: length)
        }
    }
    
    func subdata(from start: Int, with length: Int) -> NSData {
        return self.subdataWithRange(NSMakeRange(start, length))
    }
}
