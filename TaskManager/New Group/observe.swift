//
//  observe.swift
//  TaskManager
//
//  Created by Сулейманов Алексей on 11.06.2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

protocol PropertyObserver{
    func didGet(newTask task: String)
}

protocol Subject{
    func add(observer: PropertyObserver)
    func remove(observer: PropertyObserver)
    func notify(withString string: String)
}
