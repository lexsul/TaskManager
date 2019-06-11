//
//  AppModelController.swift
//  TaskManager
//
//  Created by Сулейманов Алексей on 06.06.2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

struct Task: Decodable {
    let id: Int
    let title: String
    let tag: [String]
    let dateCreate: String
}

struct Profile: Decodable {
    let username: String?
    let phone: String?
    let email: String?
    let fullname: String?
    let dateOfBirth: String?
}

struct Status: Decodable {
    let status: String
    let data: Profile?
    let message: String?
}

class AppModelController: NSObject, Subject{
    
    // MARK : Subject, Observer
    
    var observerCollection = NSMutableSet()
    
    func add(observer: PropertyObserver) {
        observerCollection.add(observer)
    }
    func remove(observer: PropertyObserver) {
        observerCollection.remove(observer)
    }
    func notify(withString string: String) {
        for observer in observerCollection{
            (observer as! PropertyObserver).didGet(newTask: string)
        }
    }
    
    // MARK: - Private Type
    
    private enum Constansts {
        static let methodPost = "POST"
        static let methodGet = "GET"
        static let domen = "http://188.120.233.247:83"
        static let apiLogin = "/api/User/Login"
        static let apiTask = "/api/Task"
        static let apiGetFile = "/api/Task/GetFile"
    }
    
    
    // MARK: - Privare Properties
    
    
    
    // MARK: - Public Properties
    
    var pin: String?
    
    var status: Status? {
        didSet {
            notify(withString: "status")
        }
    }
    
    static let shared = AppModelController()
    
    var taskList: [Task]? {
        didSet {
            notify(withString: "taskList")
        }
    }
    
    // MARK: - Private Methods
    
    private override init() {
        super.init()
    }

    // MARK: Public Methods
    
    func loginRequest (login: String, password: String) {
        
        let parameters: [String: Any] = [ "username": login,
                                          "password": password ]
        let dataRequest = try? JSONSerialization.data(withJSONObject: parameters)
        let url = Constansts.domen + Constansts.apiLogin
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = Constansts.methodPost
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = dataRequest
        
        let task = URLSession.shared.dataTask(with: request) { [weak self]
            data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else { return }
            do {
                self?.status = try JSONDecoder().decode(Status.self, from: data)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func taskListRequest () {
        let url = Constansts.domen + Constansts.apiTask
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = Constansts.methodGet
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { [weak self]
            data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else { return }
            do {
                self?.taskList = try JSONDecoder().decode([Task].self, from: data)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

