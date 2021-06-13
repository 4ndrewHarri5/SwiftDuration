import XCTest

@testable import SwiftDuration

class DurationTests: XCTestCase {
    
    // MARK:- parse(string:)
    
    func testWhenGivenOneValueUnitInSecondsThenReturnValue() throws {
        let content = "10 seconds"
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, 10)
    }
    
    func testWhenGivenTwoValueUnitInSecondsThenReturnTwoTimesValue() throws {
        let content = "10 seconds 10 seconds"
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, 20)
    }
    
    func testWhenGivenTwoValueUnitInSecondsWithSeperatingWordReturnTwoTimesValue() throws {
        let content = "10 seconds and 10 seconds"
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, 20)
    }
    
    // MARK: Tests for each unit
    
    func testWhenGivenOneUnitMinuteReturnsCorrect() throws {
        let content = "10 minutes"
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, 600)
    }
    
    func testWhenGivenTwoUnitMinuteReturnsCorrect() throws {
        let content = "10 minutes 5 minute"
        let expected: Double = (10*60)+(5*60)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    
    // MARK: hour
    func testWhenGivenOneUnitHourReturnsCorrect() throws {
        let content = "2 hours"
        let expected: Double = (2*3600)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    func testWhenGivenTwoUnitHourReturnsCorrect() throws {
        let content = "2 hours and 1 hour"
        let expected: Double = (2*3600) + (3600)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    // MARK: day
    func testWhenGivenOneUnitDayReturnsCorrect() throws {
        let content = "1 day"
        let expected: Double = (1*86400)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    func testWhenGivenTwoUnitDayReturnsCorrect() throws {
        let content = "2 days + 10 days"
        let expected: Double = (2*86400) + (10*86400)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    // MARK: week
    func testWhenGivenOneUnitWeekReturnsCorrect() throws {
        let content = "1 week"
        let expected: Double = (1*604800)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    func testWhenGivenTwoUnitWeekReturnsCorrect() throws {
        let content = "9 weeks and 2 weeks"
        let expected: Double = (9*604800) + (2*604800)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    // MARK: month
    func testWhenGivenOneUnitMonthReturnsCorrect() throws {
        let content = "2 months"
        let expected: Double = (2*2628000)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    func testWhenGivenTwoUnitMonthReturnsCorrect() throws {
        let content = "1 month and 3 months"
        let expected: Double = (1*2628000) + (3*2628000)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    // MARK: year
    func testWhenGivenOneUnitYearReturnsCorrect() throws {
        let content = "1 year"
        let expected: Double = (1*31536000)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    func testWhenGivenTwoUnitYearReturnsCorrect() throws {
        let content = "2 years and 1 year"
        let expected: Double = (2*31536000) + (1*31536000)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }

    //TODO:
    // - all patterns for each unit
    
    
    // MARK: mixing units
    
    func testWhenGivenTwoValuesOfDifferentUnitsReturnCorrect() throws {
        let content = "2 years and 1 day"
        let expected: Double = (2*31536000) + (1*86400)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    func testWhenGivenThreeValuesOfDifferentUnitsReturnCorrect() throws {
        let content = "10 days, 6 minutes and 5 seconds"
        let expected: Double = (10*86400) + (6*60) + (5)
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, expected)
    }
    
    // MARK: Test all valid filler words
    
    func testAndDoesNotCauseError() throws {
        
        let content = "10s and 8s"
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, 18)
        
    }
    
    func testPlusDoesNotCauseError() throws {
        
        let content = "10s plus 8s"
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, 18)
        
    }
    
    func testWithDoesNotCauseError() throws {
        
        let content = "10s with 8s"
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, 18)
        
    }
    
    // MARK: Compact
    
    func testCompactStringReturnsSuccessfully() throws {
        let content = "5hr10m8s"
        
        let result = try Duration().parse(string: content)
        
        XCTAssertEqual(result, 18608)
    }
    
    // MARK: Errors
    
    func testWordWhichIsNotInPatternAfterNumberReturnsError() throws {
        let content = "2 seconds and 5 and"
        
        assert(try Duration().parse(string: content), throws: DurationError.unableToParse(content: content, wrongValue: ""))
    }
    
    func testInvalidUnitReturnsError() throws {
        let content = "2 seconds and 5 decades"
        
        assert(try Duration().parse(string: content), throws: DurationError.unableToParse(content: content, wrongValue: "decades"))
    }
    
    func testManyInvalidUnits() throws {
        let content = "2 seconds and 5 burgers and 2 sausage and 8 cheese"
        
        assert(try Duration().parse(string: content), throws: DurationError.unableToParse(content: content, wrongValue: "burgers"))
    }
    
    func testManyInvalidWordsAfterEachOther() throws {
        let content = "2 seconds and 5 burgers sausage cheese"
        
        assert(try Duration().parse(string: content), throws: DurationError.unableToParse(content: content, wrongValue: "burgers"))
    }
    
    // MARK:- stringify(seconds:)
    
    func test60SecondsIs1Minute() {
        
        let seconds = 60
        let result = Duration().stringify(seconds: seconds, format: .long)
        
        XCTAssertEqual(result, "1 minute")
        
    }
    
    func test53SecondsIs53Seconds() {
        
        let seconds = 53
        let result = Duration().stringify(seconds: seconds, format: .long)
        
        XCTAssertEqual(result, "53 seconds")
        
    }
    
    func test1Minute23SecondsIs1Minute23Seconds() {
        
        let seconds = 60+23
        let result = Duration().stringify(seconds: seconds, format: .long)
        
        XCTAssertEqual(result, "1 minute 23 seconds")
        
    }
    
    //MARK: Format
    
    func testFormatLongReturnsLongUnits() {
        let seconds = (1*86400) + (1*3600) + (1*60) + (1)
        let result = Duration().stringify(seconds: seconds, format: .long)
        XCTAssertEqual(result, "1 day 1 hour 1 minute 1 second")
    }
    
    func testFormatShortReturnsShortUnits() {
        let seconds = (1*86400) + (1*3600) + (1*60) + (1)
        let result = Duration().stringify(seconds: seconds, format: .short)
        XCTAssertEqual(result, "1 day 1 hr 1 min 1 sec")
    }
    
    func testFormatMicroReturnsMicroUnits() {
        let seconds = (1*86400) + (1*3600) + (1*60) + (1)
        let result = Duration().stringify(seconds: seconds, format: .micro)
        XCTAssertEqual(result, "1d 1h 1m 1s")
    }
    
    func testFormatCronoReturnsCronoUnits() {
        let seconds = (1*86400) + (1*3600) + (1*60) + (1)
        let result = Duration().stringify(seconds: seconds, format: .crono)
        XCTAssertEqual(result, "1:1:1:1:")
    }
    
    //MARK: Joiner
    
    func testDefaultJoinerReturnsSpaces() {
        let seconds = (1*86400) + (1*3600) + (1*60) + (1)
        let result = Duration().stringify(seconds: seconds)
        XCTAssertEqual(result, "1 day 1 hour 1 minute 1 second")
    }
    
    func testPrettyJoinerReturnsCommaAnd() {
        let seconds = (1*86400) + (1*3600) + (1*60) + (1)
        let result = Duration().stringify(seconds: seconds, joiner: .pretty)
        XCTAssertEqual(result, "1 day, 1 hour, 1 minute, and 1 second")
    }
    
    func testPrettyJoinerReturnsCommaAndWithTwo() {
        let seconds = (1*86400) + (1*3600)
        let result = Duration().stringify(seconds: seconds, joiner: .pretty)
        XCTAssertEqual(result, "1 day and 1 hour")
    }
    
    func testPrettyJoinerReturnsResultWithNoJoinWhenJustOneUnit() {
        let seconds = (1*86400)
        let result = Duration().stringify(seconds: seconds, joiner: .pretty)
        XCTAssertEqual(result, "1 day")
    }
    
}
