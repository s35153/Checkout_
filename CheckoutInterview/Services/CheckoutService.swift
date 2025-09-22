//
//  CheckoutService.swift
//  CheckoutInterview
//

import Foundation
import Combine

protocol CheckoutServiceProtocol {
    func fetchOrder(completion: @escaping (Result<CheckoutModel, Error>) -> Void)
    func submitOrder(orderId: String, completion: @escaping (Result<SubmissionResponse, Error>) -> Void)
}

class CheckoutService: CheckoutServiceProtocol {
    private let session = FakeNetworkSession()
    
    func fetchOrder(completion: @escaping (Result<CheckoutModel, Error>) -> Void) {
        session.getOrder { data in
            print(String(data: data, encoding: .utf8)!)
            do {
               let orderResponse = try JSONDecoder().decode(CheckoutModel.self, from: data)
                completion(.success(orderResponse))
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    func submitOrder(orderId: String, completion: @escaping (Result<SubmissionResponse, Error>) -> Void) {
        session.submitOrder(orderId: orderId) { data in
            print(String(data: data, encoding: .utf8)!)
            do {
                let submissionResponse = try JSONDecoder().decode(SubmissionResponse.self, from: data)
                completion(.success(submissionResponse))
            } catch {
                print("Error decoding submission response: \(error)")
                completion(.failure(error))
            }
        }
    }
}
