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
    func stringify(format: DurationFormatType = .long, joiner: DurationJoiner = .default) -> String {
        Duration().stringify(Int(self), format: format, joiner: joiner)
    }
}

extension Int {
    func stringify(format: DurationFormatType = .long, joiner: DurationJoiner = .default) -> String {
        Duration().stringify(self, format: format, joiner: joiner)
    }
}
