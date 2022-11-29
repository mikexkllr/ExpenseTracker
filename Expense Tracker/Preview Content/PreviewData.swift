//
//  PreviewData.swift
//  Expense Tracker
//
//  Created by Mike Keller on 26.11.22.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "26/11/2022", institution: "Mikes comapany", account: "Visa Debit Card", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
