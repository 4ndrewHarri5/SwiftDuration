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
    public func stringify(format: Duration.DurationFormatType = .long, joiner: Duration.DurationJoiner = .default) -> String {
        Duration().stringify(Int(self), format: format, joiner: joiner)
    }
}

extension Int {
    public func stringify(format: Duration.DurationFormatType = .long, joiner: Duration.DurationJoiner = .default) -> String {
        Duration().stringify(self, format: format, joiner: joiner)
    }
}
