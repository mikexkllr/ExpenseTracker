//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Mike Keller on 26.11.22.
//

import SwiftUI

@main
struct Expense_TrackerApp: App {
    var transactionListViewModel = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListViewModel)
        }
    }
}
