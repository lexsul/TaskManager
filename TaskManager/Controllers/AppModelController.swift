//
//  AppModelController.swift
//  TaskManager
//
//  Created by Сулейманов Алексей on 06.06.2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

class AppModelController: NSObject {
    
    // MARK: - Private Type
    
    enum Constansts {
        static let methodPost = "POST"
        static let methodGet = "GET"
        static let domen = "http://188.120.233.247:83"
        static let apiLogin = "/api/User/Login"
        static let apiTask = "/api/Task"
        static let apiGetFile = "/api/Task/GetFile"
    }
    
    
    // MARK: - Privare Properties
    
    // MARK: - Public Properties
    
    var login: String = "testuser"
    var password: String = "su16"
    
    // MARK: - Private Methods
    
    private func urlRequest (url: String, type: String, parameters: [String: Any]) {
        var request = URLRequest(url: URL(string: url)!) //!
        let data = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpMethod = type
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            print(response!)
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    // MARK: Public Methods
    
    func loginRequest () {
        let parameters: [String: Any] = [ "username": login,
                                          "password": password]
        let url = Constansts.domen + Constansts.apiLogin
        urlRequest(url: url, type: Constansts.methodPost, parameters: parameters)
    }
    
    func taskListRequest () {
        let parameters: [String: Any] = [:]
        let url = Constansts.domen + Constansts.apiTask
        urlRequest(url: url, type: Constansts.methodGet, parameters: parameters)
    }
    
    
}

