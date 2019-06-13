//
//  SingInViewController.swift
//  TaskManager
//
//  Created by Сулейманов Алексей on 06.06.2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class SingInViewController: UIViewController, PropertyObserver {
    
    func didGet(newTask task: String) {
        guard task == "status" else { return }
        signIn()
    }
    // MARK: - Private Properties
    
    @IBOutlet weak private var loginTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var singInButton: UIButton!
    @IBOutlet weak private var pinTextField: UITextField!
    
    var alertController: UIAlertController?
    
    // MARK: - Public Properties
    
    var appModelController: AppModelController!
    
    // MARK: - Private Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertControllerSetup()
        appModelController.add(observer: self)
    }
    
    @IBAction private func TouchSingInButton(_ sender: Any) {
  
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        appModelController.loginRequest(login: login, password: password)
    }
    
    private func signIn() {
        let status = appModelController.status?.status
        guard status == "ok" else { return }
        
        DispatchQueue.main.async {
            if self.appModelController.pin == nil {
                self.present(self.alertController!, animated: true , completion: nil)
            }
            let taskTableViewController = TaskTableViewController()
            taskTableViewController.appModelController = self.appModelController
            self.addChild(taskTableViewController)
            self.navigationController?.performSegue(withIdentifier: "taskListSegue", sender: Any?.self)
        }
    }
    
    private func alertControllerSetup() {
        alertController = UIAlertController(title: "PIN", message: "Insert Pin!", preferredStyle: .alert)
        alertController?.addTextField { textField in
            textField.placeholder = "PIN"
            textField.isSecureTextEntry = true
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard
                let alertController = alertController,
                let textField = alertController.textFields?.first
                else {return}
         self.appModelController.pin = textField.text
        }
        
        let canselAction = UIAlertAction(title: "cansel", style: .cancel, handler: nil)
        alertController?.addAction(okAction)
        alertController?.addAction(canselAction)
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
