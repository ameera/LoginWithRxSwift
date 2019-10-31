//
//  RxLoginViewController.swift
//  LoginWithRxSwift
//
//  Created by Ameera Damsika on 9/3/19.
//  Copyright © 2019 Ameera Damsika. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class RxLoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    var disposeBag = DisposeBag()
    var loginViewModel = RxLoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
         emailText.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.emailText).disposed(by: disposeBag)
        passwordText.rx.text.map {$0 ?? ""}.bind(to: loginViewModel.passwordText).disposed(by: disposeBag)
        
        loginViewModel.isValid.subscribe (onNext : { isValid in
            self.validationLabel.text = isValid ? "Enable" : "Not Enable"
            self.validationLabel.textColor = isValid ? .green : .red
            self.loginButton.isEnabled = isValid ? true : false
        }).disposed(by: disposeBag)
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
       loginViewModel.login()
    }
    
}
