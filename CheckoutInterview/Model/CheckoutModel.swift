//
//  CheckoutModel.swift
//  CheckoutInterview
//
//  Created by Sheetal Jha on 20/09/25.
//

struct CheckoutModel: Codable {
    let id: String
    let items: [OrderItem]
}

struct OrderItem: Codable {
    let name: String
    let displayPrice: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case displayPrice = "display_price"
    }
    
    // Computed property to handle null prices
    var formattedPrice: String {
        return displayPrice ?? "Free"
    }
}

struct SubmissionResponse: Codable {
    let status: String
    
    var statusMessage: String {
        switch status {
        case "preparing_order":
            return "Your order is being prepared"
        default:
            return "Order status: \(status)"
        }
    }
}
