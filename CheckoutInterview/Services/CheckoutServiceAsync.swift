//
//  CheckoutServiceAsync.swift
//  CheckoutInterview
//

import Foundation

class CheckoutServiceAsync {
    private let session = FakeNetworkSession()
    
    func fetchOrder() async {
        let data = await session.getOrder()
        print(String(data: data, encoding: .utf8)!)
    }
    
    func submitOrder(orderId: String) async {
        let data = await session.submitOrder(orderId: orderId)
        print(String(data: data, encoding: .utf8)!)
    }
}
