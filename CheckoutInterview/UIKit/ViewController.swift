//
//  ViewController.swift
//  CheckoutInterview
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = CheckoutViewModel()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    private lazy var submitButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 8
        configuration.baseForegroundColor = UIColor.black
        configuration.title = "Submit"

        let button = UIButton(
            configuration: configuration,
            primaryAction: UIAction { [weak self] _ in
                self?.viewModel.submitOrder()
            }
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
        viewModel.fetchOrder()
    }

    // MARK: - UI Setup
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Checkout"
        
        setupSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(submitButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CheckoutItemTableViewCell.self,
                           forCellReuseIdentifier: "CheckoutItemTableViewCell")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Table view
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -16),
            
            // Submit button
            submitButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }

    // MARK: - ViewModel
    private func configureViewModel() {
        viewModel.delegate = self
    }
    
    private func showOrderStatus(response: SubmissionResponse) {
        let statusViewController = OrderStatusViewController(submissionResponse: response)
        statusViewController.modalPresentationStyle = .fullScreen
        present(statusViewController, animated: true)
//        navigationController?.pushViewController(statusViewController, animated: true)
    }
}

// MARK: - CheckoutViewModelDelegate
extension ViewController: CheckoutViewModelDelegate {
    func didFetchOrderSuccessfully() {
        tableView.reloadData()
    }
    
    func didSubmitOrderSuccessfully(response: SubmissionResponse) {
        showOrderStatus(response: response)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutItemTableViewCell", for: indexPath) as? CheckoutItemTableViewCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.orderItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}
