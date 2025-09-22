//
//  ContentServiceCombine.swift
//  CheckoutInterview
//

import Combine
import Foundation

class CheckoutServiceCombine {
    private let session = FakeNetworkSession()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchOrder() {
        session
            .getOrderPublisher
            .sink(
                receiveCompletion: { _ in
                },
                receiveValue: { data in
                    print(String(data: data, encoding: .utf8)!)
                }
            )
            .store(in: &cancellables)
    }
    
    func submitOrder(orderId: String) {
        session
            .submitOrderPublisher
            .sink(
                receiveCompletion: { _ in
                },
                receiveValue: { data in
                    print(String(data: data, encoding: .utf8)!)
                }
            )
            .store(in: &cancellables)
    }
}
