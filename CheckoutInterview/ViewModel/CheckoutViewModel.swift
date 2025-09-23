//
//  CheckoutViewModel.swift
//  CheckoutInterview
//
//  Created by Sheetal Jha on 20/09/25.
//

import UIKit

protocol CheckoutViewModelDelegate: AnyObject {
    func didFetchOrderSuccessfully()
    func didStartSubmittingOrder()
    func didSubmitOrderSuccessfully(response: SubmissionResponse)
    func didFailToSubmitOrder(error: Error)
}

class CheckoutViewModel {
    private let checkoutService: CheckoutServiceProtocol
    weak var delegate: CheckoutViewModelDelegate?
    
    // MVVM: ViewModel holds the data
    private(set) var checkoutModel: CheckoutModel?
    
    var orderItems: [OrderItem] {
        return checkoutModel?.items ?? []
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
        guard let orderId = checkoutModel?.id else {
            print("No order ID available for submission")
            return
        }
        
        // Notify delegate that submission started
        delegate?.didStartSubmittingOrder()
        
        checkoutService.submitOrder(orderId: orderId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let submissionResponse):
                    self?.delegate?.didSubmitOrderSuccessfully(response: submissionResponse)
                case .failure(let error):
                    print("Failed to submit order: \(error.localizedDescription)")
                    self?.delegate?.didFailToSubmitOrder(error: error)
                }
            }
        }
    }
}
