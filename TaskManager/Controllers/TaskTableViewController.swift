//
//  TaskTableViewController.swift
//  TaskManager
//
//  Created by Сулейманов Алексей on 07.06.2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController, PropertyObserver {
    
    // MARK: PropertyObserver
    
    func didGet(newTask task: String) {
        guard task == "taskList" else { return }
        updateTask()
    }
    
    // MARK : Public Properties
    
    var appModelController: AppModelController! = AppModelController.shared
    
    // MARK : Private Properties
    
    private var taskList : [Task]? 
 
    // MARK : Private Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appModelController.add(observer: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appModelController.taskListRequest()
        updateTask()
    }

    private func updateTask() {
        taskList = appModelController.taskList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = taskList?[indexPath.row].title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let indexRow = tableView.indexPath(for: cell)?.row
            let destinationViewController = segue.destination as? TaskInfoViewController
            destinationViewController?.appModelController = appModelController
            destinationViewController?.taskId = indexRow ?? 0
        }
    }
}
