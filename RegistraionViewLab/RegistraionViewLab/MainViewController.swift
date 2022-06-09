//
//  MainController.swift
//  RegistraionViewLab
//
//  Created by 김도연 on 2022/06/08.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    // MARK: View
    
    private lazy var registerStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [userTextField, passwordTextField, passwordAgainTextField, registerButton])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 20
        return stackview
    }()
    
    private let userTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력하세요"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력하세요"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let passwordAgainTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 다시 입력하세요"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.isEnabled = false
        
        return button
    }()
    
    // MARK: - Binding Property
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        bind(to: viewModel)
    }
    
    private func setView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setLayout() {
        view.addSubview(registerStackView)
        NSLayoutConstraint.activate([
            registerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func bind(to viewModel: MainViewModel) {
        let input = MainViewModel.Input(
            userName: userTextField.textPublisher.eraseToAnyPublisher(),
            password: passwordTextField.textPublisher.eraseToAnyPublisher(),
            passwordAgaing: passwordAgainTextField.textPublisher.eraseToAnyPublisher()
        )
        
        let output = viewModel.transform(input: input)

        output
            .buttonIsValid
            .sink(receiveValue: { [weak self] state in
                self?.registerButton.isEnabled = state
                self?.registerButton.backgroundColor = state ? .systemOrange : .systemGray
            })
            .store(in: &cancellables)
    }
}
