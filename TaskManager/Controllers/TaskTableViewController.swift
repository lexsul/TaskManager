//
//  TaskTableViewController.swift
//  TaskManager
//
//  Created by Сулейманов Алексей on 07.06.2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    // MARK : Public Properties
    
    var appModelController: AppModelController!
    
    // MARK : Private Properties
    
    private var taskList : [Task]?
 
    // MARK : Private Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appModelController.taskListRequest()
        taskList = appModelController.taskList
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = taskList?[indexPath.row].title
        return cell
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
