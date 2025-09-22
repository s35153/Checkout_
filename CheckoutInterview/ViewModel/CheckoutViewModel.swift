//
//  CheckoutViewModel.swift
//  CheckoutInterview
//
//  Created by Sheetal Jha on 20/09/25.
//

import UIKit

protocol CheckoutViewModelDelegate: AnyObject {
    func didFetchOrderSuccessfully()
    func didSubmitOrderSuccessfully(response: SubmissionResponse)
}

class CheckoutViewModel {
    private let checkoutService: CheckoutServiceProtocol
    weak var delegate: CheckoutViewModelDelegate?
    
    // MVVM: ViewModel holds the data
    private(set) var checkoutModel: CheckoutModel?
    
    var orderItems: [OrderItem] {
        return checkoutModel?.items ?? []
    }
    
    var orderId: String? {
        return checkoutModel?.id
    }
    
    init(checkoutService: CheckoutServiceProtocol = CheckoutService()) {
        self.checkoutService = checkoutService
    }
    
    func fetchOrder() {
        checkoutService.fetchOrder { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let checkoutModel):
                    self?.checkoutModel = checkoutModel
                    self?.delegate?.didFetchOrderSuccessfully()
                case .failure(let error):
                    print("Failed to fetch order: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func submitOrder() {
        guard let orderId = orderId else {
            print("No order ID available for submission")
            return
        }
        
        checkoutService.submitOrder(orderId: orderId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let submissionResponse):
                    self?.delegate?.didSubmitOrderSuccessfully(response: submissionResponse)
                case .failure(let error):
                    print("Failed to submit order: \(error.localizedDescription)")
                }
            }
        }
    }
}
