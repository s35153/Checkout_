//
//  OrderStatusViewController.swift
//  CheckoutInterview
//
//  Created by Sheetal Jha on 20/09/25.
//

import UIKit

class OrderStatusViewController: UIViewController {
    
    private let submissionResponse: SubmissionResponse
    
    private let orderStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 8
        configuration.baseForegroundColor = UIColor.black
        configuration.title = "Done"
        
        let button = UIButton(
            configuration: configuration,
            primaryAction: UIAction { [weak self] _ in
                self?.dismissStatusView()
            }
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(submissionResponse: SubmissionResponse) {
        self.submissionResponse = submissionResponse
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureContent()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(orderStatusLabel)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            // Status label
            orderStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderStatusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            
            // Done button
            doneButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func configureContent() {
        orderStatusLabel.text = submissionResponse.statusMessage
    }
    
    private func dismissStatusView() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}

