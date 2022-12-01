//
//  RecentTransactionList.swift
//  Expense Tracker
//
//  Created by Mike Keller on 29.11.22.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    var body: some View {
        VStack {
            HStack {
                // MARK: Header Title
                Text("Recent Transaction")
                    .bold()
                
                Spacer()
                
                // MARK: Header Link
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            let prefixAmount = 5
            //MARK: Recent Transaction List
            ForEach(Array(viewModel.transactions.prefix(prefixAmount).enumerated()), id: \.element) { index, transaction in
                TransactionRow(transaction: transaction)
                Divider()
                    .opacity(index == viewModel.transactions.prefix(prefixAmount).count - 1 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    
    static var previews: some View {
        RecentTransactionList().environmentObject(transactionListVM)
    }
}
