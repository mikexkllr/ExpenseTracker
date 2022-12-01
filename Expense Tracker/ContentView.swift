//
//  ContentView.swift
//  Expense Tracker
//
//  Created by Mike Keller on 26.11.22.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var viewModel: TransactionListViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: App title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Chart Section
                    let data = viewModel.accumulateTransactions()
                    let totalExpenses = data.last?.1 ?? 0
                    CardView {
                        VStack {
                            ChartLabel(totalExpenses.formatted(.currency(code: "EUR")), type: .title)
                            LineChart()
                        }
                        .background(Color.systemBackground)
                    }
                    .data(data)
                    .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                    .frame(height: 300)
                    
                    
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let vm = TransactionListViewModel()
        vm.transactions = transactionListPreviewData
        return vm
    }()
    
    static var previews: some View {
        ContentView().environmentObject(transactionListVM)
    }
}
