//
//  TransactionListViewModel.swift
//  Expense Tracker
//
//  Created by Mike Keller on 26.11.22.
//

import Foundation
import Combine

// create typealias to use dictionary with these types as a new type
typealias TransactionGroup = [String: [Transaction]]

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
    
}
