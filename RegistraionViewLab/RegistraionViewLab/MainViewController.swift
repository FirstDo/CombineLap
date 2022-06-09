//
//  MainController.swift
//  RegistraionViewLab
//
//  Created by 김도연 on 2022/06/08.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        addTarget()
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
    
    private func addTarget() {
        userTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        passwordAgainTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(sender: UITextField) {
        if isValid() {
            registerButton.backgroundColor = .systemOrange
            registerButton.isEnabled = true
        } else {
            registerButton.backgroundColor = .systemGray
            registerButton.isEnabled = false
        }
    }
    
    private func isValid() -> Bool {
        return
            userTextField.text!.count >= 4 &&
            passwordTextField.text!.count >= 6 &&
            passwordTextField.text == passwordAgainTextField.text
    }
}
