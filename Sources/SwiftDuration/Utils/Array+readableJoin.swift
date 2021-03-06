//
//  ReadableJoin.swift
//  
//
//  Created by Andrew Harris on 20/05/2021.
//

import Foundation

extension Array where Element == String {
    private mutating func remove(_ range: Range<Int>) -> Array {
        let values = Array(self[range])
        self.removeSubrange(range)
        return values
    }
    
    internal func readableJoin() -> String {
        var array = self
        if array.count >= 2 {
            let subrange = array.remove(array.count-2..<array.count)
            array.append(subrange.joined(separator: " and "))
        }
        return array.joined(separator: ", ")
    }
    
    internal func joined(format: Duration.DurationJoiner = .default) -> String {
        switch format {
        case .default: return self.joined(separator: " ")
        case .pretty: return self.readableJoin()
        }
    }
}
