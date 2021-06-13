//
//  File.swift
//  
//
//  Created by Andrew Harris on 13/06/2021.
//

import Foundation

extension String {
    public func parse() throws -> Double {
        try Duration().parse(self)
    }
}

extension Double {
    public func stringify() -> String {
        Duration().stringify(Int(self))
    }
}

extension Int {
    public func stringify() -> String {
        Duration().stringify(self)
    }
}
