//
//  ApplicationState.swift
//  PencilExample
//
//  Created by naru on 2016/12/16.
//  Copyright © 2016年 naru. All rights reserved.
//

import Foundation

struct ApplicationState: CustomReadWriteElement {
    
    let tabIndex: Int
    
    static func read(from components: Components) -> ApplicationState? {
        return ApplicationState(
            tabIndex: components.component(for: "tabIndex", defaultValue: 0)
        )
    }
}
