//
//  NSData+Split.swift
//  Writer
//
//  Created by naru on 2016/09/12.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

internal extension Data {
    
    func splited(to lengths: [Int]) -> [Data] {
    
        let indexies: [Int] = lengths.enumerated().map { i, _ in
            switch i {
            case 0:
                return 0
            default:
                return(0...(i-1)).map{ lengths[$0] }.reduce(0) {
                    $0 + $1
                }
            }
        }
        return indexies.enumerated().map { i, element in
            return self.subdata(from: element, with: lengths[i])
        }
    }
    
    func splited(with length: Int, repeated count: Int) -> [Data] {
        return (0..<count).map { (i: Int) -> Data in
            self.subdata(from: length*i, with: length)
        }
    }
    
    func subdata(from start: Int, with length: Int) -> Data {
        return self.subdata(in: start..<(start+length))
    }
}
