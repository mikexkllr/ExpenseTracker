//
//  TransactionList.swift
//  Expense Tracker
//
//  Created by Mike Keller on 01.12.22.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(viewModel.groupTransactionsByMonth()), id: \.key) { month, transactions in
                    Section (header: Text(month)) {
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }.listSectionSeparator(.hidden)
                }
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    
    static var previews: some View {
        Group {
            NavigationView {
                TransactionList().environmentObject(transactionListVM)
            }
        }
    }
}
