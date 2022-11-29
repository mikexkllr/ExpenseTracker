//
//  DateFormatter.swift
//  Expense Tracker
//
//  Created by Mike Keller on 26.11.22.
//

import Foundation

extension DateFormatter {
    static let allNumericEurope: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String {
    func dateParsed() -> Date? {
        guard let parsedDate: Date = DateFormatter.allNumericEurope.date(from: self) else {
            return nil
        }
        
        return parsedDate
    }
}
