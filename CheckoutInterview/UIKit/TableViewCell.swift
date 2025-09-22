//
//  TableViewCell.swift
//  CheckoutInterview
//
//  Created by Sheetal Jha on 20/09/25.
//

import UIKit

class CheckoutItemTableViewCell: UITableViewCell {

    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemPriceLabel)
        
        NSLayoutConstraint.activate([
            itemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            itemPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemPriceLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 8),
            itemPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            itemPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with item: OrderItem) {
        itemNameLabel.text = item.name
        itemPriceLabel.text = item.formattedPrice
    }
}
