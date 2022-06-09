//
//  ViewController.swift
//  UIControl+Combine
//
//  Created by 김도연 on 2022/06/09.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        myTextField.textPublisher.sink {
            print($0)
        }
        .store(in: &cancellables)
        
        myButton.tapPublisher.sink {
            print($0)
        }
        .store(in: &cancellables)
        
        mySwitch.statePublisher.sink {
            print($0)
        }
        .store(in: &cancellables)
        
        myStepper.valuePublisher.sink {
            print($0)
        }
        .store(in: &cancellables)
        
        mySegmentControl.selectionPublisher.sink {
            print($0)
        }
        .store(in: &cancellables)
        
        mySlider.valuePublisher.sink {
            print($0)
        }
        .store(in: &cancellables)
    }
}

