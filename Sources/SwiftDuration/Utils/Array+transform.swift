//
//  File.swift
//  
//
//  Created by Andrew Harris on 13/06/2021.
//

import Foundation

extension Array {
    internal func transform<T>(transformation: (Array) -> T) -> T {
        transformation(self)
    }
}
