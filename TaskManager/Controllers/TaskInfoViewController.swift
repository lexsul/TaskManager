//
//  TaskInfoViewController.swift
//  TaskManager
//
//  Created by Сулейманов Алексей on 07.06.2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class TaskInfoViewController: UIViewController {
    
    // MARK : Public Properties
    
    var appModelController: AppModelController!
    var taskId: Int = 0
    
    // MARK: - Private Priperties
    
    private var task : Task?

    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tagLabel: UILabel!
    @IBOutlet private weak var dateCreateLabel: UILabel!

    // MARK: - Private Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        task = appModelController.taskList[taskId]
        
        idLabel.text = String(task?.id ?? 0)
        titleLabel.text = task?.title ?? ""
        tagLabel.text = task?.tag.joined(separator: ";")
        dateCreateLabel.text = task?.dateCreate.description
    }
}
