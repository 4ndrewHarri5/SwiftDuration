//
//  SwiftDuration.swift
//
//
//  Created by Andrew Harris on 22/07/2020.
//
import Foundation

internal struct DurationFormat {
    var long: String
    var short: String
    var micro: String
    var crono: String
}

internal enum DurationFormatType {
    case long, short, micro, crono
}

internal enum DurationName {
    case seconds, minutes, hours, days, weeks, months, years
}

internal struct DurationUnit {
    var name: DurationName
    var value: Double
    var patterns: [String]
    var formats: DurationFormat
}

internal enum DurationJoiner {
    case `default`, pretty
}
    
public final class Duration {
    
    private let UNITS = [
        DurationUnit(name: .seconds, value: 1, patterns: ["second", "sec", "s"], formats: .init(long: "second", short: "sec", micro: "s", crono: ":")),
        DurationUnit(name: .minutes, value: 60, patterns: ["minute", "min", "m(?!s)"], formats: .init(long: "minute", short: "min", micro: "m", crono: ":")),
        DurationUnit(name: .hours, value: 3600, patterns: ["hour", "hr", "h"], formats: .init(long: "hour", short: "hr", micro: "h", crono: ":")),
        DurationUnit(name: .days, value: 86400, patterns: ["day", "dy", "d"], formats: .init(long: "day", short: "day", micro: "d", crono: ":")),
        DurationUnit(name: .weeks, value: 604800, patterns: ["week", "wk", "w"], formats: .init(long: "week", short: "wk", micro: "w", crono: ":")),
        DurationUnit(name: .months, value: 2628000, patterns: ["month", "mon", "mo", "mth"], formats: .init(long: "month", short: "mon", micro: "mth", crono: ":")),
        DurationUnit(name: .years, value: 31536000, patterns: ["year", "yr", "y"], formats: .init(long: "year", short: "yr", micro: "y", crono: ":")),
    ]
    
    func parse(_ string: String) throws -> Double {
        var replacedString = string
        try UNITS.forEach { (unit) in
            let mLen = unit.patterns.count
            for i in (0 ..< mLen) {
                let regex = try RegEx(pattern: "((?:\\d+\\.\\d+)|\\d+)\\s?(\(unit.patterns[i])s?(?=\\s|\\d|\\b))", options: [.caseInsensitive])
                
                try regex.matches(in: replacedString).forEach { (match) in
                    guard let fullMatch = match.values[0] else {
                        throw DurationError.noMatch(content: string)
                    }
                    guard let value = match.values[1] else {
                        throw DurationError.noMatch(content: string)
                    }
                    guard let numericValue = Double(value) else {
                        throw DurationError.notANumber(content: string)
                    }
                    ///adds space for compact strings (with no spaces in them), they will be removed later
                    let unitValue = String(numericValue * unit.value) + " "
                    replacedString = replacedString.replacingOccurrences(of: fullMatch, with: unitValue)
                }
            }
        }
        
        var sum: Double = 0
        
        let numbers = replacedString
            .replacingOccurrences(of: "(?!\\.)\\W+", with: " ", options: [.regularExpression]) // replaces non-word chars (excluding '.') with whitespace
            .replacingOccurrences(of: "^\\s+|\\s+$|(?:and|plus|with)\\s?", with: "", options: [.regularExpression]) // trim L/R whitespace, replace known join words with ''
            .split(separator: " ", omittingEmptySubsequences: false)
        
        let nLen = numbers.count
        for j in (0 ..< nLen) {
            if let toNumber = Double(numbers[j]), toNumber.isFinite {
                sum += toNumber
            } else {
                throw DurationError.unableToParse(content: string, wrongValue: numbers[j].replacingOccurrences(of: "/^\\d+/g", with: ""))
            }
        }
        return sum
    }
    
    func stringify(_ seconds: Int, format: DurationFormatType = .long, joiner: DurationJoiner = .default) -> String{
        
        let (years, months, weeks, days, hours, minutes, seconds) = yearsMonthsWeeksDaysHoursMinutesSeconds(from: seconds)
        
        return UNITS.reversed().map { unit -> (Int, String) in
            var value: Int {
                switch unit.name {
                case .seconds: return seconds
                case .minutes: return minutes
                case .hours: return hours
                case .days: return days
                case .weeks: return weeks
                case .months: return months
                case .years: return years
                }
            }
            
            var suffix: String {
                let isPlural = value == 1 || value == -1
                switch format {
                case .long: return isPlural ? unit.formats.long : "\(unit.formats.long)s"
                case .short: return isPlural ? unit.formats.short : "\(unit.formats.short)s"
                case .micro: return unit.formats.micro
                case .crono: return unit.formats.crono
                }
            }
            return (value, suffix)
        }.filter { units -> Bool in
            return units.0 != 0
        }.map { units -> String in
            let (value, suffix) = units
            switch format {
            case .micro, .crono: return "\(value)\(suffix)"
            default: return "\(value) \(suffix)"
            }
        }.transform { arr in
            switch format {
            case .crono: return arr.joined(separator: "")
            default: return arr.joined(format: joiner)
            }
        }
        
    }
    
    private func yearsMonthsWeeksDaysHoursMinutesSeconds(from seconds: Int) -> (Int, Int, Int, Int, Int, Int, Int) {
        return (
            seconds / 31536000,
            (seconds % 31536000) / 2628000,
            (seconds % 2628000) / 604800,
            (seconds % 604800) / 86400,
            (seconds % 86400) / 3600,
            (seconds % 3600) / 60,
            (seconds % 3600) % 60
        )
    }
}
