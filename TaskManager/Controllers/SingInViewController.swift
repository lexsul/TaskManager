//
//  SingInViewController.swift
//  TaskManager
//
//  Created by Сулейманов Алексей on 06.06.2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class SingInViewController: UIViewController {
    
    // MARK: - Private Properties
    
    
    
    @IBOutlet weak private var loginTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var singInButton: UIButton!
    
    // MARK: - Public Properties
    
    var appModelController: AppModelController!
    
    // MARK: - Private Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func TouchSingInButton(_ sender: Any) {
        appModelController.login = loginTextField.text ?? ""
        appModelController.password = passwordTextField.text ?? ""
        appModelController.loginRequest()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
