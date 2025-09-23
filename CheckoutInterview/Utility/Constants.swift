//
//  Constants.swift
//  CheckoutInterview
//
//  Created by Sheetal Jha on 22/09/25.
//

import Foundation

struct Constants {
    
    // MARK: - Cell Identifiers
    struct CellIdentifiers {
        static let checkoutItemTableViewCell = "CheckoutItemTableViewCell"
    }
    
    // MARK: - Button Titles
    struct ButtonTitles {
        static let submit = "Submit"
        static let submitting = "Submitting..."
        static let done = "Done"
    }
    
    // MARK: - Status Messages
    struct StatusMessages {
        static let preparingOrder = "Your order is being prepared"
        static let orderStatus = "Order status: %@"
        static let free = "Free"
    }
    
    // MARK: - Order Status Keys
    struct OrderStatus {
        static let preparingOrder = "preparing_order"
    }
}
