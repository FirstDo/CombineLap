//
//  MainViewModel.swift
//  RegistraionViewLab
//
//  Created by 김도연 on 2022/06/09.
//

import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

final class MainViewModel: ViewModelType {
    struct Input {
        let userName: AnyPublisher<String, Never>
        let password: AnyPublisher<String, Never>
        let passwordAgaing: AnyPublisher<String, Never>
    }
    
    struct Output {
        let buttonIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(input: Input) -> Output {
        let buttonStatePublisher = input.userName.combineLatest(input.password, input.passwordAgaing)
            .map { user, password, passwordAgaing in
                user.count >= 4 &&
                password.count >= 6 &&
                password == passwordAgaing
            }
            .eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonStatePublisher)
    }
}
