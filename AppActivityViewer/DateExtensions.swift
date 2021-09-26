//
//  DateExtensions.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import Foundation

extension Date {
    func humanReadable() -> String {
        let dateformat = DateFormatter()
        dateformat.locale = Locale.current
        dateformat.dateStyle = .medium // Nov 23, 1937
        dateformat.timeStyle = .medium
        return dateformat.string(from: self)
    }
}

extension String {
    func parseDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.date(from: self) // "Jun 5, 2016, 4:56 PM"
    }

    func formatDate() -> String {
        if let date = parseDate() {
            return date.humanReadable()
        } else {
            return self
        }
    }
}
