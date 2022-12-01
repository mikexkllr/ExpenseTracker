//
//  TransactionListViewModel.swift
//  Expense Tracker
//
//  Created by Mike Keller on 26.11.22.
//

import Foundation
import Combine
import Collections

// create typealias to use dictionary with these types as a new type
typealias TransactionGroup = OrderedDictionary<String, [Transaction]>

// use this typealias to display data in the chart
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []

    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        getTransaction()
    }
    
    func getTransaction() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            fatalError("invalid url")
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                case .finished:
                    print("everything is fine with the API Call")
                }
            } receiveValue: { [weak self] transactions in
                self?.transactions = transactions
                // check data in console
                dump(transactions)
            }
            .store(in: &cancellabels)
    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else {
            return [:]
        }
        
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month! }
        
        return groupedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        print("run accumulateTransactions")
        guard !transactions.isEmpty else {
            return []
        }
        
        // data from api is not up to date so we cant use Date() and need to use weird USA time format instead of german
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today!)!
        print("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        // loop over every date in interval to build tuple (60 * 60 * 24)
        for date in stride(from: dateInterval.start, to: today!, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "daily total: ", dailyTotal, "sum: ", sum)
        }
        
        return cumulativeSum
    }
}
