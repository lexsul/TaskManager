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
    
    private var status: Bool = false
    
    // MARK: - Public Properties
    
    static let shared = AppModelController()
    var login: String = "testuser"
    var password: String = "su16"
    var loginStatus: [String: Any] = [:]
    var taskList: [Task]? {
        didSet {
            notify(withString: "taskList")
        }
    }
    
    // MARK: - Private Methods
    
    private override init() {
        super.init()
    }
    
    private func urlRequest (url: String, type: String, parameters: [String: Any]) -> [String: Any] {
        var request = URLRequest(url: URL(string: url)!) //!
        let data = try? JSONSerialization.data(withJSONObject: parameters)
        var result: [String: Any] = [:]
        let dispathGroup = DispatchGroup()
        
        request.httpMethod = type
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else { return }
            result = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String : Any]
            dispathGroup.leave()
        }
        dispathGroup.enter()
        task.resume()
        _ = dispathGroup.wait(timeout: DispatchTime(uptimeNanoseconds: 100000))
        return result
    }
    
    // MARK: Public Methods
    func loginRequest () {
        let parameters: [String: Any] = [ "username": login,
                                          "password": password ]
        let url = Constansts.domen + Constansts.apiLogin
        loginStatus = urlRequest(url: url, type: Constansts.methodPost, parameters: parameters)
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

