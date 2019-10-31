//
//  RxLoginViewModel.swift
//  LoginWithRxSwift
//
//  Created by Ameera Damsika on 9/3/19.
//  Copyright © 2019 Ameera Damsika. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
class RxLoginViewModel {
    
    private var user = User()
    var emailText = BehaviorSubject(value: "")
    var passwordText = BehaviorSubject(value: "")
    
    var username :String {
        return user.username
    }
    
    var password : String {
        return user.password
    }
    
    var isValid:Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(),passwordText.asObservable()) { email , password in
            self.isValidEmail(emailStr: email) && password.count > 3
        }
    }
    
    func login() {
        print("Login pressed")
    }
    
    func updateUserCredentials(username:String! , password:String!) {
        user.username = username
        user.password = password
    }
    
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
}

