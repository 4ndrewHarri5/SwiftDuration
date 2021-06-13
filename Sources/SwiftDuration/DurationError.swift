//
//  DurationError.swift
//  
//
//  Created by Andrew Harris on 20/05/2021.
//

import Foundation

enum DurationError: Error, Equatable {
    case unableToParse(content: String, wrongValue: String)
    case noMatch(content: String)
    case notANumber(content: String)
}
