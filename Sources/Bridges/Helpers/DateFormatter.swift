//
//  DateFormatter.swift
//  Bridges
//
//  Created by Mihael Isaev on 13.02.2020.
//

import Foundation

/// Custom DateFormatter to parse dates both with milliseconds and without, with timezone and without
/// credits to https://stackoverflow.com/questions/48371082/swift-dateformatter-optional-milliseconds
public class BridgesDateFormatter: DateFormatter {
    override public init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.calendar = Calendar(identifier: .iso8601)
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(identifier: "UTC")
        //with milliseconds and without timezone
        self.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
    }
    
    override public func date(from string: String) -> Date? {
        let string = string.replacingOccurrences(of: "T", with: " ")
        //with milliseconds and without timezone
        dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        if let result = super.date(from: string) {
            return result
        }
        //without milliseconds and without timezone
        dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let result = super.date(from: string) {
            return result
        }
        //with milliseconds and timezone
        dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZZZZZ"
        if let result = super.date(from: string) {
            return result
        }
        //without milliseconds and with timezone
        dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
        return super.date(from: string)
    }
}
