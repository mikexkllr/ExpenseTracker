//
//  DateExtension.swift
//  Expense Tracker
//
//  Created by Mike Keller on 01.12.22.
//

import Foundation

extension Date {
    func formatted() -> String {
        // weird american timeformat is needed because of api data. Maybe i host a json file on a server and use iso norm to doisplay european/ german standard too
        return self.formatted(.dateTime.year().month().day())
    }
}
