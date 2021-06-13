//
//  File.swift
//  
//
//  Created by Andrew Harris on 13/06/2021.
//

import XCTest

@testable import SwiftDuration

class ReadableJoinTests: XCTestCase {
    
    func testGivenArrayOf0ValueReturnEmptyString() throws {
        let arr: Array<String> = []
        let result = arr.readableJoin()
        
        XCTAssertEqual(result, "")
    }
    
    func testGivenArrayOf1ValueReturnValue() throws {
        let arr = ["item"]
        let result = arr.readableJoin()
        
        XCTAssertEqual(result, "item")
    }
    
    func testGivenArrayOf2ValuesReturnValueWithAnd() throws {
        let arr = ["item", "another item"]
        let result = arr.readableJoin()
        
        XCTAssertEqual(result, "item and another item")
    }
    
    func testGivenArrayOf3ValuesReturnValueWithCommaAnd() throws {
        let arr = ["item one", "item two", "item three"]
        let result = arr.readableJoin()
        
        XCTAssertEqual(result, "item one, item two and item three")
    }
    
    func testGivenArrayOf4ValuesReturnValueWithCommaAnd() throws {
        let arr = ["item one", "item two", "item three", "item four"]
        let result = arr.readableJoin()
        
        XCTAssertEqual(result, "item one, item two, item three and item four")
    }
    
}
